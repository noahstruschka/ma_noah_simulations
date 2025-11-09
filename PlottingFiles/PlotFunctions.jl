using Plots
using Colors
using TrixiParticles


# Define color palettes used in the paper from Marrone et al.

# Color palette used for the normalized velocity magnitude by Marrone et al.
    colors_marrone_velocity = [
    RGB(1/255, 0/255, 252/255),   # 1: low  values (blue)
    RGB(0/255, 106/255, 254/255), # 2
    RGB(4/255, 211/255, 255/255), # 3
    RGB(3/255, 255/255, 211/255), # 4
    RGB(0/255, 254/255, 107/255), # 5
    RGB(3/255, 255/255, 0/255),   # 6
    RGB(105/255, 254/255, 0/255), # 7
    RGB(211/255, 255/255, 2/255), # 8
    RGB(255/255, 212/255, 0/255), # 9
    RGB(254/255, 106/255, 0/255), # 10: high values (orange)
    RGB(253/255, 2/255, 0/255)    # 11: values > 1 (red)
]

palette_marrone_velocity = cgrad(colors_marrone_velocity, categorical=true)

# Color palette used for the normalized pressure by Marrone et al.
    colors_marrone_pressure = [
    RGB(1/255, 0/255, 252/255),   # 1: very low values (blue)
    RGB(0/255, 106/255, 254/255), # 2
    RGB(4/255, 211/255, 255/255), # 3
    RGB(3/255, 255/255, 211/255), # 4
    RGB(4/255, 253/255, 150/255), # 5
    RGB(3/255, 255/255, 46/255),  # 6
    RGB(48/255, 255/255, 0/255),  # 7
    RGB(145/255, 255/255, 4/255), # 8
    RGB(211/255, 255/255, 2/255), # 9
    RGB(255/255, 212/255, 0/255), # 10
    RGB(254/255, 106/255, 0/255), # 11: high values (orange)
    RGB(253/255, 2/255, 0/255)    # 12: values > 1 (red)
]

palette_marrone_pressure = cgrad(colors_marrone_pressure, categorical=true)


# Plotting Function

# Plot the dam break
function plot_dam_break_2d(ic, x_lim, y_lim, z_color, color_palette, c_lims, marker_size, file_directory, save_fig)
    # Define the ticks on the x and y axis
    x_major_ticks = x_lim[1]:0.2:x_lim[2]
    y_major_ticks = y_lim[1]:0.2:y_lim[2]

    # Plot the result
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
             dpi=400,                   # resolution
             tickfont=font(10),         # larger font
             guidefont=font(12),        # ticker axis font
             lw=2,                      # line width
             axis=:on,                  # show axis
             grid=true                  # show grid
    )

    # Save the figure
    if save_fig
        savefig(plt, file_directory)
        println("Saved file succesuflly in ", file_directory)
    end

    return plt
end

# Plotting function for the comparison of the velocity magnitude in 2d dam break example
function plot_dam_break_marrone(file_directory, file_name; save_fig=false)
    # simulation parameters
    H = 0.6
    g = 9.81

    # get the required values form the initial condition
    ic = vtk2trixi(file_directory)
    ic.coordinates .= ic.coordinates./H
    velocity_magnitude = sqrt.(sum(ic.velocity.^2, dims=1))./sqrt(H * g)

    # set plotting parameters
    x_min = 4.2
    x_max = 5.4
    y_min = 0
    y_max = 1.2
    x_lim = (x_min, x_max)
    y_lim = (y_min, y_max)
    color_palette = palette_marrone_velocity
    c_lims = (0,1.1)
    marker_size = 0.85

    # output directory
    output_directory= "Results/Marrone/Velocity/" * file_name

    plt = plot_dam_break_2d(ic, x_lim, y_lim, velocity_magnitude', color_palette, c_lims, marker_size, output_directory, save_fig)

    return plt
end


# Plotting function for the comparison of the normalized pressure values in 2d dam break example
function plot_dam_break_pressure(file_directory, file_name; save_fig=false)
    # simulation parameters
    H = 0.6
    g = 9.81

    # get the required values from the initial condition
    ic = vtk2trixi(file_directory)
    ic.coordinates .= ic.coordinates./H
    pressure = ic.pressure./(H * g * ic.density)

    # set plotting parameters
    x_min = 4.2
    x_max = 5.4
    y_min = 0
    y_max = 1.2
    x_lim = (x_min, x_max)
    y_lim = (y_min, y_max)
    color_palette = palette_marrone_pressure
    c_lims = (-0.1,1.1)
    marker_size = 0.85

    # output directory
    output_directory = "Results/Marrone/Pressure/" * file_name

    plt = plot_dam_break_2d(ic, x_lim, y_lim, pressure, color_palette, c_lims, marker_size, output_directory, save_fig)

    return plt
end

# Function for the close dam break with a warm to cool color palette
function plot_dam_break_close(file_directory, file_name; save_fig=false)
    # simulation parameters
    H = 0.6
    g = 9.81

    # get the required values from the initial condition
    ic = vtk2trixi(file_directory)
    ic.coordinates .= ic.coordinates./H
    velocity_magnitude = sqrt.(sum(ic.velocity.^2, dims=1))./sqrt(H * g)

    # set plotting parameters
    x_min = 4.2
    x_max = 5.4
    y_min = 0
    y_max = 1.2
    x_lim = (x_min, x_max)
    y_lim = (y_min, y_max)
    color_palette = cgrad(:vik, 11, categorical=true)
    c_lims = (0,1.1)
    marker_size = 0.85

    # output directory
    output_directory = "Results/DensityCalculators/" * file_name

    plt = plot_dam_break_2d(ic, x_lim, y_lim, velocity_magnitude', color_palette, c_lims, marker_size, output_directory, save_fig)

    return plt
end

function plot_dam_break_complete(file_directory, file_name, save_fig=false)
    # simulation parameters
    H = 0.6
    g = 9.81

    # get the required values from the initial condition
    ic = vtk2trixi(file_directory)
    ic.coordinates .= ic.coordinates./H
    velocity_magnitude = sqrt.(sum(ic.velocity.^2, dims=1))./sqrt(H * g)

    # set plotting parameters
    x_min = 0
    x_max = 6
    y_min = 0
    y_max = 1.2
    x_lim = (x_min, x_max)
    y_lim = (y_min, y_max)
    color_palette = cgrad(:vik, 11, categorical=true)
    c_lims = (0,1.1)
    marker_size = 0.85

    # output directory
    output_directory = "Results/DensityCalculators/" * file_name

    plt = plot_dam_break_2d(ic, x_lim, y_lim, velocity_magnitude', color_palette, c_lims, marker_size, output_directory, save_fig)

    return plt
end

# Plotting function for the 2d periodic cylinder example
function plot_cylinder_2d(file_directory, file_name, save_fig)

        # get the required values from the initial condition
        ic = vtk2trixi(file_directory)
        velocity_magnitude = sqrt.(sum(ic.velocity.^2, dims=1))

        # set plotting parameters
        color_palette = palette_marrone_velocity
        c_lims = (0, 0.00036)
        markersize = 1

        # output directory
        output_directory= "Results/PeriodicCylinder/" * file_name

        # Plot the result
        plt = plot(ic,
             zcolor=velocity_magnitude',
             color=color_palette,
             colorbar = true,
             clims=c_lims,
             markersize=markersize,
             legend=false,
             axis=false,
             dpi=400
            )

    # Save the figure
    if save_fig
        savefig(plt, output_directory)
        println("Saved file succesuflly in ", output_directory)
    end
end
