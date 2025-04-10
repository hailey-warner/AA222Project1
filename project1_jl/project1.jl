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
using Plots

#=
    If you're going to include files, please do so up here. Note that they
    must be saved in project1_jl and you must use the relative path
    (not the absolute path) of the file in the include statement.

    [Good]  include("somefile.jl")
    [Bad]   include("/pathto/project1_jl/somefile.jl")
=#

# Example
# include("myfile.jl")
include("plotting.jl")


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
    x_best, history = iterated_descent(f, g, x0, n)
    #plot_history(history, f, prob)
    return x_best
end

""" Plain Old Gradient Descent """

function iterated_descent(f, ∇f, x, k_max)
    history = [copy(x)]
    k=0
    while count(f, ∇f) < k_max
        #println("count: ", count(f, ∇f))
        a = 0.001#/(1 + k) # TODO: add decaying step factor
        x = step!(f, ∇f, x, a)
        push!(history, copy(x))
        k+=1
    end
    return x, history
end

function step!(f, ∇f, x, a)

    # clipped gradient descent step
    # grad_norm = norm(∇f(x))
    # if grad_norm > 1.0
    #     ∇f *= (1.0 / grad_norm)
    # end

    return x - a*∇f(x)
end





function line_search(f, x, d)
    objective = a -> f(x + a*d)
    a, b = bracket_minimum(objective)
    a = minimize(objective, a, b)
    return x + a*d
end

