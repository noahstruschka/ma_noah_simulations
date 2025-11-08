# Run the simulations that have been run for the outputs presented in chapter 5.1 in the thesis
# Simulations used for the performance comparison between IISPH and WCSPH with TrixiParticles.jl
# Results presented in Table 5.2

# IISPH with Pressure Zeroing
include("IISPH/IISPH_PressureZeroing.jl")

# IISPH with Pressure Mirroring
include("IISPH/IISPH_PressureMirroring.jl")

# IISPH with Adami Pressure Extrapolation
include("IISPH/IISPH_AdamiPressureExtrapolation.jl")

# IISPH with Pressure Boundaries
include("IISPH/IISPH_PressureBoundaries.jl")

# δ-SPH with Adami Pressure Extrapolation
include("WCSPH/WCSPH_AdamiPressureExtrapolation.jl")