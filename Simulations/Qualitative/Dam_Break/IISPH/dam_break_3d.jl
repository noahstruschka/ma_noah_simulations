# Add neccessary packages
using TrixiParticles
using OrdinaryDiffEq
using ThreadPinning
pinthreads(:numa)

# H is equal to 0.6 and fluid particle spacing is H / 40 = 0.6 / 40 = 0.015
# For the 3D simulation We want the fluid particle spacing to be equal to H / 80 = 0.0075
#fluid_particle_spacing = 0.0075
fluid_particle_spacing = 0.015

# Load setup from dam break example
trixi_include(@__MODULE__,
              joinpath(examples_dir(), "fluid", "dam_break_3d.jl"),
              sol=nothing, ode=nothing)

# IISPH doesn't require a large compact support like WCSPH and performs worse with a typical
# smoothing length used for WCSPH.
smoothing_kernel = SchoenbergCubicSplineKernel{2}()

# This kernel slightly overestimates the density, so we reduce the mass slightly
# to obtain a density slightly below the reference density.
# Otherwise, the fluid will jump slightly at the beginning of the simulation.
tank.fluid.mass .*= 0.995

# Define a GPU-compatible neighborhood search
min_corner = minimum(tank.boundary.coordinates, dims=2)
max_corner = maximum(tank.boundary.coordinates, dims=2)
cell_list = FullGridCellList(; min_corner, max_corner)
neighborhood_search = GridNeighborhoodSearch{2}(; cell_list)

# Change the boundary density calculator
boundary_density_calculator = PressureZeroing()

# Change the parameters
time_step = 1e-3 # TODO
min_iterations = 2 # TODO
max_iterations = 30 # TODO
omega = 0.4 # TODO
density_error = 0.1 # TODO
smoothing_length = 1.0 # TODO


# Overwrite the saving_callback such that we only get the first and the last time step as
# result
saving_callback = SolutionSavingCallback(dt=100, prefix=solution_prefix)

# Overwrite the callbacks
callbacks = CallbackSet(info_callback, saving_callback, saving_paper)

# Use IISPH as fluid system
time_step = 1e-3
fluid_system = ImplicitIncompressibleSPHSystem(tank.fluid, smoothing_kernel,
                                               smoothing_length, fluid_density,
                                               viscosity=ViscosityAdami(nu=nu),
                                               acceleration=(0.0, -gravity),
                                               min_iterations=min_iterations,
                                               max_iterations=max_iterations,
                                               omega=omega,
                                               max_error=max_error,
                                               time_step=time_step)

# Run the dam break simulation with these changes
trixi_include(@__MODULE__,
              joinpath(examples_dir(), "fluid", "dam_break_3d.jl"),
              viscosity_fluid=ViscosityAdami(nu=nu),
              smoothing_kernel=smoothing_kernel,
              smoothing_length=smoothing_length,
              fluid_system=fluid_system,
              boundary_density_calculator=PressureZeroing(),
              tspan=tspan,
              state_equation=nothing,
              callbacks=CallbackSet(info_callback, saving_callback),
              time_integration_scheme=SymplecticEuler(), dt=time_step,
              sol=sol, ode=ode, neighborhood_search=neighborhood_search)