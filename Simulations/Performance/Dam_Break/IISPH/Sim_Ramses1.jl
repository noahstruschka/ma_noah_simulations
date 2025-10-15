# Add neccessary packages
using TrixiParticles
using OrdinaryDiffEq
using Plots
using ThreadPinning
pinthreads(:numa)


folder = "Simulations"
simulation = "Dam_Break"
method = "IISPH"

# Load the iisph example
trixi_include(joinpath(pwd(), folder, "Performance", simulation, method, "default.jl"), sol=nothing, ode=nothing)

# =========================================================================================
# Change Resolution
# fluid particle = H / resolution
# H = 0.6 fix
# We want the fluid particle spacing to be equal to 0.00375 which is the case for resolution = 160

# resolution = 40 # 3200 fluid particles
# resolution = 60 # 7200 fluid particles
# resolution = 80 # 12.800 fluid particles
# resolution = 160 # ?? fluid particles
resolution = 320 # 204800 fluid particles

fluid_particle_spacing = H / resolution


# ==========================================================================================
# Define a GPU-compatible neighborhood search
min_corner = minimum(tank.boundary.coordinates, dims=2)
max_corner = maximum(tank.boundary.coordinates, dims=2)
cell_list = FullGridCellList(; min_corner, max_corner)
neighborhood_search = GridNeighborhoodSearch{2}(; cell_list)


# ==========================================================================================
# Overwrite the saving_callback such that we only get the first and the last time step as
# result
saving_callback = SolutionSavingCallback(dt=100, prefix=solution_prefix)
# Save at certain timepoints which allows comparison to the results of Marrone et al.,
# i.e. t(g/H)^(1/2) = (1.5, 2.36, 3.0, 5.7, 6.45).
# Note that the images in Marrone et al. are obtained with `particles_per_height = 320`.
saving_paper = SolutionSavingCallback(save_times=[0.0, 1.5, 2.36, 3.0, 5.7, 6.45] ./
                                                 sqrt(gravity / H),
                                      prefix="marrone_times")

# Overwrite the callbacks
callbacks = CallbackSet(info_callback, saving_callback, saving_paper)


# ==========================================================================================
# Change the parameters
alpha = 0.02

smoothing_length = 1.0 * fluid_particle_spacing
smoothing_kernel = SchoenbergCubicSplineKernel{2}()

boundary_density_calculator = PressureZeroing()


# IISPH parameters
time_step = 0.0004
omega = 0.4
min_iterations = 2
max_iterations = 30
max_error = 0.1



# Run simulation with updated parameters
trixi_include(joinpath(pwd(), folder, "Performance", simulation, method, "default.jl"),
                            resolution=resolution,
                            neighborhood_search=neighborhood_search,
                            callbacks=callbacks,
                            alpha=alpha,
                            smoothing_length=smoothing_length,
                            smoothing_kernel=smoothing_kernel,
                            boundary_density_calculator=boundary_density_calculator,
                            time_step=time_step,
                            omega=omega,
                            min_iterations=min_iterations,
                            max_iterations=max_iterations,
                            max_error=max_error)

boundary_dict = Dict(
    PressureZeroing => "PZ",
    PressureMirroring => "PM",
    AdamiPressureExtrapolation => "APE",
    BernoulliPressureExtrapolation => "BPE",
   # PressureBoundaries => "PB"
)
ic = vtk2trixi("out/marrone_times_fluid_1_4948.vtu")
velocity_magnitude = sqrt.(sum(ic.velocity.^2, dims=1))
plt2 = plot(ic, zcolor=velocity_magnitude', color=:coolwarm)

plt1 = plot(sol)
file_name = splitext(basename(@__FILE__))[1]
path = joinpath(pwd(), "Results", "Performance", simulation, method, file_name)
density_calculator_boundary = boundary_dict[typeof(boundary_density_calculator)]
plot_name1 = file_name * "_" * string(resolution) * "_" * density_calculator_boundary
plot_name2 = plot_name1 * "_"
full_path1 = joinpath(path, plot_name1)
full_path2 = joinpath(path, plot_name2)
savefig(plt1, full_path1)
savefig(plt2, full_path2)