# Run the simulations that have been run for the outputs presented in chapter 5.2 in the thesis
# Simulations used for the comparison with the paper from Adami et al.

# WCSPH

# Figure 5.3 (b): WCSPH without Shifting
include("WCSPH/periodic_cylinder_wcsph.jl")

# Figure 5.3 (c): WCSPH with Shifting
include("WCSPH/periodic_cylinder_wcsph_only_shifting.jl")


# Figure 5.3 (d): WCSPH with Shifting and typical
include("WCSPH/periodic_cylinder_wcsph_shifting_TIC.jl")


# IISPH

# Figure 5.3 (e): IISPH - Pressure Zeroing
include("IISPH/periodic_cylinder_iisph_PZ.jl")

# Figure 5.3 (f): IISPH - Pressure Mirroring
include("IISPH/periodic_cylinder_iisph_PM.jl")

# Figure 5.3 (g): IISPH - Adami Pressure Extrapolation
include("IISPH/periodic_cylinder_iisph_APE.jl")

# Figure 5.3 (h): IISPH - Pressure Boundaries
include("IISPH/periodic_cylinder_iisph_PB.jl")
