using Plots
using TrixiParticles


function plot_dam_break2d(ic, xlim, ylim, zcolor, color_palette, markersize, file_directory, save_fig)

    plt = plot(ic,
             xlim=xlim,
             ylim=ylim,
             zcolor=zcolor,
             color=color_palette,
             makersize=markersize
    )

    if save_fig
        savefig(plt, file_directory)
        println("Saved file succesuflly in ", file_directory)
    end

    return plt
end


function plot_dam_break_marrone(file_directory, filename; save_fig=false)
    ic = vtk2trixi(file_directory)
    xlim = (2.5, Inf)
    ylim = (0,1)
    velocity_magnitude = sqrt.(sum(ic.velocity.^2, dims=1))
    color_palette = palette(:rainbow, 12)
    markersize = 0.7
    file_directory= "Results/Marrone/" * filename

    plt = plot_dam_break2d(ic, xlim, ylim, velocity_magnitude, color_palette, markersize, file_directory, save_fig)

    return plt
end

function plot_dam_break_complete(file_directory, filename, save=false)
        ic = vtk2trixi(file_directory)
        xlim = (0, Inf)
        ylim = (0, Inf)
        velocity_magnitude = sqrt.(sum(ic.velocity.^2, dims=1))
        color_palette = palette(:cooltowarm, 12)
        markersize = 0.7
        plt = plot_dam_break2d(ic, xlim, ylim, velocity_magnitude, color_palette, markersize, filename)

        return plt
end
