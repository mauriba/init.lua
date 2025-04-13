using Plots

x  = range(0, 8π; length = 100)
sx = @. sin(x)         # the @. macro broadcasts (vectorizes) every operation
cx = @. cos(2x^(1/2))

plot(x, [sx cx])
savefig("example.svg")
