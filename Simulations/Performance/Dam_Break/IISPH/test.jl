using TrixiParticles
using OrdinaryDiffEq

trixi_include(joinpath(pwd(),"Performance", "Dam_Break","IISPH","dam_break_2d_iisph.jl"), sol=nothing, ode=nothing)


resolution = 60

trixi_include(joinpath(pwd(),"Performance", "Dam_Break","IISPH","dam_break_2d_iisph.jl"), resolution=resolution)

println("Erfolgreich")