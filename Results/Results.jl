# Create the plots that are being shown in the  thesis


# Create outputs for the comparison with the paper from Marrone et al. in chapter 5.1
# Figure 5.1 (b-f) and Figure 5.2 (b-f) in the thesis
include("Marrone/CreatePlotsMarrone.jl")


# Create outputs for the comparison of the performance between IISPH and WCSPH with TrixiParticles.jl
# These do not appear in the thesis, only the timers outputs of the simulation are presented in table 5.2
include("Performance/CreatePlotsPerformance.jl")


# Create outputs for the comparison with the paper from Adami et al. in chapter 5.2
include("PeriodicCylinder/CreatePlotsPeriodicCylinder.jl")