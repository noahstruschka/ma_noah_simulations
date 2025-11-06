using Plots

save_files = true

include("../../PlottingFiles/PlotDamBreak.jl")

plot_dam_break_complete("Output/Performance/IISPH/IISPH_Best_Performance_fluid_1_7050.vtu", "IISPH_Performance", save_files)

plot_dam_break_complete("Output/Performance/WCSPH/WCSPH_Best_Performance_fluid_1_23164.vtu", "WCSPH_Performance", save_files)