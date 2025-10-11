using TrixiParticles
using OrdinaryDiffEq
using ThreadPinning

# Size parameters
H = 0.6
W = 2 * H

# ==========================================================================================
# ==== Resolution
fluid_particle_spacing = H / 40

# Change spacing ratio to 3 and boundary layers to 1 when using Monaghan-Kajtar boundary model
boundary_layers = 4
spacing_ratio = 1

boundary_particle_spacing = fluid_particle_spacing / spacing_ratio

# ==========================================================================================
# ==== Experiment Setup
gravity = 9.81

tspan = (0.0, 5.7 / sqrt(gravity / H))

# Boundary geometry and initial fluid particle positions
initial_fluid_size = (W, H)
tank_size = (floor(5.366 * H / boundary_particle_spacing) * boundary_particle_spacing, 4.0)

fluid_density = 1000.0
sound_speed = 20 * sqrt(gravity * H)
state_equation = nothing # StateEquationCole(; sound_speed, reference_density=fluid_density,
                                  # exponent=1, clip_negative_pressure=false)

tank = RectangularTank(fluid_particle_spacing, initial_fluid_size, tank_size, fluid_density,
                       n_layers=boundary_layers, spacing_ratio=spacing_ratio,
                       acceleration=(0.0, -gravity), state_equation=state_equation)

# ==========================================================================================
# ==== Fluid
smoothing_length = 1.0 * fluid_particle_spacing
smoothing_kernel = SchoenbergCubicSplineKernel{2}()

alpha = 0.02
nu = alpha * smoothing_length * sound_speed / 8
viscosity_fluid = ViscosityAdami(; nu)

# Use IISPH as fluid system
time_step = 1e-3
omega = 0.4
fluid_system = ImplicitIncompressibleSPHSystem(tank.fluid, smoothing_kernel,
                                               smoothing_length, fluid_density,
                                               viscosity=viscosity_fluid,
                                               acceleration=(0.0, -gravity),
                                               min_iterations=2,
                                               max_iterations=30,
                                               omega=omega,
                                               time_step=time_step)

# ==========================================================================================
# ==== Boundary
boundary_density_calculator = PressureZeroing()
viscosity_wall = nothing
# For a no-slip boundary condition, define a wall viscosity:
# viscosity_wall = viscosity_fluid
boundary_model = BoundaryModelDummyParticles(tank.boundary.density, tank.boundary.mass,
                                             state_equation=state_equation,
                                             boundary_density_calculator,
                                             smoothing_kernel, smoothing_length,
                                             correction=nothing,
                                             reference_particle_spacing=0,
                                             viscosity=viscosity_wall)

boundary_system = WallBoundarySystem(tank.boundary, boundary_model,
                                     adhesion_coefficient=0.0)

# ==========================================================================================
# ==== Simulation
# `nothing` will automatically choose the best update strategy. This is only to be able
# to change this with `trixi_include`.
semi = Semidiscretization(fluid_system, boundary_system,
                          neighborhood_search=GridNeighborhoodSearch{2}(update_strategy=nothing),
                          parallelization_backend=PolyesterBackend())
ode = semidiscretize(semi, tspan)

info_callback = InfoCallback(interval=100)

solution_prefix = ""
saving_callback = SolutionSavingCallback(dt=0.02, prefix=solution_prefix)

# This can be overwritten with `trixi_include`
extra_callback = nothing
extra_callback2 = nothing

use_reinit = false
density_reinit_cb = use_reinit ?
                    DensityReinitializationCallback(semi.systems[1], interval=10) :
                    nothing
# stepsize_callback = StepsizeCallback(cfl=0.9)

callbacks = CallbackSet(info_callback, saving_callback, extra_callback,
                        extra_callback2, density_reinit_cb)

time_integration_scheme = SymplecticEuler()
sol = solve(ode, time_integration_scheme,
            dt=time_step, # This is overwritten by the stepsize callback
            save_everystep=false, callback=callbacks);
