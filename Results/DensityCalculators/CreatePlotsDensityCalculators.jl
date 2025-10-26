using Plots

save_files = true

include("../../PlottingFiles/PlotDamBreak.jl")

plot_dam_break_close("Output/Marrone/IISPH/PressureZeroing/IISPH_PressureZeroing_Marrone_fluid_1_7053.vtu",
                        "IISPH_PressureZeroing", save_fig=save_files)
