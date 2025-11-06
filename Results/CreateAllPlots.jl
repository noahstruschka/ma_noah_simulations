# (Re)create the plots that are being shown in the master thesis


# Section 1: Comparison with Marrone paper
include("Marrone/CreatePlotsMarrone.jl")

# Section 2: More detailed comparison of IISPH density calculators
include("DensityCalculators/CreatePlotsDensityCalculators.jl")

# Section 3: Performance Comparison
include("Performance/CreatePlotsPerformance.jl")

# Section 4: Periodic Cylinder
include("PeriodicCylinder/CreatePlotsPeriodicCylinder.jl")