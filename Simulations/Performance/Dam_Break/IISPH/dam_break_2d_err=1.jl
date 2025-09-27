# Add neccessary packages
using TrixiParticles
using OrdinaryDiffEq
using ThreadPinning
pinthreads(:numa)

# H is equal to 0.6 and fluid particle spacing is H / 40 = 0.6 / 40 = 0.015
# We want the fluid particle spacing to be equal to H / 160 = 0.00375
#fluid_particle_spacing = 0.00375
fluid_particle_spacing = 0.015

# Load setup from dam break example
trixi_include(@__MODULE__,
              joinpath(examples_dir(), "fluid", "dam_break_2d_iisph.jl"),
              fluid_particle_spacing=fluid_particle_spacing,
              sol=nothing, ode=nothing)

# This kernel slightly overestimates the density, so we reduce the mass slightly
# to obtain a density slightly below the reference density.
# Otherwise, the fluid will jump slightly at the beginning of the simulation.
tank.fluid.mass .*= 0.995

# Define a GPU-compatible neighborhood search
min_corner = minimum(tank.boundary.coordinates, dims=2)
max_corner = maximum(tank.boundary.coordinates, dims=2)
cell_list = FullGridCellList(; min_corner, max_corner)
neighborhood_search = GridNeighborhoodSearch{2}(; cell_list)

boundary_density_calculator = PressureZeroing()

# Change the parameters
time_step = 1e-3
min_iterations = 2
omega = 0.4
density_error = 1
smoothing_length = 1.0


# Overwrite the saving_callback such that we only get the first and the last time step as
# result
saving_callback = SolutionSavingCallback(dt=100, prefix=solution_prefix)

# Overwrite the callbacks
callbacks = CallbackSet(info_callback, saving_callback, saving_paper)

# Run the iisph dam break simulation with these changes
trixi_include(@__MODULE__,
              joinpath(examples_dir(), "fluid", "dam_break_2d_iisph.jl"),
              neighborhood_search=neighborhood_search,
              boundary_density_calculator=boundary_density_calculator,
              callbacks=callbacks,
              time_step=time_step,
              min_iterations=min_iterations,
              omega=omega,
              density_error=density_error,
              smoothing_length=smoothing_length)