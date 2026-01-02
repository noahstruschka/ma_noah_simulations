# Table 5.2

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


# The density diffusion model by Molteni and Colagrossi shows unphysical effects at the
# free surface in long-running simulations, but is significantly faster than the model
# by Antuono. This simulation is short enough to use the faster model.
density_diffusion = DensityDiffusionMolteniColagrossi(delta=0.1)
# density_diffusion = DensityDiffusionAntuono(tank.fluid, delta=0.1)

# Viscosity
alpha = 0.02


# WCSPH parameters
cfl = 2.1
smoothing_length_factor = 1.75


# Smoothing length and kernel
smoothing_length = smoothing_length_factor * fluid_particle_spacing
smoothing_kernel = WendlandC2Kernel{2}()


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
                                                 sqrt(gravity / H), output_directory="Output/Performance/WCSPH",
                                      prefix="WCSPH_Best_Performance")

stepsize_callback = StepsizeCallback(cfl=cfl)

callbacks = CallbackSet(info_callback, saving_callback, stepsize_callback, saving_paper)

# Run the dam break simulation with these changes
trixi_include(@__MODULE__,
              joinpath(examples_dir(), "fluid", "dam_break_2d.jl"),
              fluid_particle_spacing=fluid_particle_spacing,
              density_diffusion=density_diffusion,
              alpha=alpha,
              smoothing_kernel=smoothing_kernel,
              smoothing_length=smoothing_length,
              neighborhood_search=neighborhood_search,
              callbacks=callbacks)
