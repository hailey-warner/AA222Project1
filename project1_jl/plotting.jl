using Plots

"""
Plot optimization history over contours for 2D functions
"""
function plot_history(history, f, prob)
    if length(history[1]) != 2
        return  # Only plot 2D functions
    end
    
    # Create grid for contour plot
    x = range(-3, 3, length=100)
    y = range(-3, 3, length=100)
    z = [f([i,j]) for i in x, j in y]
    
    # Create contour plot
    p = contour(x, y, z, 
                levels=50,
                color=:viridis,
                fill=true)
    
    # Extract path coordinates
    xs = [h[1] for h in history]
    ys = [h[2] for h in history]
    
    # Plot optimization path
    plot!(xs, ys, 
          color=:black,
          linewidth=2,
          label="Optimization path")
    
    # Add start and end points
    scatter!([xs[1]], [ys[1]], 
            color=:green,
            markersize=6,
            label="Start")
    scatter!([xs[end]], [ys[end]], 
            color=:red,
            markersize=6,
            label="End")
            
    xlabel!("x₁")
    ylabel!("x₂")
    title!("$prob optimization path")
    
    # Save the plot
    savefig(p, "$(prob)_optimization.png")
    return p
end