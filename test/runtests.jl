using WellIO
using Test

data = load("./data/Bean_A.las")

@testset "WellIO.jl" begin
    test type(data.version) == String
    test type(data.paraminfo) === nothing
    test type(data.otherinfo) === nothing
end
