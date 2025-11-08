using Plots

include("../../PlottingFiles/PlotFunctions.jl")

# Set this to true if you want to safe these files too
save_files = true

# These outputs are not in the thesis, only the parameter and the timers output are present in table 5.2

# IISPH
plot_dam_break_complete("Output/Performance/IISPH/IISPH_Best_Performance_fluid_1_7050.vtu", "IISPH_Performance", save_files)

# WCSPH
plot_dam_break_complete("Output/Performance/WCSPH/WCSPH_Best_Performance_fluid_1_23164.vtu", "WCSPH_Performance", save_files)