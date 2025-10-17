# Add neccessary packages
using TrixiParticles
using OrdinaryDiffEq
using ThreadPinning
using Plots
pinthreads(:numa)

simulation = "Dam_Break"
method = "WCSPH"
# Load the iisph example
trixi_include(joinpath(pwd(), "Simulations", "Performance", simulation, method, "default.jl"), sol=nothing, ode=nothing)

# =========================================================================================
# Change Resolution
# fluid particle = H / resolution
# H = 0.6 fix
# We want the fluid particle spacing to be equal to 0.00375 which is the case for resolution = 160

# resolution = 40
# resolution = 60
# resolution = 80
# resolution = 160
resolution = 320

fluid_particle_spacing = H / resolution


# ==========================================================================================
# Define a GPU-compatible neighborhood search
min_corner = minimum(tank.boundary.coordinates, dims=2)
max_corner = maximum(tank.boundary.coordinates, dims=2)
cell_list = FullGridCellList(; min_corner, max_corner)
neighborhood_search = GridNeighborhoodSearch{2}(; cell_list, update_strategy=ParallelUpdate())


# ==========================================================================================
# Change the parameters
alpha = 0.02
smoothing_length = 2.0 * fluid_particle_spacing
smoothing_kernel = WendlandC2Kernel{2}()

boundary_density_calculator = AdamiPressureExtrapolation()


# WCSPH parameters
cfl = 1.4
# Use MolteniColagrossi as density diffusion
density_diffusion = DensityDiffusionMolteniColagrossi(delta=0.1)


# ==========================================================================================
# Overwrite the saving_callback such that we only get the first and the last time step as
# result
saving_callback = SolutionSavingCallback(dt=100, prefix=solution_prefix)
stepsize_callback = StepsizeCallback(cfl=cfl)
# Save at certain timepoints which allows comparison to the results of Marrone et al.,
# i.e. t(g/H)^(1/2) = (1.5, 2.36, 3.0, 5.7, 6.45).
# Note that the images in Marrone et al. are obtained with `particles_per_height = 320`.
saving_paper = SolutionSavingCallback(save_times=[0.0, 1.5, 2.36, 3.0, 5.7, 6.45] ./
                                                 sqrt(gravity / H),
                                      prefix="marrone_times")

# Overwrite the callbacks
callbacks = CallbackSet(info_callback, stepsize_callback, saving_callback, saving_paper)



# Run simulation with updated parameters
trixi_include(joinpath(pwd(), "Simulations", "Performance", simulation, method, "default.jl"),
                            resolution=resolution,
                            neighborhood_search=neighborhood_search,
                            callbacks=callbacks,
                            alpha=alpha,
                            smoothing_length=smoothing_length,
                            smoothing_kernel=smoothing_kernel,
                            boundary_density_calculator=boundary_density_calculator,
                            cfl=cfl)



# Dictionary vor boudnary density calculator in the file name
boundary_dict = Dict(
    PressureZeroing => "PZ",
    PressureMirroring => "PM",
    AdamiPressureExtrapolation{Int64} => "APE",
    BernoulliPressureExtrapolation => "BPE",
   # PressureBoundaries => "PB"
)

# Define name of the plot
file_name = splitext(basename(@__FILE__))[1]

# Define path to the folder
path = joinpath(pwd(), "Results", "Performance", simulation, method, file_name)

cfl_string = replace(string(cfl), "." => "")

density_calculator_boundary = boundary_dict[typeof(boundary_density_calculator)]
plot_name1 = file_name * "_" * method * "_" * string(resolution) * "_" * density_calculator_boundary * "_cfl" * cfl_string
# Full path of the new plot
full_path1 = joinpath(path, plot_name1)
# plot and safe the plot
plt1 = plot(sol)
savefig(plt1, full_path1)

#Second plot
#plot_name2 = plot_name1 * "_"
#full_path2 = joinpath(path, plot_name2)
#ic = vtk2trixi("out/marrone_times_fluid_1_4948.vtu")
#velocity_magnitude = sqrt.(sum(ic.velocity.^2, dims=1))
#plt2 = plot(ic, zcolor=velocity_magnitude', color=:coolwarm)
#savefig(plt2, full_path2)