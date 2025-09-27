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
              joinpath(examples_dir(), "fluid", "dam_break_2d.jl"),
              fluid_particle_spacing=fluid_particle_spacing,
              sol=nothing, ode=nothing)


# Define a GPU-compatible neighborhood search
min_corner = minimum(tank.boundary.coordinates, dims=2)
max_corner = maximum(tank.boundary.coordinates, dims=2)
cell_list = FullGridCellList(; min_corner, max_corner)
neighborhood_search = GridNeighborhoodSearch{2}(; cell_list)

# Use MolteniColagrossi as density diffusion
density_diffusion = DensityDiffusionMolteniColagrossi(delta=0.1)

# Change Parameters
smoothing_length = 1.75 * fluid_particle_spacing
stepsize_callback = StepsizeCallback(cfl=0.9)

# Run the dam break simulation with this neighborhood search
trixi_include(@__MODULE__,
              joinpath(examples_dir(), "fluid", "dam_break_2d.jl"),
              neighborhood_search=neighborhood_search,
              fluid_particle_spacing=fluid_particle_spacing,
              tspan=tspan,
              density_diffusion=density_diffusion,
              boundary_model=boundary_model,
              parallelization_backend=PolyesterBackend(),
              boundary_density_calculator=boundary_density_calculator)
