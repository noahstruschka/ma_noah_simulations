# Create the plots shown in chapter 5.2 of the thesis which represents the comparison
# with the paper from Adami et al.

# S. Adami and X.Y. Hu and N.A. Adams
# "A transport-velocity formulation for smoothed particle hydrodynamics"
# in Journal of Computational Physics
# doi = {https://doi.org/10.1016/j.jcp.2013.01.043

using Plots
include("../../PlottingFiles/PlotFunctions.jl")

# Set to false if you do not want to solve all the files
save_files = true

# Outputs from the the comparison with the paper from Adami et al.

# Note that in the thesis only the second plot is shown for each method, since this is the
# output at time T=1.5, which we use for the comparison in the thesis.
# For the output for T=5.0, you have to uncomment the last function AND need to extent
# the time span of the simulations in "Simulations/PeriodicCylinder to (0, 5.0 * time factor).
# By default the simulation only runs to T=2.5.

# Figure 5.3 - Comparison of the velocity magnitude |v|

# Figure 5.3 (b) WCSPH - without Shifting
plot_cylinder_2d("Output/PeriodicCylinder/WCSPH/No_Shifting/WCSPH_NoShifting_PeriodicCylinder_fluid_1_2189.vtu", "WCSPH/WCSPH_PeriodicCylinder_No_Shifting1", save_files)
plot_cylinder_2d("Output/PeriodicCylinder/WCSPH/No_Shifting/WCSPH_NoShifting_PeriodicCylinder_fluid_1_6945.vtu", "WCSPH/WCSPH_PeriodicCylinder_No_Shifting2", save_files)
plot_cylinder_2d("Output/PeriodicCylinder/WCSPH/No_Shifting/WCSPH_NoShifting_PeriodicCylinder_fluid_1_11861.vtu", "WCSPH/WCSPH_PeriodicCylinder_No_Shifting3", save_files)
plot_cylinder_2d("Output/PeriodicCylinder/WCSPH/No_Shifting/WCSPH_NoShifting_PeriodicCylinder_fluid_1_434.vtu", "WCSPH/WCSPH_PeriodicCylinder_No_Shifting4", save_files)
plot_cylinder_2d("Output/PeriodicCylinder/WCSPH/No_Shifting/WCSPH_NoShifting_PeriodicCylinder_fluid_1_866.vtu", "WCSPH/WCSPH_PeriodicCylinder_No_Shifting5", save_files)
plot_cylinder_2d("Output/PeriodicCylinder/WCSPH/No_Shifting/WCSPH_NoShifting_PeriodicCylinder_fluid_1_1303.vtu", "WCSPH/WCSPH_PeriodicCylinder_No_Shifting6", save_files)
plot_cylinder_2d("Output/PeriodicCylinder/WCSPH/No_Shifting/WCSPH_NoShifting_PeriodicCylinder_fluid_1_1741.vtu", "WCSPH/WCSPH_PeriodicCylinder_No_Shifting7", save_files)
#plot_cylinder_2d("Output/PeriodicCylinder/WCSPH/No_Shifting/WCSPH_NoShifting_PeriodicCylinder_fluid_1_500.vtu", "WCSPH/WCSPH_PeriodicCylinder_PressureZeroing8", save_files)

# # Figure 5.3 (c) WCSPH - with Shifting
plot_cylinder_2d("Output/PeriodicCylinder/WCSPH/Only_Shifting/WCSPH_OnlyShifting_PeriodicCylinder_fluid_1_2138.vtu", "WCSPH/WCSPH_PeriodicCylinder_Only_Shifting1", save_files)
plot_cylinder_2d("Output/PeriodicCylinder/WCSPH/Only_Shifting/WCSPH_OnlyShifting_PeriodicCylinder_fluid_1_6446.vtu", "WCSPH/WCSPH_PeriodicCylinder_Only_Shifting2", save_files)
plot_cylinder_2d("Output/PeriodicCylinder/WCSPH/Only_Shifting/WCSPH_OnlyShifting_PeriodicCylinder_fluid_1_10778.vtu", "WCSPH/WCSPH_PeriodicCylinder_Only_Shifting3", save_files)
#plot_cylinder_2d("Output/PeriodicCylinder/WCSPH/Only_Shifting/WCSPH_OnlyShifting_PeriodicCylinder_fluid_1_500.vtu", "WCSPH/WCSPH_PeriodicCylinder_Only_Shifting4", save_files)

# Figure 5.3 (d) WCSPH - with Shifting and TIC
plot_cylinder_2d("Output/PeriodicCylinder/WCSPH/Shifting_TIC/WCSPH_ShiftingTIC_PeriodicCylinder_fluid_1_2122.vtu", "WCSPH/WCSPH_PeriodicCylinder_Shifting_TIC1", save_files)
plot_cylinder_2d("Output/PeriodicCylinder/WCSPH/Shifting_TIC/WCSPH_ShiftingTIC_PeriodicCylinder_fluid_1_6425.vtu", "WCSPH/WCSPH_PeriodicCylinder_Shifting_TIC2", save_files)
plot_cylinder_2d("Output/PeriodicCylinder/WCSPH/Shifting_TIC/WCSPH_ShiftingTIC_PeriodicCylinder_fluid_1_10738.vtu", "WCSPH/WCSPH_PeriodicCylinder_Shifting_TIC3", save_files)
#plot_cylinder_2d("Output/PeriodicCylinder/WCSPH/Shifting_TIC/WCSPH_ShiftingTIC_PeriodicCylinder_fluid_1_5005.vtu", "WCSPH/WCSPH_PeriodicCylinder_Shifting_TIC4", save_files)

# Figure 5.3 (e) IISPH - Pressure Zeroing
plot_cylinder_2d("Output/PeriodicCylinder/IISPH/PressureZeroing/IISPH_PressureZeroing_PeriodicCylinder_fluid_1_27800.vtu", "IISPH/IISPH_PeriodicCylinder_PressureZeroing1", save_files)
plot_cylinder_2d("Output/PeriodicCylinder/IISPH/PressureZeroing/IISPH_PressureZeroing_PeriodicCylinder_fluid_1_83401.vtu", "IISPH/IISPH_PeriodicCylinder_PressureZeroing2", save_files)
plot_cylinder_2d("Output/PeriodicCylinder/IISPH/PressureZeroing/IISPH_PressureZeroing_PeriodicCylinder_fluid_1_139001.vtu", "IISPH/IISPH_PeriodicCylinder_PressureZeroing3", save_files)
#plot_cylinder_2d("Output/PeriodicCylinder/IISPH/PressureZeroing/IISPH_PressureZeroing_PeriodicCylinder_fluid_1_5005.vtu", "IISPH/IISPH_PeriodicCylinder_PressureZeroing4", save_files)

# # Figure 5.3 (f) IISPH - Pressure Mirroring
plot_cylinder_2d("Output/PeriodicCylinder/IISPH/PressureMirroring/IISPH_PressureMirroring_PeriodicCylinder_fluid_1_27800.vtu", "IISPH/IISPH_PeriodicCylinder_PressureMirroring1", save_files)
plot_cylinder_2d("Output/PeriodicCylinder/IISPH/PressureMirroring/IISPH_PressureMirroring_PeriodicCylinder_fluid_1_83401.vtu", "IISPH/IISPH_PeriodicCylinder_PressureMirroring2", save_files)
plot_cylinder_2d("Output/PeriodicCylinder/IISPH/PressureMirroring/IISPH_PressureMirroring_PeriodicCylinder_fluid_1_139001.vtu", "IISPH/IISPH_PeriodicCylinder_PressureMirroring3", save_files)
#plot_cylinder_2d("Output/PeriodicCylinder/IISPH/PressureMirroring/IISPH_PressureMirroring_PeriodicCylinder_fluid_1_5005.vtu", "IISPH/IISPH_PeriodicCylinder_PressureMirroring4", save_files)

# Figure 5.3 (g) IISPH - Adami Pressure Extrapolation
plot_cylinder_2d("Output/PeriodicCylinder/IISPH/AdamiPressureExtrapolation/IISPH_AdamiPressureExtrapolation_PeriodicCylinder_fluid_1_27800.vtu", "IISPH/IISPH_PeriodicCylinder_AdamiPressureExtrapolation1", save_files)
plot_cylinder_2d("Output/PeriodicCylinder/IISPH/AdamiPressureExtrapolation/IISPH_AdamiPressureExtrapolation_PeriodicCylinder_fluid_1_83401.vtu", "IISPH/IISPH_PeriodicCylinder_AdamiPressureExtrapolation2", save_files)
plot_cylinder_2d("Output/PeriodicCylinder/IISPH/AdamiPressureExtrapolation/IISPH_AdamiPressureExtrapolation_PeriodicCylinder_fluid_1_139001.vtu", "IISPH/IISPH_PeriodicCylinder_AdamiPressureExtrapolation3", save_files)
#plot_cylinder_2d("Output/PeriodicCylinder/IISPH/AdamiPressureExtrapolation/IISPH_AdamiPressureExtrapolation_PeriodicCylinder_fluid_1_5005.vtu", "IISPH/IISPH_PeriodicCylinder_AdamiPressureExtrapolation4", save_files)

# Figure 5.3 (h) IISPH - Pressure Boundaries
plot_cylinder_2d("Output/PeriodicCylinder/IISPH/PressureBoundaries/IISPH_PressureBoundaries_PeriodicCylinder_fluid_1_27800.vtu", "IISPH/IISPH_PeriodicCylinder_PressureBoundaries1", save_files)
plot_cylinder_2d("Output/PeriodicCylinder/IISPH/PressureBoundaries/IISPH_PressureBoundaries_PeriodicCylinder_fluid_1_83401.vtu", "IISPH/IISPH_PeriodicCylinder_PressureBoundaries2", save_files)
plot_cylinder_2d("Output/PeriodicCylinder/IISPH/PressureBoundaries/IISPH_PressureBoundaries_PeriodicCylinder_fluid_1_139001.vtu", "IISPH/IISPH_PeriodicCylinder_PressureBoundaries3", save_files)
#plot_cylinder_2d("Output/PeriodicCylinder/IISPH/PressureBoundaries/IISPH_PressureBoundaries_PeriodicCylinder_fluid_1_5005.vtu", "IISPH/IISPH_PeriodicCylinder_PressureBoundaries4", save_files)


plot_cylinder_2d("Output/PeriodicCylinder/IISPH/With_Shifting/IISPH_AdamiPressureExtrapolation_PeriodicCylinder_Shifting_fluid_1_27778.vtu", "IISPH/IISPH_PeriodicCylinder_Shifting1", save_files)
plot_cylinder_2d("Output/PeriodicCylinder/IISPH/With_Shifting/IISPH_AdamiPressureExtrapolation_PeriodicCylinder_Shifting_fluid_1_33334.vtu", "IISPH/IISPH_PeriodicCylinder_Shifting2", save_files)
plot_cylinder_2d("Output/PeriodicCylinder/IISPH/With_Shifting/IISPH_AdamiPressureExtrapolation_PeriodicCylinder_Shifting_fluid_1_83335.vtu", "IISPH/IISPH_PeriodicCylinder_Shifting3", save_files)
plot_cylinder_2d("Output/PeriodicCylinder/IISPH/With_Shifting/IISPH_AdamiPressureExtrapolation_PeriodicCylinder_Shifting_fluid_1_138891.vtu", "IISPH/IISPH_PeriodicCylinder_Shifting4", save_files)