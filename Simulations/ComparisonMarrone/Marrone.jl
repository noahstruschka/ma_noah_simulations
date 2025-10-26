# Add neccessary packages
using TrixiParticles
using OrdinaryDiffEq
using Plots
using ThreadPinning
pinthreads(:numa)



include("IISPH_PressureZeroing.jl")
include("IISPH_PressureMirroring.jl")
#include("IISPH_AdamiPressureExtrapolation.jl")
#include("IISPH_PressureBoundaries.jl")
include("WCSPH_AdamiPressureExtrapolation.jl")