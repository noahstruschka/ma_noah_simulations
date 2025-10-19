# ==========================================================================================
# 3D Dam Break Simulation
#
# This example sets up a 3D dam break simulation using a weakly compressible SPH scheme.
# It is analogous to the 2D dam break (`dam_break_2d.jl`) but extended to three dimensions.
# ==========================================================================================

using TrixiParticles
using OrdinaryDiffEq

# ==========================================================================================
# ==== Resolution
H = 0.6
W = 2 * H

resolution = 40

fluid_particle_spacing = H / resolution

# Change spacing ratio to 3 and boundary layers to 1 when using Monaghan-Kajtar boundary model
boundary_layers = 4
spacing_ratio = 1

boundary_particle_spacing = fluid_particle_spacing / spacing_ratio

# ==========================================================================================
# ==== Experiment Setup
gravity = 9.81
tspan = (0.0, 5.7 / sqrt(gravity))

# Boundary geometry and initial fluid particle positions
initial_fluid_size = (W, H, 1.0)
tank_size = (floor(5.366 / boundary_particle_spacing) * boundary_particle_spacing, 4.0, 1.0)

fluid_density = 1000.0
sound_speed = 20 * sqrt(gravity * initial_fluid_size[2])

state_equation = StateEquationCole(; sound_speed, reference_density=fluid_density,
                                   exponent=1, clip_negative_pressure=false)

tank = RectangularTank(fluid_particle_spacing, initial_fluid_size, tank_size, fluid_density,
                       n_layers=boundary_layers, spacing_ratio=spacing_ratio,
                       acceleration=(0.0, -gravity, 0.0), state_equation=nothing)

# ==========================================================================================
# ==== Fluid
# IISPH doesn't require a large compact support like WCSPH and performs worse with a typical
# smoothing length used for WCSPH.
smoothing_length = 1.0 * fluid_particle_spacing
smoothing_kernel = SchoenbergCubicSplineKernel{3}()
# This kernel slightly overestimates the density, so we reduce the mass slightly
# to obtain a density slightly below the reference density.
# Otherwise, the fluid will jump slightly at the beginning of the simulation.
println(maximum(tank.fluid.density))
tank.fluid.mass .*= 0.995

alpha = 0.02
nu = alpha * smoothing_length * sound_speed / 8
viscosity = ViscosityAdami(; nu)

# IISPH parameters
time_step = 0.0002
omega = 0.4
min_iterations = 2
max_iterations = 20
max_error = 0.1

# Use IISPH as fluid system
fluid_system = ImplicitIncompressibleSPHSystem(tank.fluid, smoothing_kernel,
                                               smoothing_length, fluid_density,
                                               viscosity=viscosity,
                                               acceleration=(0.0, -gravity, 0.0),
                                               min_iterations=min_iterations,
                                               max_iterations=max_iterations,
                                               max_error=max_error,
                                               omega=omega,
                                               time_step=time_step)


# ==========================================================================================
# ==== Boundary
boundary_density_calculator = PressureMirroring()
boundary_model = BoundaryModelDummyParticles(tank.boundary.density, tank.boundary.mass,
                                             state_equation=state_equation,
                                             boundary_density_calculator,
                                             smoothing_kernel, smoothing_length)

boundary_system = WallBoundarySystem(tank.boundary, boundary_model)


# ==========================================================================================
# Define a GPU-compatible neighborhood search
min_corner = minimum(tank.boundary.coordinates, dims=2)
max_corner = maximum(tank.boundary.coordinates, dims=2)
cell_list = FullGridCellList(; min_corner, max_corner)
neighborhood_search = GridNeighborhoodSearch{2}(; cell_list, update_strategy=ParallelUpdate())

# ==========================================================================================
# ==== Simulation
semi = Semidiscretization(fluid_system, boundary_system,
                            #neighborhood_search=neighborhood_search,
                          parallelization_backend=PolyesterBackend())
ode = semidiscretize(semi, tspan)

info_callback = InfoCallback(interval=100)
saving_callback = SolutionSavingCallback(dt=0.02, prefix="")
callbacks = CallbackSet(info_callback, saving_callback)


time_integration_scheme = SymplecticEuler()
sol = solve(ode, time_integration_scheme,
            dt=time_step, # This is overwritten by the stepsize callback
            save_everystep=false, callback=callbacks);