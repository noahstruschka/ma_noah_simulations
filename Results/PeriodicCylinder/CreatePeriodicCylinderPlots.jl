using Plots

save_files = true

include("../../PlottingFiles/PlotDamBreak.jl")

#=
plot_cylinder_2d("Output/Cylinder/IISPH/PressureZeroing/IISPH_PressureZeroing_Cylinder_fluid_1_500.vtu", "IISPH_Cylinder_PressureZeroing1", save_files)
plot_cylinder_2d("Output/Cylinder/IISPH/PressureZeroing/IISPH_PressureZeroing_Cylinder_fluid_1_1501.vtu", "IISPH_Cylinder_PressureZeroing2", save_files)
plot_cylinder_2d("Output/Cylinder/IISPH/PressureZeroing/IISPH_PressureZeroing_Cylinder_fluid_1_2503.vtu", "IISPH_Cylinder_PressureZeroing3", save_files)
plot_cylinder_2d("Output/Cylinder/IISPH/PressureZeroing/IISPH_PressureZeroing_Cylinder_fluid_1_5005.vtu", "IISPH_Cylinder_PressureZeroing4", save_files)

plot_cylinder_2d("Output/Cylinder/IISPH/PressureMirroring/IISPH_PressureMirroring_Cylinder_fluid_1_500.vtu", "IISPH_Cylinder_PressureMirroring1", save_files)
plot_cylinder_2d("Output/Cylinder/IISPH/PressureMirroring/IISPH_PressureMirroring_Cylinder_fluid_1_1501.vtu", "IISPH_Cylinder_PressureMirroring2", save_files)
plot_cylinder_2d("Output/Cylinder/IISPH/PressureMirroring/IISPH_PressureMirroring_Cylinder_fluid_1_2503.vtu", "IISPH_Cylinder_PressureMirroring3", save_files)
plot_cylinder_2d("Output/Cylinder/IISPH/PressureMirroring/IISPH_PressureMirroring_Cylinder_fluid_1_5005.vtu", "IISPH_Cylinder_PressureMirroring4", save_files)
=#
plot_cylinder_2d("Output/Cylinder/IISPH/AdamiPressureExtrapolation/IISPH_AdamiPressureExtrapolation_Cylinder_fluid_1_83417.vtu", "IISPH_Cylinder_AdamiPressureExtrapolation1", save_files)
#plot_cylinder_2d("Output/Cylinder/IISPH/AdamiPressureExtrapolation/IISPH_AdamiPressureExtrapolation_Cylinder_fluid_1_250084.vtu", "IISPH_Cylinder_AdamiPressureExtrapolation2", save_files)
#plot_cylinder_2d("Output/Cylinder/IISPH/AdamiPressureExtrapolation/IISPH_AdamiPressureExtrapolation_Cylinder_fluid_1_417072.vtu", "IISPH_Cylinder_AdamiPressureExtrapolation3", save_files)
#plot_cylinder_2d("Output/Cylinder/IISPH/AdamiPressureExtrapolation/IISPH_AdamiPressureExtrapolation_Cylinder_fluid_1_5005.vtu", "IISPH_Cylinder_AdamiPressureExtrapolation4", save_files)
#=
plot_cylinder_2d("Output/Cylinder/IISPH/PressureBoundaries/IISPH_PressureBoundaries_Cylinder_fluid_1_500.vtu", "IISPH_Cylinder_PressureBoundaries1", save_files)
plot_cylinder_2d("Output/Cylinder/IISPH/PressureBoundaries/IISPH_PressureBoundaries_Cylinder_fluid_1_1501.vtu", "IISPH_Cylinder_PressureBoundaries2", save_files)
plot_cylinder_2d("Output/Cylinder/IISPH/PressureBoundaries/IISPH_PressureBoundaries_Cylinder_fluid_1_2503.vtu", "IISPH_Cylinder_PressureBoundaries3", save_files)
plot_cylinder_2d("Output/Cylinder/IISPH/PressureBoundaries/IISPH_PressureBoundaries_Cylinder_fluid_1_5005.vtu", "IISPH_Cylinder_PressureBoundaries4", save_files)

plot_cylinder_2d("Output/Cylinder/WCSPH/No_Shifting/WCSPH_wo_Shifting_Cylinder_fluid_1_50.vtu", "WCSPH_Cylinder_No_Shifting1", save_files)
plot_cylinder_2d("Output/Cylinder/WCSPH/No_Shifting/WCSPH_wo_Shifting_Cylinder_fluid_1_150.vtu", "WCSPH_Cylinder_No_Shifting2", save_files)
plot_cylinder_2d("Output/Cylinder/WCSPH/No_Shifting/WCSPH_wo_Shifting_Cylinder_fluid_1_250.vtu", "WCSPH_Cylinder_No_Shifting3", save_files)
plot_cylinder_2d("Output/Cylinder/WCSPH/No_Shifting/WCSPH_wo_Shifting_Cylinder_fluid_1_500.vtu", "WCSPH_Cylinder_PressureZeroing4", save_files)

plot_cylinder_2d("Output/Cylinder/WCSPH/Only_Shifting/WCSPH_only_Shifting_Cylinder_fluid_1_50.vtu", "WCSPH_Cylinder_Only_Shifting1", save_files)
plot_cylinder_2d("Output/Cylinder/WCSPH/Only_Shifting/WCSPH_only_Shifting_Cylinder_fluid_1_150.vtu", "WCSPH_Cylinder_Only_Shifting2", save_files)
plot_cylinder_2d("Output/Cylinder/WCSPH/Only_Shifting/WCSPH_only_Shifting_Cylinder_fluid_1_250.vtu", "WCSPH_Cylinder_Only_Shifting3", save_files)
plot_cylinder_2d("Output/Cylinder/WCSPH/Only_Shifting/WCSPH_only_Shifting_Cylinder_fluid_1_500.vtu", "WCSPH_Cylinder_Only_Shifting4", save_files)

plot_cylinder_2d("Output/Cylinder/WCSPH/Shifting_TIC/WCSPH_Shifting_TIC_Cylinder_fluid_1_1501.vtu", "WCSPH_Cylinder_Shifting_TIC1", save_files)
plot_cylinder_2d("Output/Cylinder/WCSPH/Shifting_TIC/WCSPH_Shifting_TIC_Cylinder_fluid_1_1501.vtu", "WCSPH_Cylinder_Shifting_TIC2", save_files)
plot_cylinder_2d("Output/Cylinder/WCSPH/Shifting_TIC/WCSPH_Shifting_TIC_Cylinder_fluid_1_2503.vtu", "WCSPH_Cylinder_Shifting_TIC3", save_files)
plot_cylinder_2d("Output/Cylinder/WCSPH/Shifting_TIC/WCSPH_Shifting_TIC_Cylinder_fluid_1_5005.vtu", "WCSPH_Cylinder_Shifting_TIC4", save_files)
=#