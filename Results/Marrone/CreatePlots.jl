# Create the plots shown in chapter 5.1 of the master thesis which represents the comparison
# with the paper from Marrone.
#
# S. Marrone, M. Antuono, A. Colagrossi, G. Colicchio, D. le Touzé, G. Graziani.
# "δ-SPH model for simulating violent impact flows".
# In: Computer Methods in Applied Mechanics and Engineering, Volume 200, Issues 13–16 (2011), pages 1526–1542.
# https://doi.org/10.1016/J.CMA.2010.12.016


using Plots

save_all_files = true

include("../../PlottingFiles/PlotDamBreak.jl")

plot_dam_break_marrone("Output/Marrone/PressureZeroing", "IISPH_Marrone_PressureZeroing", save_all_files)

plot_dam_break_marrone("Output/Marrone/PressureMirroring", "IISPH_Marrone_PressureMirroring", save_all_files)