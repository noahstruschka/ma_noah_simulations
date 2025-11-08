# Run the simulations that have been run for the outputs presented in chapter 5.1 in the thesis.
# Simulations used for the comparison with the paper from Marrone et al.

#  Figure 5.1 (b): δ-SPH
include("WCSPH_AdamiPressureExtrapolation.jl")

# Figure 5.1 (c): IISPH - Pressure Zeroing
include("IISPH_PressureZeroing.jl")

# Figure 5.1 (d): IISPH - Pressure Mirroring
include("IISPH_PressureMirroring.jl")

# Figure 5.3 (e): IISPH - Adami Pressure Extrapolation
include("IISPH_AdamiPressureExtrapolation.jl")

# Figure 5.4 (e): IISPH - Pressure Boundaries
include("IISPH_PressureBoundaries.jl")
