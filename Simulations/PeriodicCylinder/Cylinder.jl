# Add neccessary packages
using TrixiParticles
using OrdinaryDiffEq
using Plots
using ThreadPinning
pinthreads(:numa)



include("periodic_cylinder_iisph_PZ.jl")
include("periodic_cylinder_iisph_PM.jl")
#include("periodic_cylinder_iisph_APE.jl")
#include("periodic_cylinder_iisph_PB.jl")
include("periodic_cylinder_wcsph.jl")
include("periodic_cylinder_wcsph_only_shifting.jl")
#include("periodic_cylinder_wcsph_shifting_TIC.jl")