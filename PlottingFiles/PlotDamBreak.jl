using Plots
using Colors
using TrixiParticles



    colors_marrone_velocity = [
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

    colors_marrone_pressure = [
    RGB(1/255, 0/255, 252/255),   # 1: sehr niedrige Werte (blau)
    RGB(0/255, 106/255, 254/255), # 2
    RGB(4/255, 211/255, 255/255), # 3
    RGB(3/255, 255/255, 211/255), # 4
    RGB(4/255, 253/255, 150/255), # 5
    RGB(3/255, 255/255, 46/255),  # 6
    RGB(48/255, 255/255, 0/255),  # 7
    RGB(145/255, 255/255, 4/255), # 8
    RGB(211/255, 255/255, 2/255), # 9
    RGB(255/255, 212/255, 0/255), # 10
    RGB(254/255, 106/255, 0/255), # 11: hohe Werte (orange)
    RGB(253/255, 2/255, 0/255)    # 12: Werte > 1 (rot)
]

palette_marrone_velocity = cgrad(colors_marrone_velocity, categorical=true)
palette_marrone_pressure = cgrad(colors_marrone_pressure, categorical=true)

function plot_dam_break_2d(ic, x_lim, y_lim, z_color, color_palette, c_lims, marker_size, file_directory, save_fig)
    gr()

    x_major_ticks = x_lim[1]:0.2:x_lim[2]
    x_minor_ticks = x_lim[1]:0.05:x_lim[2]
    y_major_ticks = y_lim[1]:0.2:y_lim[2]
    y_minor_ticks = y_lim[1]:0.05:y_lim[2]
    plt = plot(ic,
             xlim=x_lim,
             ylim=y_lim,
             xticks=(x_major_ticks, string.(x_major_ticks)),
             yticks=(y_major_ticks, string.(y_major_ticks)),
             tick_direction=:out,
             xlabel="x / H",
             ylabel="y / H",
             zcolor=z_color,
             color=color_palette,
             colorbar = true,
             clims=c_lims,
             markersize=marker_size,
             legend=false,
             dpi=400,
             tickfont=font(10),    # größere Schrift
             guidefont=font(12),   # dickere Achsenbeschriftung
             lw=2,                 # Linienbreite
             axis=:on,             # Achsen einblenden
             grid=true             # Gitter
    )

    if save_fig
        savefig(plt, file_directory)
        println("Saved file succesuflly in ", file_directory)
    end

    return plt
end

function plot_dam_break_marrone(file_directory, file_name; save_fig=false)
    H = 0.6
    g = 9.81
    x_min = 4.2
    x_max = 5.4
    y_min = 0
    y_max = 1.2

    ic = vtk2trixi(file_directory)
    ic.coordinates .= ic.coordinates./H
    x_lim = (x_min, x_max)
    y_lim = (y_min, y_max)
    velocity_magnitude = sqrt.(sum(ic.velocity.^2, dims=1))./sqrt(H * g)
    color_palette = palette_marrone_velocity
    c_lims = (0,1.1)
    marker_size = 0.85
    file_directory= "Results/Marrone/Velocity/" * file_name

    plt = plot_dam_break_2d(ic, x_lim, y_lim, velocity_magnitude', color_palette, c_lims, marker_size, file_directory, save_fig)

    return plt
end

function plot_dam_break_pressure(file_directory, file_name; save_fig=false)
    H = 0.6
    g = 9.81
    x_min = 4.2
    x_max = 5.4
    y_min = 0
    y_max = 1.2

    ic = vtk2trixi(file_directory)
    ic.coordinates .= ic.coordinates./H
    x_lim = (x_min, x_max)
    y_lim = (y_min, y_max)
    pressure = ic.pressure./(H * g * ic.density)
    color_palette = palette_marrone_pressure
    c_lims = (-0.1,1.1)
    marker_size = 0.85
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
        marker_size = 0.85
        file_directory = "Results/DensityCalculators/" * file_name
        plt = plot_dam_break_2d(ic, x_lim, y_lim, velocity_magnitude', color_palette, c_lims, marker_size, file_directory, save_fig)

        return plt
end

function plot_dam_break_complete(file_directory, file_name, save_fig=false)
        ic = vtk2trixi(file_directory)
        x_lim = (0, 4)
        y_lim = (0, Inf)
        velocity_magnitude = sqrt.(sum(ic.velocity.^2, dims=1))./sqrt(0.6 * 9.81)
        color_palette = cgrad(:vik, 11, categorical=true)
        c_lims = (0,1.1)
        marker_size = 0.85
        file_directory= "Results/" * file_name
        plt = plot_dam_break_2d(ic, x_lim, y_lim, velocity_magnitude', color_palette, c_lims, marker_size, file_directory, save_fig)

        return plt
end

function plot_cylinder_2d(file_directory, file_name, save_fig)
        ic = vtk2trixi(file_directory)
        xlim = (0, Inf)
        ylim = (0, Inf)
        velocity_magnitude = sqrt.(sum(ic.velocity.^2, dims=1))
        color_palette = cgrad(:vik)
        c_lims = (0, 0.00036)
        markersize = 0.85
        file_directory= "Results/PeriodicCylinder/" * file_name

        plt = plot(ic,
             xlim=xlim,
             ylim=ylim,
             zcolor=velocity_magnitude',
             color=color_palette,
             colorbar = true,
             clims=c_lims,
             markersize=markersize,
             legend=false,
             dpi=400
    )

    if save_fig
        savefig(plt, file_directory)
        println("Saved file succesuflly in ", file_directory)
    end

end
