using WellIO
using Test

data = WellIO.load("./data/Bean_A.las")

@testset "WellIO.jl" begin
    @test typeof(data.version) <: String
    @test typeof(data.wellinfo) <: String
    @test typeof(data.curveinfo) <:String
    @test typeof(data.paraminfo) <: Nothing
    @test typeof(data.otherinfo) <: Nothing
    @test typeof(data.tabledata) <: String
end
