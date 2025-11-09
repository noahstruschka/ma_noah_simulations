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
plot_cylinder_2d("Output/PeriodicCylinder/WCSPH/No_Shifting/WCSPH_wo_Shifting_Cylinder_fluid_1_2189.vtu", "WCSPH/WCSPH_Cylinder_No_Shifting1", save_files)
plot_cylinder_2d("Output/PeriodicCylinder/WCSPH/No_Shifting/WCSPH_wo_Shifting_Cylinder_fluid_1_6945.vtu", "WCSPH/WCSPH_Cylinder_No_Shifting2", save_files)
plot_cylinder_2d("Output/PeriodicCylinder/WCSPH/No_Shifting/WCSPH_wo_Shifting_Cylinder_fluid_1_11861.vtu", "WCSPH/WCSPH_Cylinder_No_Shifting3", save_files)
#plot_cylinder_2d("Output/PeriodicCylinder/WCSPH/No_Shifting/WCSPH_wo_Shifting_Cylinder_fluid_1_500.vtu", "WCSPH/WCSPH_Cylinder_PressureZeroing4", save_files)

# # Figure 5.3 (c) WCSPH - with Shifting
plot_cylinder_2d("Output/PeriodicCylinder/WCSPH/Only_Shifting/WCSPH_only_Shifting_Cylinder_fluid_1_2189.vtu", "WCSPH/WCSPH_Cylinder_Only_Shifting1", save_files)
plot_cylinder_2d("Output/PeriodicCylinder/WCSPH/Only_Shifting/WCSPH_only_Shifting_Cylinder_fluid_1_6945.vtu", "WCSPH/WCSPH_Cylinder_Only_Shifting2", save_files)
plot_cylinder_2d("Output/PeriodicCylinder/WCSPH/Only_Shifting/WCSPH_only_Shifting_Cylinder_fluid_1_11861.vtu", "WCSPH/WCSPH_Cylinder_Only_Shifting3", save_files)
#plot_cylinder_2d("Output/PeriodicCylinder/WCSPH/Only_Shifting/WCSPH_only_Shifting_Cylinder_fluid_1_500.vtu", "WCSPH/WCSPH_Cylinder_Only_Shifting4", save_files)

# Figure 5.3 (d) WCSPH - with Shifting and TIC
plot_cylinder_2d("Output/PeriodicCylinder/WCSPH/Shifting_TIC/WCSPH_Shifting_TIC_Cylinder_fluid_1_2189.vtu", "WCSPH/WCSPH_Cylinder_Shifting_TIC1", save_files)
plot_cylinder_2d("Output/PeriodicCylinder/WCSPH/Shifting_TIC/WCSPH_Shifting_TIC_Cylinder_fluid_1_6945.vtu", "WCSPH/WCSPH_Cylinder_Shifting_TIC2", save_files)
plot_cylinder_2d("Output/PeriodicCylinder/WCSPH/Shifting_TIC/WCSPH_Shifting_TIC_Cylinder_fluid_1_11861.vtu", "WCSPH/WCSPH_Cylinder_Shifting_TIC3", save_files)
#plot_cylinder_2d("Output/PeriodicCylinder/WCSPH/Shifting_TIC/WCSPH_Shifting_TIC_Cylinder_fluid_1_5005.vtu", "WCSPH/WCSPH_Cylinder_Shifting_TIC4", save_files)

# Figure 5.3 (e) IISPH - Pressure Zeroing
plot_cylinder_2d("Output/PeriodicCylinder/IISPH/PressureZeroing/IISPH_PressureZeroing_Cylinder_fluid_1_27800.vtu", "IISPH/IISPH_Cylinder_PressureZeroing1", save_files)
plot_cylinder_2d("Output/PeriodicCylinder/IISPH/PressureZeroing/IISPH_PressureZeroing_Cylinder_fluid_1_83401.vtu", "IISPH/IISPH_Cylinder_PressureZeroing2", save_files)
plot_cylinder_2d("Output/PeriodicCylinder/IISPH/PressureZeroing/IISPH_PressureZeroing_Cylinder_fluid_1_139001.vtu", "IISPH/IISPH_Cylinder_PressureZeroing3", save_files)
#plot_cylinder_2d("Output/PeriodicCylinder/IISPH/PressureZeroing/IISPH_PressureZeroing_Cylinder_fluid_1_5005.vtu", "IISPH/IISPH_Cylinder_PressureZeroing4", save_files)

# # Figure 5.3 (f) IISPH - Pressure Mirroring
plot_cylinder_2d("Output/PeriodicCylinder/IISPH/PressureMirroring/IISPH_PressureMirroring_Cylinder_fluid_1_27800.vtu", "IISPH/IISPH_Cylinder_PressureMirroring1", save_files)
plot_cylinder_2d("Output/PeriodicCylinder/IISPH/PressureMirroring/IISPH_PressureMirroring_Cylinder_fluid_1_83401.vtu", "IISPH/IISPH_Cylinder_PressureMirroring2", save_files)
plot_cylinder_2d("Output/PeriodicCylinder/IISPH/PressureMirroring/IISPH_PressureMirroring_Cylinder_fluid_1_139001.vtu", "IISPH/IISPH_Cylinder_PressureMirroring3", save_files)
#plot_cylinder_2d("Output/PeriodicCylinder/IISPH/PressureMirroring/IISPH_PressureMirroring_Cylinder_fluid_1_5005.vtu", "IISPH/IISPH_Cylinder_PressureMirroring4", save_files)

# Figure 5.3 (g) IISPH - Adami Pressure Extrapolation
plot_cylinder_2d("Output/PeriodicCylinder/IISPH/AdamiPressureExtrapolation/IISPH_AdamiPressureExtrapolation_Cylinder_fluid_1_27800.vtu", "IISPH/IISPH_Cylinder_AdamiPressureExtrapolation1", save_files)
plot_cylinder_2d("Output/PeriodicCylinder/IISPH/AdamiPressureExtrapolation/IISPH_AdamiPressureExtrapolation_Cylinder_fluid_1_83401.vtu", "IISPH/IISPH_Cylinder_AdamiPressureExtrapolation2", save_files)
plot_cylinder_2d("Output/PeriodicCylinder/IISPH/AdamiPressureExtrapolation/IISPH_AdamiPressureExtrapolation_Cylinder_fluid_1_139001.vtu", "IISPH/IISPH_Cylinder_AdamiPressureExtrapolation3", save_files)
#plot_cylinder_2d("Output/PeriodicCylinder/IISPH/AdamiPressureExtrapolation/IISPH_AdamiPressureExtrapolation_Cylinder_fluid_1_5005.vtu", "IISPH/IISPH_Cylinder_AdamiPressureExtrapolation4", save_files)

# Figure 5.3 (h) IISPH - Pressure Boundaries
plot_cylinder_2d("Output/PeriodicCylinder/IISPH/PressureBoundaries/IISPH_PressureBoundaries_Cylinder_fluid_1_27800.vtu", "IISPH/IISPH_Cylinder_PressureBoundaries1", save_files)
plot_cylinder_2d("Output/PeriodicCylinder/IISPH/PressureBoundaries/IISPH_PressureBoundaries_Cylinder_fluid_1_83401.vtu", "IISPH/IISPH_Cylinder_PressureBoundaries2", save_files)
plot_cylinder_2d("Output/PeriodicCylinder/IISPH/PressureBoundaries/IISPH_PressureBoundaries_Cylinder_fluid_1_139001.vtu", "IISPH/IISPH_Cylinder_PressureBoundaries3", save_files)
#plot_cylinder_2d("Output/PeriodicCylinder/IISPH/PressureBoundaries/IISPH_PressureBoundaries_Cylinder_fluid_1_5005.vtu", "IISPH/IISPH_Cylinder_PressureBoundaries4", save_files)
