using GraphTheoryMips
#using Base.Test
using FactCheck
using JuMP
using Cbc
using LightGraphs


function make_simple_undirected_graph{T<:Integer}(n::T, edgelist::Vector{Tuple{T,T}})
    g = Graph(n)
    for (s,d) in edgelist
        add_edge!(g, Edge(s,d))
    end
    return g
end

function PetersenGraph()
    e = [
        (1, 2), (1, 5), (1, 6),
        (2, 3), (2, 7),
        (3, 4), (3, 8),
        (4, 5), (4, 9),
        (5, 10),
        (6, 8), (6, 9),
        (7, 9), (7, 10),
        (8, 10)
    ]
    return make_simple_undirected_graph(10,e)
end

facts("Testing graph mips") do
    petersen = PetersenGraph()
    k_3_3 = CompleteBipartiteGraph(3,3)
    
    @fact length(bin_decisions(max_independent_set(petersen))) --> 4
    @fact length(bin_decisions(min_dominating_set(petersen)))  --> 3
    @fact length(bin_decisions(min_vertex_cover(petersen)))    --> 6
    @fact distances(petersen, 1)[3]                            --> 2
    @fact length(bin_decisions(bipartite_set(k_3_3)))          --> 3
end

# write your own tests here
#@test 1 == 1
