
function bin_decisions(b::JuMP.JuMPContainer)
    ret = []
    for v in keys(b)
        b[v...] == 1.0 && push!(ret,v)
    end
    ret
end
