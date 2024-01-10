# from a suggestion at https://discourse.julialang.org/t/install-a-packages-from-a-list/30920/3

using Pkg, Distributed

dependencies = [
    "JLD", 
    "LoopVectorization", 
    "Optim", 
    "NLsolve", 
    "StatsBase", 
    "Distributions", 
    "Plots", 
    "Revise"
]

Pkg.add(dependencies)

# dynamically start up cores if not done by command line
if nprocs() == 1
  addprocs(length(Sys.cpu_info()) ÷ 2 - 1)
end

