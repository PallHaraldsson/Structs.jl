using Test, Dates, UUIDs, Structs

struct TestStyle <: Structs.StructStyle end

include(joinpath(dirname(pathof(Structs)), "../test/macros.jl"))
include(joinpath(dirname(pathof(Structs)), "../test/struct.jl"))

@testset "Structs" begin

# Dict{Symbol, Int}, NamedTuple, A struct, Vector Pair
d = Dict(:a => 1, :b => 2, :c => 3, :d => 4)
ds = Dict("a" => 1, "b" => 2, "c" => 3, "d" => 4)
nt = (a = 1, b = 2, c = 3, d = 4)
a = A(1, 2, 3, 4)
aa = AA(1, 2, 3, 4, 5)
b = B(); b.a = 1; b.b = 2; b.c = 3; b.d = 4; b
bb = BB()
vp = [:a => 1, :b => 2, :c => 3, :d => 4]
v = [1, 2, 3, 4]
t = (1, 2, 3, 4)

println("Dict{Symbol, Int}")
@test Structs.make(Dict{Symbol, Int}, d) == d
@test Structs.make(Dict{Symbol, Int}, ds) == d
@test Structs.make(Dict{Symbol, Int}, nt) == d
@test Structs.make(Dict{Symbol, Int}, a) == d
@test Structs.make(Dict{Symbol, Int}, vp) == d
# @test Structs.make(Dict{Symbol, Int}, aa) == d # fails because of extra field
@test Structs.make(Dict{Symbol, Int}, v) == Dict(Symbol(1) => 1, Symbol(2) => 2, Symbol(3) => 3, Symbol(4) => 4)
@test Structs.make(Dict{Symbol, Int}, t) == Dict(Symbol(1) => 1, Symbol(2) => 2, Symbol(3) => 3, Symbol(4) => 4)
@test Structs.make(Dict{Symbol, Int}, b) == d
@test Structs.make(Dict{Symbol, Int}, bb) == d

println("NamedTuple")
@test Structs.make(typeof(nt), d) == nt
@test Structs.make(typeof(nt), ds) == nt
@test Structs.make(typeof(nt), nt) == nt
@test Structs.make(typeof(nt), a) == nt
@test Structs.make(typeof(nt), vp) == nt
@test Structs.make(typeof(nt), v) == nt
@test Structs.make(typeof(nt), t) == nt
@test Structs.make(typeof(nt), aa) == nt # extra field is ignored
@test Structs.make(typeof(nt), b) == nt
@test Structs.make(typeof(nt), bb) == nt

println("A struct")
@test Structs.make(A, d) == a
@test Structs.make(A, ds) == a # slower
@test Structs.make(A, nt) == a
@test Structs.make(A, a) == a
@test Structs.make(A, vp) == a
@test Structs.make(A, v) == a # relies on order of vector elements
@test Structs.make(A, t) == a # relies on order of tuple elements
@test Structs.make(A, aa) == a # extra field is ignored
@test Structs.make(A, b) == a
@test Structs.make(A, bb) == a

println("AA struct")
@test Structs.make(AA, d) == aa # works because of AA field e default
@test Structs.make(AA, ds) == aa
@test Structs.make(AA, nt) == aa
@test Structs.make(AA, a) == aa
@test Structs.make(AA, vp) == aa
@test Structs.make(AA, v) == aa # relies on order of vector elements
@test Structs.make(AA, t) == aa # relies on order of tuple elements
@test Structs.make(AA, aa) == aa # extra field is ignored
@test Structs.make(AA, b) == aa
@test Structs.make(AA, bb) == aa

println("B struct")
@test Structs.make(B, d) == b
@test Structs.make(B, ds) == b
@test Structs.make(B, nt) == b
@test Structs.make(B, a) == b
@test Structs.make(B, vp) == b
@test Structs.make(B, v) == b # relies on order of vector elements
@test Structs.make(B, t) == b # relies on order of tuple elements
@test Structs.make(B, aa) == b # extra field is ignored
@test Structs.make(B, b) == b
@test Structs.make(B, bb) == b

println("BB struct")
@test Structs.make(BB, d) == bb
@test Structs.make(BB, ds) == bb
@test Structs.make(BB, nt) == bb
@test Structs.make(BB, a) == bb
@test Structs.make(BB, vp) == bb
@test Structs.make(BB, v) == bb # relies on order of vector elements
@test Structs.make(BB, t) == bb # relies on order of tuple elements
@test Structs.make(BB, aa) == bb # extra field is ignored
@test Structs.make(BB, b) == bb
@test Structs.make(BB, bb) == bb

println("Vector Pair")
# @test Structs.make(typeof(vp), d) == vp # unordered Dict doesn't work
# @test Structs.make(typeof(vp), ds) == vp # unordered Dict doesn't work
@test Structs.make(typeof(vp), nt) == vp
@test Structs.make(typeof(vp), a) == vp
@test Structs.make(typeof(vp), vp) == vp

println("Vector")
# @test Structs.make(typeof(v), d) == v # relies on order of Dict elements
# @test Structs.make(typeof(v), ds) == v # relies on order of Dict elements
@test Structs.make(typeof(v), nt) == v
@test Structs.make(typeof(v), a) == v
@test Structs.make(typeof(v), vp) == v
@test Structs.make(typeof(v), v) == v
@test Structs.make(typeof(v), t) == v
# @test Structs.make(typeof(v), aa) == v # fails because of extra field

println("Tuple")
# @test Structs.make(typeof(t), d) == t # relies on order of Dict elements
# @test Structs.make(typeof(t), ds) == t # relies on order of Dict elements
@test Structs.make(typeof(t), nt) == t
@test Structs.make(typeof(t), a) == t
@test Structs.make(typeof(t), vp) == t
@test Structs.make(typeof(t), v) == t
@test Structs.make(typeof(t), t) == t
@test Structs.make(typeof(t), aa) == t

println("C")
@test Structs.make(C, ()) == C()
@test Structs.make(C, (1,)) == C()

println("D")
@test Structs.make(D, (1, 3.14, "hey")) == D(1, 3.14, "hey")

println("Wrapper")
@test Structs.make(Wrapper, Dict("x" => Dict("a" => 1, "b" => "hey"))) == Wrapper((a=1, b="hey"))

println("UndefGuy")
x = Structs.make(UndefGuy, (id=1, name="2"))
@test x.id == 1 && x.name == "2"
x = Structs.make(UndefGuy, (id=1,))
@test x.id == 1 && !isdefined(x, :name)

println("E")
@test Structs.make(E, Dict("id" => 1, "a" => (a=1, b=2, c=3, d=4))) == E(1, A(1, 2, 3, 4))

println("G")
@test Structs.make(G, Dict("id" => 1, "rate" => 3.14, "name" => "Jim", "f" => Dict("id" => 2, "rate" => 6.28, "name" => "Bob"))) == G(1, 3.14, "Jim", F(2, 6.28, "Bob"))

println("H")
x = Structs.make(H, (id=0, name="", properties=Dict("a" => 1), addresses=["a", "b", "c"]))
@test x.id == 0 && x.name == "" && x.properties == Dict("a" => 1) && x.addresses == ["a", "b", "c"]

println("I")
@test Structs.make(I, (id=2, name="Aubrey", fruit=apple)) == I(2, "Aubrey", apple)

println("Vehicle")
Structs.choosetype(::Type{Vehicle}, source) = source["type"] == "car" ? Car : Truck
x = Structs.make(Vehicle, Dict("type" => "car", "make" => "Toyota", "model" => "Corolla", "seatingCapacity" => 4, "topSpeed" => 120.5))
@test x == Car("Toyota", "Corolla", 4, 120.5)

println("J")
@test Structs.make(J, (id=1, name=nothing, rate=3.14)) == J(1, nothing, 3.14)
@test Structs.make(J, (id=nothing, name=nothing, rate=3)) == J(nothing, nothing, 3)

println("Recurs")
@test Structs.make(Recurs, (id=0, value=(id=1, value=(id=2, value=(id=3, value=(id=4, value=nothing)))))) == Recurs(0, Recurs(1, Recurs(2, Recurs(3, Recurs(4, nothing)))))

println("O")
@test Structs.make(O, (id=0, name=missing)) == O(0, missing)
@test Structs.make(O, (id=0, name=nothing)) == O(0, nothing)
@test Structs.make(O, (id=0, name=(id=2, first_name="Jim", rate=3.14))) == O(0, L(2, "Jim", 3.14))
@test Structs.make(O, (id=0, name=(id=2, name="Jane", fruit=banana))) == O(0, I(2, "Jane", banana))

println("P")
p = Structs.make(P, (id=0, name="Jane"))
@test p.id == 0 && p.name == "Jane"

end