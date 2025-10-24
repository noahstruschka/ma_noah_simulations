# Create the plots shown in chapter 5.1 of the master thesis which represents the comparison
# with the paper from Marrone.
#
# S. Marrone, M. Antuono, A. Colagrossi, G. Colicchio, D. le Touzé, G. Graziani.
# "δ-SPH model for simulating violent impact flows".
# In: Computer Methods in Applied Mechanics and Engineering, Volume 200, Issues 13–16 (2011), pages 1526–1542.
# https://doi.org/10.1016/J.CMA.2010.12.016


using Plots

save_files = true

include("../../PlottingFiles/PlotDamBreak.jl")

plot_dam_break_marrone("Output/Marrone/IISPH/PressureZeroing/IISPH_PressureZeroing_Marrone_fluid_1_7050.vtu",
                        "IISPH_Marrone_PressureZeroing"; save_fig=save_files)

plot_dam_break_marrone("Output/Marrone/IISPH/PressureMirroring/IISPH_PressureMirroring_Marrone_fluid_1_7050.vtu",
                        "IISPH_Marrone_PressureMirroring", save_fig=save_files)

#plot_dam_break_marrone("Output/Marrone/IISPH/AdamiPressureExtrapolation/IISPH_AdamiPressureExtrapolation_Marrone_fluid_1_7050.vtu",
#                        "IISPH_Marrone_PressureMirroring", save_fig=save_files)

#plot_dam_break_marrone("Output/Marrone/IISPH/PressureBoundaries/IISPH_PressureBoundaries_Marrone_fluid_1_7050.vtu",
#                        "IISPH_Marrone_PressureMirroring", save_fig=save_files)

plot_dam_break_marrone("Output/Marrone/WCSPH/AdamiPressureExtrapolation/WCSPH_AdamiPressureExtrapolation_Marrone_fluid_1_10135.vtu",
                        "IISPH_Marrone_PressureMirroring", save_fig=save_files)