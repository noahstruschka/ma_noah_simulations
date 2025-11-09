# Run the simulations that have been run for the outputs presented in chapter 5.2 in the thesis
# Simulations used for the comparison with the paper from Adami et al.

# WCSPH

# Figure 5.3 (b): WCSPH without Shifting
include("WCSPH/WCSPH_no_shifting.jl")

# Figure 5.3 (c): WCSPH with Shifting
include("WCSPH/WCSPH_only_shifting.jl")


# Figure 5.3 (d): WCSPH with Shifting and typical
include("WCSPH/WCSPH_shifting_TIC.jl")


# IISPH

# Figure 5.3 (e): IISPH - Pressure Zeroing
include("IISPH/IISPH_PressureZeroing.jl")

# Figure 5.3 (f): IISPH - Pressure Mirroring
include("IISPH/IISPH_PressureMirroring.jl")

# Figure 5.3 (g): IISPH - Adami Pressure Extrapolation
include("IISPH/IISPH_AdamiPressureExtrapolation.jl")

# Figure 5.3 (h): IISPH - Pressure Boundaries
include("IISPH/IISPH_PressureBoundaries.jl")
