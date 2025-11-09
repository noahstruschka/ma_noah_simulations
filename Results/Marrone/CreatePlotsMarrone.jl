# Create the plots shown in chapter 5.1 of the thesis which represents the comparison
# with the paper from Marrone et al.
#
# S. Marrone, M. Antuono, A. Colagrossi, G. Colicchio, D. le Touzé, G. Graziani.
# "δ-SPH model for simulating violent impact flows".
# In: Computer Methods in Applied Mechanics and Engineering, Volume 200, Issues 13–16 (2011), pages 1526–1542.
# https://doi.org/10.1016/J.CMA.2010.12.016

using Plots

include("../../PlottingFiles/PlotFunctions.jl")


# Set to false if you do not want to save all the plots
save_files = true


# Outputs from the the comparison with the paper from Marrone et al.

# Figure 5.1: Comparison of the normalized velocity |v|/(gH)^1/2$

directory = "Output/Marrone"
method = "WCSPH"

# Figure 5.1 (b): δ-SPH
plot_dam_break_marrone(joinpath(directory, method, "AdamiPressureExtrapolation/WCSPH_AdamiPressureExtrapolation_Marrone_fluid_1_10135.vtu"),
                        "WCSPH_Marrone_AdamiPressureExtrapolation", save_fig=save_files)

method = "IISPH"

# Figure 5.1 (c): IISPH - Pressure Zeroing
plot_dam_break_marrone(joinpath(directory, method, "PressureZeroing/IISPH_PressureZeroing_Marrone_fluid_1_7050.vtu"),
                        "IISPH_Marrone_PressureZeroing", save_fig=save_files)

# Figure 5.1 (d): IISPH - Pressure Mirroring
plot_dam_break_marrone(joinpath(directory, method, "PressureMirroring/IISPH_PressureMirroring_Marrone_fluid_1_7050.vtu"),
                       "IISPH_Marrone_PressureMirroring", save_fig=save_files)

# Figure 5.1 (e): IISPH - Adami Pressure Extrapolation
plot_dam_break_marrone(joinpath(directory, method, "AdamiPressureExtrapolation/IISPH_AdamiPressureExtrapolation_Marrone_fluid_1_7050.vtu"),
                        "IISPH_Marrone_AdamiPressureExtrapolation", save_fig=save_files)

# Figure 5.1 (f): IISPH - Pressure Boundaries
plot_dam_break_marrone(joinpath(directory, method, "PressureBoundaries/IISPH_PressureBoundaries_Marrone_fluid_1_7050.vtu"),
                        "IISPH_Marrone_PressureBoundaries", save_fig=save_files)


#Figure 5.2: Comparison of the normalized pressure field p/(\rho*g*H)

method = "WCSPH"

# Figure 5.2 (b): δ-SPH
plot_dam_break_pressure(joinpath(directory, method, "AdamiPressureExtrapolation/WCSPH_AdamiPressureExtrapolation_Marrone_fluid_1_10135.vtu"),
                        "WCSPH_Pressure_AdamiPressureExtrapolation", save_fig=save_files)

method = "IISPH"

# Figure 5.2 (c): IISPH - Pressure Zeroing
plot_dam_break_pressure(joinpath(directory, method, "PressureZeroing/IISPH_PressureZeroing_Marrone_fluid_1_7050.vtu"),
                        "IISPH_Pressure_PressureZeroing", save_fig=save_files)

# Figure 5.2 (d): IISPH - Pressure Mirroring
plot_dam_break_pressure(joinpath(directory, method, "PressureMirroring/IISPH_PressureMirroring_Marrone_fluid_1_7050.vtu"),
                       "IISPH_Pressure_PressureMirroring", save_fig=save_files)

# Figure 5.2 (e): IISPH - Adami Pressure Extrapolation
plot_dam_break_pressure(joinpath(directory, method, "AdamiPressureExtrapolation/IISPH_AdamiPressureExtrapolation_Marrone_fluid_1_7050.vtu"),
                        "IISPH_Pressure_AdamiPressureExtrapolation", save_fig=save_files)

# Figure 5.2 (f): IISPH - Pressure Boundaries
plot_dam_break_pressure(joinpath(directory, method, "PressureBoundaries/IISPH_PressureBoundaries_Marrone_fluid_1_7050.vtu"),
                        "IISPH_Pressure_PressureBoundaries", save_fig=save_files)