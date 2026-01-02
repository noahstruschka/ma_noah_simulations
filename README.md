This repository contains the code to reproduce the numerical results in my master's thesis "Investigation of Implicit Incompressible Smoothed Particle Hydrodynamics in Julia".
The presented code uses TrixiParticles.jl, a software for numerical simulations of fluids written in Julia. To reproduce the numerical experiments using TrixiParticles.jl, you need to install Julia.
The numerical experiments were carried out using Julia v1.11.5.

## Repository Structure

The repository is organized into the following main folders, each serving a specific purpose in reproducing the numerical experiments from the thesis:

- **`Simulations/`** – Contains the scripts for setting up and running the simulations presented in the thesis. This folder is structured into three subfolders:
  - **`Marrone/`** – Dam Break examples for comparison with the study by Marrone (Section 5.1)
  - **`PeriodicCylinder/`** – Periodic Cylinder examples for comparison with S. Adami, X.Y. Hu, and N.A. Adams (Section 5.2)
  - **`Performance/`** – Simulations used to reproduce the tables in Chapter 5

All simulations are created and run using the `trixi_include` function from TrixiParticles.jl. For example:

```julia
    using Trixi
    trixi_include("examples/fluid/dam_break_2d.jl")
```
  and variables in the elixir can be overwritten by passing keyword arguments, e.g.,

```julia
    using Trixi
    trixi_include("examples/fluid/dam_break_2d.jl",
                fluid_particle_spacing=0.015,
                smoothing_length=1.25*fluid_particle_spacing)
```

- **`Output/`** – Stores the `.vtk` files generated as outputs from the simulations.

- **`Plotting/`** – Contains files which include the Julie functions for generating graphical outputs from the simulation results.

- **`Results/`** – Contains files that process the files in the `Output/` folder to create the figures presented in the thesis. Here you may need to change the exact files names of the output files in the
`Output/` folder.
