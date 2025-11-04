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
smoothing_length = 2 * particle_spacing
smoothing_kernel = WendlandC2Kernel{2}()
# Calculate kinematic viscosity for the viscosity model.
# Only ViscosityAdami and ViscosityMorris can be used for IISPH simulations since they don't
# require a speed of sound.

# IISPH parameters
state_equation = StateEquationCole(; sound_speed, reference_density=fluid_density,
                                   exponent=1, clip_negative_pressure=false)


smoothing_length = 2 * particle_spacing
smoothing_kernel = WendlandC2Kernel{2}()

fluid_density_calculator = ContinuityDensity()

shifting = TransportVelocityAdami(background_pressure=pressure)

fluid_system = WeaklyCompressibleSPHSystem(fluid, fluid_density_calculator,
                                           state_equation, smoothing_kernel,
                                           smoothing_length, viscosity=ViscosityAdami(; nu),
                                           density_diffusion=nothing,
                                           acceleration=(acceleration_x, 0.0), correction=nothing,
                                           pressure_acceleration=TrixiParticles.tensile_instability_control,
                                           surface_tension=nothing,
                                           shifting_technique=shifting,
                                           reference_particle_spacing=0)

boundary_model = BoundaryModelDummyParticles(boundary.density, boundary.mass,
                                             state_equation=state_equation,
                                             AdamiPressureExtrapolation(),
                                             viscosity=ViscosityAdami(; nu),
                                             smoothing_kernel, smoothing_length)

boundary_system = WallBoundarySystem(boundary, boundary_model,
                                     adhesion_coefficient=0.0)
# ==========================================================================================
# ==== Simulation
periodic_box = PeriodicBox(min_corner=[0.0, -tank_size[2]],
                           max_corner=[tank_size[1], 2 * tank_size[2]])
semi = Semidiscretization(fluid_system, boundary_system,
                          neighborhood_search=GridNeighborhoodSearch{2}(; periodic_box))

ode = semidiscretize(semi, tspan)

saving_paper = SolutionSavingCallback(save_times=[0.0, 0.5, 1.5, 2.5, 5.0], output_directory="Output/Cylinder/WCSPH/Shifting_TIC",
                                      prefix="WCSPH_Shifting_TIC_Cylinder")


info_callback = InfoCallback(interval=100)

saving_callback = SolutionSavingCallback(dt=0.5, prefix="")

callbacks = CallbackSet(info_callback, saving_callback, UpdateCallback(), saving_paper)

# Use a Runge-Kutta method with automatic (error based) time step size control
sol = solve(ode, RDPK3SpFSAL49(),
            abstol=1e-8, # Default abstol is 1e-6 (may need to be tuned to prevent boundary penetration)
            reltol=1e-4, # Default reltol is 1e-3 (may need to be tuned to prevent boundary penetration)
            dtmax=1e-2, # Limit stepsize to prevent crashing
            save_everystep=false, callback=callbacks);

# Run the dam break simulation with these changes
trixi_include(@__MODULE__,
              joinpath(examples_dir(), "fluid", "periodic_array_of_cylinders_2d.jl"),
              smoothing_kernel=smoothing_kernel,
              smoothing_length=smoothing_length,
              fluid_system=fluid_system,
              boundary_model=boundary_model,
              boundary_system=boundary_system,
              sol=sol)
