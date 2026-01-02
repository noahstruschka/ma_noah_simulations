using Plots

include("../../Plotting/PlotFunctions.jl")


# Set to false if you do not want to save all the plots
save_files = true


plot_dam_break_close("Output/Marrone/IISPH/PressureZeroing/IISPH_PressureZeroing_Marrone_fluid_1_7050.vtu",
                        "IISPH_PressureZeroing", save_fig=save_files)

plot_dam_break_close("Output/Marrone/IISPH/PressureMirroring/IISPH_PressureMirroring_Marrone_fluid_1_7050.vtu",
                       "IISPH_PressureMirroring", save_fig=save_files)

plot_dam_break_close("Output/Marrone/IISPH/AdamiPressureExtrapolation/IISPH_AdamiPressureExtrapolation_Marrone_fluid_1_7050.vtu",
                        "IISPH_AdamiPressureExtrapolation", save_fig=save_files)

plot_dam_break_close("Output/Marrone/IISPH/PressureBoundaries/IISPH_PressureBoundaries_Marrone_fluid_1_7050.vtu",
                        "IISPH_PressureBoundaries", save_fig=save_files)
