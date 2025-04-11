# using Plots

# include("helpers.jl")    # Include helpers first for @counted macro
# include("simple.jl")     # Then include simple functions
# include("project1.jl")   # Finally include optimization code



# function contour_plot(f, history)
#     x = range(-2, 2, length=100)
#     y = range(-2, 2, length=100)
#     f_values = [f([i, j])+1e-10 for i in x, j in y]
    
#     p = contour(x, y, f_values, levels=20, fill=true, c=:viridis)
    
#     # extract x and y coordinates from history
#     x_coords = [point[1] for point in history]
#     y_coords = [point[2] for point in history]
    
#     plot!(p, x_coords, y_coords, 
#           label="Optimization Path",
#           color=:red,
#           linewidth=2,
#           marker=:circle,
#           markersize=3)
    
#     # mark start and end points
#     scatter!([x_coords[1]], [y_coords[1]], 
#             color=:green,
#             markersize=3)
#     scatter!([x_coords[end]], [y_coords[end]], 
#             color=:red,
#             markersize=3)
    
#     return p
# end

# function convergence_plot(f, history)
#     # re-compute f history
#     f_values = [f(x) for x in history]
    
#     # array [1 ... 20]
#     iterations = 0:(length(history)-1)

#     p = plot(iterations, f_values,
#             xlabel="Iteration #",
#             ylabel="f(x)",
#             label="Convergence Plot",
#             yscale=:log10,  # Use log scale for y-axis
#             marker=:circle,
#             markersize=2,
#             linewidth=2)
            
#     return p
# end




# function_pairs = [
#     (rosenbrock, rosenbrock_gradient),
#     (himmelblau, himmelblau_gradient),
#     (powell, powell_gradient)
# ]
# methods = ["simple1", "simple2", "simple3"]

# # Define 2D and 4D starting points
# start_points_2d = [[-1.0, -1.0], [0.0, 0.0], [1.0, 1.0]]
# start_points_4d = [[-1.0, -1.0, -1.0, -1.0], [0.0, 0.0, 0.0, 0.0], [1.0, 1.0, 1.0, 1.0]]

# # contour plot (only for Rosenbrock)
# for (f, g) in function_pairs[1:1]
#     for start in start_points_2d
#         _, history = optimize(f, g, start, 1000, methods[1])
#         p = contour_plot(f, history)
#         title!(p, "Rosenbrock with simple1 from $(start)")
#         display(p)
#         savefig(p, "contour_rosenbrock_$(start).png")
#     end
# end

# # convergence plots
# for (i, (f, g)) in enumerate(function_pairs)
#     plots = []
#     # Use appropriate starting points based on function
#     points = i == 3 ? start_points_4d : start_points_2d
#     for start in points
#         _, history = optimize(f, g, start, 1000, methods[i])
#         p = convergence_plot(f, history)
#         push!(plots, p)
#     end
#     final_plot = plot(plots..., layout=(1,3), 
#                      title="$(methods[i]) Optimization",
#                      size=(900,300))
#     display(final_plot)
#     savefig(final_plot, "convergence_$(methods[i]).png")
# end