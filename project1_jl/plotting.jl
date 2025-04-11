using Plots

include("helpers.jl")
include("simple.jl")
include("project1.jl")   

function contour_plot(f, x0)
    # make background
    x1_grid = range(-3, 3, length=100)
    x2_grid = range(-3, 3, length=100)
    f_vals = [f([i, j])+1e-10 for i in x1_grid, j in x2_grid]
    p = contour(x1_grid, x2_grid, f_vals, levels=20, fill=false, legend=false, c=:viridis)  

    # for 3 paths
    for x in x0
        x_list = optimize_progress(f, g, x, 20, "simple1")

        x1_vals = [x[1] for x in x_list]
        x2_vals = [x[2] for x in x_list]
    
        # mark path, start, end points
        plot!(p, x1_vals, x2_vals, color=:black, linewidth=2, marker=:circle, markersize=3)
        scatter!([x1_vals[1]], [x2_vals[1]], color=:green,markersize=3)
        scatter!([x1_vals[end]], [x2_vals[end]], color=:red,markersize=3)
        title!(p, "Rosenbrock Optimization")
        display(p)
        savefig(p, "contour_rosenbrock.png")
    end
    return p
end

# contour plot
f = rosenbrock
g = rosenbrock_gradient
x0 = [[-1.0, -1.0], [0.5, 0.5], [-0.5, -0.5]]
contour_plot(f, x0)

#################################################################################

functions = [("simple1", rosenbrock, rosenbrock_gradient),
             ("simple2", himmelblau, himmelblau_gradient),
             ("simple3", powell, powell_gradient)]

function convergence_plot(f, g, x0)
    p = plot(xlabel="Iterations", ylabel="f", legend=false, grid=true)
    for x in x0
        x_list = optimize_progress(f, g, x, 20, "simple1")
        f_vals = [f(x) for x in x_list]
        iterations = 1:length(f_vals)

        # mark path, start, end points
        plot!(p, iterations, f_vals, color=:black, linewidth=2, marker=:circle, markersize=3)
        title!(p, "Powell Convergence")
        display(p)
        savefig(p, "convergence_powell.png")
    end
    return p
end

x0_2d = [[-1.0, -1.0], [0.5, 0.5], [-0.5, -0.5]]
x0_4d = [[-1.0, -1.0, -1.0, -1.0], [0.5, 0.5, 0.5, 0.5], [-0.5, -0.5, -0.5, -0.5]]

#convergence_plot(rosenbrock, rosenbrock_gradient, x0_2d)
#convergence_plot(himmelblau, himmelblau_gradient, x0_2d)
#convergence_plot(powell, powell_gradient, x0_4d)