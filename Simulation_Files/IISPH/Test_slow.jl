# Add neccessary packages
using TrixiParticles
using OrdinaryDiffEq
using ThreadPinning

# H is equal to 0.6 and fluid particle spacing is H / 40 = 0.6 / 40 = 0.015
# We want the fluid particle spacing to be equal to H / 160 = 0.00375
#fluid_particle_spacing = 0.00375
fluid_particle_spacing = 0.015

# Load setup from dam break example
trixi_include(@__MODULE__,
              joinpath(examples_dir(), "fluid", "dam_break_2d.jl"),
              fluid_particle_spacing=fluid_particle_spacing,
              sol=nothing, ode=nothing)

# This kernel slightly overestimates the density, so we reduce the mass slightly
# to obtain a density slightly below the reference density.
# Otherwise, the fluid will jump slightly at the beginning of the simulation.
tank.fluid.mass .*= 0.995

#=
# Define a GPU-compatible neighborhood search
min_corner = minimum(tank.boundary.coordinates, dims=2)
max_corner = maximum(tank.boundary.coordinates, dims=2)
cell_list = FullGridCellList(; min_corner, max_corner)
neighborhood_search = GridNeighborhoodSearch{2}(; cell_list)
=#

# Change the parameters
time_step = 1e-3
min_iterations = 2
max_iterations = 30
max_error = 0.1
omega = 0.5
smoothing_length = 1.0


# Change parameters

# Smoothing kernel
smoothing_kernel = SchoenbergCubicSplineKernel{2}()

# Viscosity
nu = 0.02 * smoothing_length * sound_speed / 8
viscosity_fluid = ViscosityAdami(; nu)

# Boundary Density Calculator
boundary_density_calculator = PressureZeroing()

# Fluid System
fluid_system = ImplicitIncompressibleSPHSystem(tank.fluid, smoothing_kernel,
                                               smoothing_length, fluid_density,
                                               viscosity=viscosity_fluid,
                                               acceleration=(0.0, -gravity),
                                               min_iterations=min_iterations,
                                               max_iterations=max_iterations,
                                               max_error=max_error,
                                               omega=omega,
                                               time_step=time_step)


# Overwrite the saving_callback such that we only get the first and the last time step as
# result
#saving_callback = SolutionSavingCallback(dt=100, prefix=solution_prefix)

# Overwrite the callbacks
callbacks = CallbackSet(info_callback, saving_callback, saving_paper)


# Run the iisph dam break simulation with these changes
trixi_include(@__MODULE__,
              joinpath(examples_dir(), "fluid", "dam_break_2d.jl"),
              fluid_particle_spacing=fluid_particle_spacing,
             #neighborhood_search=neighborhood_search,
              smoothing_length=smoothing_length,
              fluid_system=fluid_system,
              smoothing_kernel=smoothing_kernel,
              viscosity_fluid=viscosity_fluid,
              boundary_density_calculator=boundary_density_calculator,
              tspan=tspan,
              state_equation=nothing,
              callbacks=callbacks,
              time_integration_scheme=SymplecticEuler(), dt=time_step)
