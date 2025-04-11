#=
        project1.jl -- This is where the magic happens!

    All of your code must either live in this file, or be `include`d here.
=#

#=
    If you want to use packages, please do so up here.
    Note that you may use any packages in the julia standard library
    (i.e. ones that ship with the julia language) as well as Statistics
    (since we use it in the backend already anyway)
=#

# Example:
using LinearAlgebra

#=
    If you're going to include files, please do so up here. Note that they
    must be saved in project1_jl and you must use the relative path
    (not the absolute path) of the file in the include statement.

    [Good]  include("somefile.jl")
    [Bad]   include("/pathto/project1_jl/somefile.jl")
=#

# Example
# include("myfile.jl")

"""
    optimize(f, g, x0, n, prob)

Arguments:
    - `f`: Function to be optimized
    - `g`: Gradient function for `f`
    - `x0`: (Vector) Initial position to start from
    - `n`: (Int) Number of evaluations allowed. Remember `g` costs twice of `f`
    - `prob`: (String) Name of the problem. So you can use a different strategy for each problem. E.g. "simple1", "secret2", etc.

Returns:
    - The location of the minimum
"""
function optimize(f, g, x0, n, prob)

    # Nesterov momentum
    β = 0.4

    # Step factor
    if prob=="simple1"
        a = 0.001
    elseif prob=="simple2"
        a = 0.01
    elseif prob=="simple3"
        a = 0.001
    else
        a = 0.0075 #/(1 + k) # decaying step factor
    end

    v = zeros(length(x0)) # initial velocity for Nesterov momentum
    x_best = gradient_descent(f, g, x0, n, a, β, v, prob)

    return x_best
end

function gradient_descent(f, ∇f, x, k_max, a, β, v, prob)
    while count(f, ∇f) < k_max
        x = step!(f, ∇f, x, a, β, v)
    end
    return x
end

function step!(f, ∇f, x, a, β, v)
    # Nesterov momentum
    v .= β*v - a*∇f(x + β*v)
    return x + v
end



# FOR PLOTTING ONLY
function optimize_progress(f, g, x0, n, prob) 

    # Nesterov momentum
    β = 0.4

    # Step factor
    if prob=="simple1"
        a = 0.001
    elseif prob=="simple2"
        a = 0.01
    elseif prob=="simple3"
        a = 0.001
    else
        a = 0.0075 #/(1 + k) # decaying step factor
    end

    v = zeros(length(x0)) # initial velocity for Nesterov momentum
    x_list = [copy(x0)] 
    x = copy(x0)

    for i in 1:20 # n = 20 (don't add to count)
        v .= β*v - a*g(x + β*v)
        x .= x + v
        # track progress for plotting
        push!(x_list, copy(x))
    end
    return x_list
end