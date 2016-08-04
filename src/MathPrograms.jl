module MathPrograms

using JuMP
using Cbc
#using Graphs
using LightGraphs

include("graphs/structural.jl")
include("graphs/flows.jl")
include("util.jl")

export

max_independent_set,
min_dominating_set,
min_vertex_cover,
distances,
bipartite_set,
bin_decisions

end
