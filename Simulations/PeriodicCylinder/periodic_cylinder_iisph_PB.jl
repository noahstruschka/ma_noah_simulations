# Add neccessary packages
using TrixiParticles
using OrdinaryDiffEq
using ThreadPinning
pinthreads(:numa)


# Load setup from dam break example
trixi_include(@__MODULE__,
              joinpath(examples_dir(), "fluid", "periodic_array_of_cylinders_2d.jl"),
              sol=nothing, ode=nothing)

# IISPH doesn't require a large compact support like WCSPH and performs worse with a typical
# smoothing length used for WCSPH.
smoothing_length =  1.25 * particle_spacing
smoothing_kernel = SchoenbergCubicSplineKernel{2}()
# This kernel slightly overestimates the density, so we reduce the mass slightly
# to obtain a density slightly below the reference density.
# Otherwise, we will get a "pressure explosion", and the fluid will jump slightly at the
# beginning of the simulation.
fluid.mass .*= 0.99

# Calculate kinematic viscosity for the viscosity model.
# Only ViscosityAdami and ViscosityMorris can be used for IISPH simulations since they don't
# require a speed of sound.

# IISPH parameters
time_step = 0.001
omega = 0.4
min_iterations = 2
max_iterations = 100
max_error = 0.1

# Use IISPH as fluid system
fluid_system = ImplicitIncompressibleSPHSystem(fluid, smoothing_kernel,
                                               smoothing_length, fluid_density,
                                               viscosity=ViscosityAdami(; nu),
                                               acceleration=(acceleration_x, 0.0),
                                               min_iterations=min_iterations,
                                               max_iterations=max_iterations,
                                               max_error=max_error,
                                               omega=omega,
                                               time_step=time_step)

boundary_model = BoundaryModelDummyParticles(boundary.density, boundary.mass,
                                             PressureBoundaries(;time_step=time_step, omega=omega),
                                             viscosity=ViscosityAdami(; nu),
                                             smoothing_kernel, smoothing_length)

boundary_system = WallBoundarySystem(boundary, boundary_model)
# ==========================================================================================
# ==== Simulation
periodic_box = PeriodicBox(min_corner=[0.0, -tank_size[2]],
                           max_corner=[tank_size[1], 2 * tank_size[2]])
semi = Semidiscretization(fluid_system, boundary_system,
                          neighborhood_search=GridNeighborhoodSearch{2}(; periodic_box))

ode = semidiscretize(semi, tspan)

saving_paper = SolutionSavingCallback(save_times=[0.0, 0.5, 1.5, 2.5, 5.0], output_directory="Output/Cylinder/IISPH/PressureBoundaries",
                                      prefix="IISPH_PressureBoundaries_Cylinder")


info_callback = InfoCallback(interval=100)

saving_callback = SolutionSavingCallback(dt=0.5, prefix="")

callbacks = CallbackSet(info_callback, saving_callback, UpdateCallback(), saving_paper)

# Use a Runge-Kutta method with automatic (error based) time step size control
sol = solve(ode, SymplecticEuler(),
            dt=time_step,
            save_everystep=false, callback=callbacks);

# Run the dam break simulation with these changes
trixi_include(@__MODULE__,
              joinpath(examples_dir(), "fluid", "periodic_array_of_cylinders_2d.jl"),
              smoothing_kernel=smoothing_kernel,
              smoothing_length=smoothing_length,
              fluid_system=fluid_system,
              sol=sol)
