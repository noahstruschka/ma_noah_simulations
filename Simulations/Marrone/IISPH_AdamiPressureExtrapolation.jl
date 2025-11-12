# Add neccessary packages
using TrixiParticles
using OrdinaryDiffEq
using ThreadPinning
pinthreads(:numa)

H = 0.6
resolution = 320

fluid_particle_spacing = H / resolution

# Load setup from dam break example
trixi_include(@__MODULE__,
              joinpath(examples_dir(), "fluid", "dam_break_2d.jl"),
              fluid_particle_spacing=fluid_particle_spacing,
              sol=nothing, ode=nothing)

# IISPH doesn't require a large compact support like WCSPH and performs worse with a typical
# smoothing length used for WCSPH.
smoothing_length =  1.25 * fluid_particle_spacing
smoothing_kernel = SchoenbergCubicSplineKernel{2}()
# This kernel slightly overestimates the density, so we reduce the mass slightly
# to obtain a density slightly below the reference density.
# Otherwise, we will get a "pressure explosion", and the fluid will jump slightly at the
# beginning of the simulation.
tank.fluid.mass .*= 0.99

# Calculate kinematic viscosity for the viscosity model.
# Only ViscosityAdami and ViscosityMorris can be used for IISPH simulations since they don't
# require a speed of sound.
alpha = 0.02
nu = alpha * smoothing_length * sound_speed / 8
viscosity = ViscosityAdami(; nu)

# IISPH parameters
time_step = 0.0002
omega = 0.2
min_iterations = 2
max_iterations = 100
max_error = 0.1

# Use IISPH as fluid system
fluid_system = ImplicitIncompressibleSPHSystem(tank.fluid, smoothing_kernel,
                                               smoothing_length, fluid_density,
                                               viscosity=viscosity,
                                               acceleration=(0.0, -gravity),
                                               min_iterations=min_iterations,
                                               max_iterations=max_iterations,
                                               max_error=max_error,
                                               omega=omega,
                                               time_step=time_step)

boundary_density_calculator=AdamiPressureExtrapolation()


# ==========================================================================================
# Define a GPU-compatible neighborhood search
min_corner = minimum(tank.boundary.coordinates, dims=2)
max_corner = maximum(tank.boundary.coordinates, dims=2)
cell_list = FullGridCellList(; min_corner, max_corner)
neighborhood_search = GridNeighborhoodSearch{2}(; cell_list, update_strategy=ParallelUpdate())

# ==========================================================================================
# Overwrite the saving_callback such that we only get the first and the last time step as
# result
saving_callback = SolutionSavingCallback(dt=100, prefix=solution_prefix)
# Save at certain timepoints which allows comparison to the results of Marrone et al.,
# i.e. t(g/H)^(1/2) = (1.5, 2.36, 3.0, 5.7, 6.45).
# Note that the images in Marrone et al. are obtained with `particles_per_height = 320`.

saving_paper = SolutionSavingCallback(save_times=[0.0, 1.5, 2.36, 3.0, 5.7, 6.45] ./
                                                 sqrt(gravity / H), output_directory="Output/Marrone/IISPH/AdamiPressureExtrapolation",
                                      prefix="IISPH_AdamiPressureExtrapolation_Marrone")

# Overwrite the callbacks
callbacks = CallbackSet(info_callback, saving_callback, saving_paper)

# Run the dam break simulation with these changes
trixi_include(@__MODULE__,
              joinpath(examples_dir(), "fluid", "dam_break_2d.jl"),
              fluid_particle_spacing=fluid_particle_spacing,
              smoothing_kernel=smoothing_kernel,
              smoothing_length=smoothing_length,
              viscosity_fluid=viscosity,
              fluid_system=fluid_system,
              state_equation=nothing,
              boundary_density_calculator=boundary_density_calculator,
              neighborhood_search=neighborhood_search,
              callbacks=callbacks,
              time_integration_scheme=SymplecticEuler(), dt=time_step)
