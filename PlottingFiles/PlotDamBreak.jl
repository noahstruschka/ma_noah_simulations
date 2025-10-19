using Plots
using TrixiParticles


function plot_dam_break_2d(ic, x_lim, y_lim, z_color, color_palette, marker_size, file_directory, save_fig)

    plt = plot(ic,
             xlim=x_lim,
             ylim=y_lim,
             zcolor=z_color,
             color=color_palette,
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
    velocity_magnitude = sqrt.(sum(ic.velocity.^2, dims=1))
    color_palette = cgrad(:jet1, 11, categorical=true) # jet oder jet1 sind bisher am nähesten dran
    marker_size = 5
    file_directory= "Results/Marrone/" * file_name

    plt = plot_dam_break_2d(ic, x_lim, y_lim, velocity_magnitude', color_palette, marker_size, file_directory, save_fig)

    return plt
end

function plot_dam_break_complete(file_directory, file_name, save_fig=false)
        ic = vtk2trixi(file_directory)
        xlim = (0, Inf)
        ylim = (0, Inf)
        velocity_magnitude = sqrt.(sum(ic.velocity.^2, dims=1))
        color_palette = palette(:cooltowarm, 12)
        markersize = 0.1
        file_directory= "Results/" * file_name
        plt = plot_dam_break_2d(ic, x_lim, y_lim, velocity_magnitude', color_palette, marker_size, file_directory, sav_fig)

        return plt
end
