using Plots
using TrixiParticles

function plot_wave_marrone_times(file_directory, save=false)

    ic = vtk2trixi(file_directory)

    velocity_magnitude = sqrt.(sum(ic.velocity.^2, dims=1))

    color_palette = palette(:rainbow, 6)
    marker_size = 0.7

    plt = plot(
        ic,
        xlim=(2.5,Inf),
        ylim=(0,1),
        zcolor=velocity_magnitude,
        color=color_palette,
        markersize= marker_size
    )

    if save
        filename = "wave.png"
        savefig(plt, joinpath("Results", filename))
    end

    return plt
end


plot_wave_marrone_times("", true)