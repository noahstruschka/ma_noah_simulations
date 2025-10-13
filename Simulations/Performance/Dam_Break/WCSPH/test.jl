simulation = "Dam_Break"
method = "WCSPH"
# Load the iisph example

file_name = ""
for i in 1:5
    file_name = "Sim" * string(i) * ".jl"
    println(file_name)
    trixi_include(joinpath(pwd(), "Performance", simulation, method, file_name))
end