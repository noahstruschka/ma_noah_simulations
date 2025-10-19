
folder = "Simulations"
simulations = ["Dam_Break"]
methods = ["IISPH", "WCSPH"]
# IISPH parameters
omegas = [0.65, 0.70, 0.75]
time_steps = [0.0002, 0.00025, 0.0003]
max_errors = [0.01, 0.1, 1.0]
#WCSPH parameters
cfl_numbers = [1.0, 1.2, 1.4, 1.6, 1.8]
smoothing_lengths = [2.0, 1.8, 1.6]

i = 1

for simulation in simulations
    for method in methods
        # load default simulation file
        trixi_include(joinpath(pwd(), folder, "Performance", simulation, method, "default.jl"), sol=nothing, ode=nothing)

        resolution = 320
        fluid_particle_spacing = H / resolution
        # Define a GPU-compatible neighborhood search
        min_corner = minimum(tank.boundary.coordinates, dims=2)
        max_corner = maximum(tank.boundary.coordinates, dims=2)
        cell_list = FullGridCellList(; min_corner, max_corner)
        #neighborhood_search = GridNeighborhoodSearch{2}(; cell_list, update_strategy=ParallelUpdate())


        # Overwrite the saving_callback such that we only get the first and the last time step as
        # result
        saving_callback = SolutionSavingCallback(dt=100, prefix=solution_prefix)
        # Save at certain timepoints which allows comparison to the results of Marrone et al.,
        # i.e. t(g/H)^(1/2) = (1.5, 2.36, 3.0, 5.7, 6.45).
        # Note that the images in Marrone et al. are obtained with `particles_per_height = 320`.
        alpha = 0.02

        if method == "IISPH"
            for omega in omegas
                for time_step in time_steps
                    for max_error in max_errors
                        # IISPH parameters
                            time_step = time_step
                            omega = omega
                            min_iterations = 2
                            max_iterations = 30
                            max_error = max_error

                            omega_string = replace(string(omega), "." => "")
                            ts_string = replace(string(time_step), "." => "")
                            error_string = replace(string(max_error), "." => "")
                            prefix_string = method * "_w" * omega_string * "_ts" * ts_string * "_err" * "error_string"

                            saving_paper = SolutionSavingCallback(save_times=[0.0, 1.5, 2.36, 3.0, 5.7, 6.45] ./
                                                        sqrt(gravity / H), output_directory=joinpath(pwd(), "Results", "Performance", simulation, method),
                                            prefix=prefix_string)

                            boundary_density_calculator = PressureZeroing()
                            # Overwrite the callbacks
                            callbacks = CallbackSet(info_callback, saving_callback, saving_paper)

                            # Run simulation with updated parameters
                            trixi_include(joinpath(pwd(), folder, "Performance", simulation, method, "default.jl"),
                                                        resolution=resolution,
                                                        neighborhood_search=neighborhood_search,
                                                        callbacks=callbacks,
                                                        alpha=alpha,
                                                        smoothing_length=smoothing_length,
                                                        smoothing_kernel=smoothing_kernel,
                                                        boundary_density_calculator=boundary_density_calculator,
                                                        time_step=time_step,
                                                        omega=omega,
                                                        min_iterations=min_iterations,
                                                        max_iterations=max_iterations,
                                                        max_error=max_error)

                            path = joinpath(pwd(), "Results", "Performance", simulation, method)
                            plot_name = file_name * "_" * string(resolution) * "_w" * omega_string * "_ts" * ts_string * "_err" * error_string
                            # Full path of the new plot
                            full_path = joinpath(path, plot_name1)
                            # plot and safe the plot
                            plt = plot(sol)
                            savefig(plt, full_path)
                            i+=1
                            text = "Simualtion " * string(i) * "================================================================"
                            println(text)
                    end
                end
            end
        elseif method == "WCSPH"
            for cfl in cfl_numbers
                for smoothing_length in smoothing_lenghts
                    cfl=cfl
                    smoothing_length=smoothing_length

                    cfl_string = replace(string(cfl), "." => "")
                    sl_string = replace(string(smoothing_length), "." => "")

                    prefix_string = method * "_cfl" * cfl_string * "_sl" * sl_string

                    saving_paper = SolutionSavingCallback(save_times=[0.0, 1.5, 2.36, 3.0, 5.7, 6.45] ./
                                                        sqrt(gravity / H), output_directory=joinpath(pwd(), "Result", "Performance", simulation, method),
                                            prefix=prefix_string)

                    boundary_density_calculator = AdamiPressureExtrapolation()
                    # Overwrite the callbacks
                    callbacks = CallbackSet(info_callback, saving_callback, saving_paper)

                    # Run simulation with updated parameters
                    trixi_include(joinpath(pwd(), folder, "Performance", simulation, method, "default.jl"),
                            resolution=resolution,
                            neighborhood_search=neighborhood_search,
                            callbacks=callbacks,
                            alpha=alpha,
                            smoothing_length=smoothing_length,
                            smoothing_kernel=smoothing_kernel,
                            boundary_density_calculator=boundary_density_calculator,
                            cfl=cfl)

                    path = joinpath(pwd(), "Results", "Performance", simulation, method)
                    plot_name = file_name * "_" * string(resolution) * "_cfl" * cfl_string * "_sl" * sl_string
                    # Full path of the new plot
                    full_path = joinpath(path, plot_name1)
                    # plot and safe the plot
                    plt = plot(sol)
                    savefig(plt, full_path)
                    i+=1
                    text = "Simualtion " * string(i) * "================================================================"
                    println(text)
                end
            end
        end
    end
end
