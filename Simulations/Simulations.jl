# Perform all Simulations presented in the thesis 

# Simulations for the comparison of the dam break example with the paper from Marrone et al.
include("Marrone/Marrone.jl")

# Simulations for the comparison of the performance of IISPH and WCSPH with TrixiParticles.jl
include("Performance/Performance.jl")

# Simulations for the comparison of the Periodic Cylinder example with the paper from Adami et al.
include("PeriodicCylinder/PeriodicCylinder.jl")