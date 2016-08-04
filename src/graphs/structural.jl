

function max_independent_set(g::Graph)

    m = Model(solver=CbcSolver())   

    @variable(m, b[v in vertices(g)], Bin)
   
    @constraint(m , nonadjacency[e in edges(g)], b[src(e)] + b[dst(e)] <= 1)

    @objective(m, Max, sum{b[v] , v in vertices(g)})

    solve(m)
    println("The max indepedent set has $(getobjectivevalue(m)) elements")      
    getvalue(b)
end

function min_dominating_set(g::Graph)

    m = Model(solver=CbcSolver())   

    @variable(m, b[v in vertices(g)], Bin)
   
    @constraint(m , dominance[u in vertices(g)], b[u] + sum{b[v], v in out_neighbors(g,u)} >= 1)

    @objective(m, Min, sum{b[v] , v in vertices(g)})

    solve(m)   
    println("The min dominating set has $(getobjectivevalue(m)) elements")
    getvalue(b)   
end


function min_vertex_cover(g::Graph)

    m = Model(solver=CbcSolver())   

    @variable(m, b[v in vertices(g)], Bin)
   
    @constraint(m , cover[e in edges(g)], b[src(e)] + b[dst(e)] >= 1)

    @objective(m, Min, sum{b[v] , v in vertices(g)})

    solve(m)   
    println("The min vertex cover has $(getobjectivevalue(m)) elements")
    getvalue(b)
end

function bipartite_set(g::Graph)

    m = Model(solver=CbcSolver())   

    @variable(m, b[v in vertices(g)], Bin)
   
    @constraint(m , cover[e in edges(g)], b[src(e)] + b[dst(e)] == 1)

    solve(m)   
    
    print("These vertices are independent : ")
    for(v in vertices(g))
        getvalue(b[v]) == 1 && print("$v, ") 
    end
    println()
    
    getvalue(b)   
end


function distances(g::Graph, root::Int)

    m = Model(solver=CbcSolver())   

    @variable(m, d[v in vertices(g)], Int)
   
    @constraint(m , d[root] == 0)
    @constraint(m , hop[e in edges(g)], -1 <= d[src(e)] - d[dst(e)] <= 1)

    @objective(m, Max, sum{d[v] , v in vertices(g)})

    solve(m)
    getvalue(d)
end
