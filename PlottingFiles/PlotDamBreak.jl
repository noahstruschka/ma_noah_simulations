using Plots
using Colors
using TrixiParticles



    colors_marrone = [
    RGB(1/255, 0/255, 252/255),   # 1: sehr niedrige Werte (blau)
    RGB(0/255, 106/255, 254/255), # 2
    RGB(4/255, 211/255, 255/255), # 3
    RGB(3/255, 255/255, 211/255), # 4
    RGB(0/255, 254/255, 107/255), # 5
    RGB(3/255, 255/255, 0/255),   # 6
    RGB(105/255, 254/255, 0/255), # 7
    RGB(211/255, 255/255, 2/255), # 8
    RGB(255/255, 212/255, 0/255), # 9
    RGB(254/255, 106/255, 0/255), # 10: hohe Werte (orange)
    RGB(253/255, 2/255, 0/255)    # 11: Werte > 1 (rot)
]
palette_marrone = cgrad(colors_marrone, categorical=true)

function plot_dam_break_2d(ic, x_lim, y_lim, z_color, color_palette, c_lims, marker_size, file_directory, save_fig)

    plt = plot(ic,
             xlim=x_lim,
             ylim=y_lim,
             zcolor=z_color,
             color=color_palette,
             colorbar = true,
             clims=c_lims,
             makersize=marker_size,
             markershape=:rect,
             legend=false,
             dpi=400
    )

    if save_fig
        savefig(plt, file_directory)
        println("Saved file succesuflly in ", file_directory)
    end

    return plt
end


function plot_dam_break_marrone(file_directory, file_name; save_fig=false)
    ic = vtk2trixi(file_directory)
    x_lim = (2.4, 3.2196)
    y_lim = (0, 0.72)
    velocity_magnitude = sqrt.(sum(ic.velocity.^2, dims=1))./sqrt(0.6 * 9.81)
    color_palette = palette_marrone #cgrad(:jet1, 11, categorical=true) # jet oder jet1 sind bisher am nähesten dran
    c_lims = (0,1.1)
    marker_size = 5
    file_directory= "Results/Marrone/" * file_name

    plt = plot_dam_break_2d(ic, x_lim, y_lim, velocity_magnitude', color_palette, c_lims, marker_size, file_directory, save_fig)

    return plt
end

function plot_dam_break_pressure(file_directory, file_name; save_fig=false)
    ic = vtk2trixi(file_directory)
    x_lim = (2.4, 3.2196)
    y_lim = (0, 0.72)
    pressure = ic.pressure./(0.6 * 9.81 * ic.density)
    color_palette = palette_marrone #cgrad(:jet1, 11, categorical=true) # jet oder jet1 sind bisher am nähesten dran
    c_lims = (0,1.1)
    marker_size = 5
    file_directory= "Results/Marrone/Pressure/" * file_name

    plt = plot_dam_break_2d(ic, x_lim, y_lim, pressure, color_palette, c_lims, marker_size, file_directory, save_fig)

    return plt
end

function plot_dam_break_close(file_directory, file_name; save_fig=false)
        ic = vtk2trixi(file_directory)
        x_lim = (2.4, 3.2196)
        y_lim = (0, 0.72)
        velocity_magnitude = sqrt.(sum(ic.velocity.^2, dims=1))./sqrt(0.6 * 9.81)
        color_palette = cgrad(:vik, 11, categorical=true)
        c_lims = (0,1.1)
        marker_size = 5
        file_directory = "Results/DensityCalculators/" * file_name
        plt = plot_dam_break_2d(ic, x_lim, y_lim, velocity_magnitude', color_palette, c_lims, marker_size, file_directory, save_fig)

        return plt
end

function plot_dam_break_complete(file_directory, file_name, save_fig=false)
        ic = vtk2trixi(file_directory)
        xlim = (0, 4)
        ylim = (0, Inf)
        velocity_magnitude = sqrt.(sum(ic.velocity.^2, dims=1))./sqrt(0.6 * 9.81)
        color_palette = palette(:cooltowarm, 11)
        c_lims = (0,1.1)
        markersize = 0.1
        file_directory= "Results/" * file_name
        plt = plot_dam_break_2d(ic, x_lim, y_lim, velocity_magnitude', color_palette, c_lims, marker_size, file_directory, sav_fig)

        return plt
end

function plot_cylinder_2d(file_directory, file_name, save_fig)
        ic = vtk2trixi(file_directory)
        xlim = (0, Inf)
        ylim = (0, Inf)
        velocity_magnitude = sqrt.(sum(ic.velocity.^2, dims=1))
        color_palette = cgrad(:vik)
        c_lims = (0, 0.00036)
        markersize = 0.1
        file_directory= "Results/PeriodicCylinder/" * file_name

        plt = plot(ic,
             xlim=xlim,
             ylim=ylim,
             zcolor=velocity_magnitude,
             color=color_palette,
             colorbar = true,
             clims=c_lims,
             makersize=markersize,
             #markershape=:rect,
             legend=false,
             dpi=400
    )

    if save_fig
        savefig(plt, file_directory)
        println("Saved file succesuflly in ", file_directory)
    end

    end
