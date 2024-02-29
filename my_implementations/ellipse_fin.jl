using Plots
rectangle(w, h, x, y) = Shape([x, x+w, x+w, x, x], [y, y, y+h, y+h, y])
pixel(x, y) = rectangle(1, 1, x, y)

function ellipse_final(a, b, col = :yellow)
x=a
y=0.0
fmid = (0.25-a)*b^2 + a^2
while 2*b^2*x >= 2*a^2*y
plot!(pixel(x, y), c = col)
plot!(pixel(-x, y), c = col)
plot!(pixel(-x, -y), c = col)
plot!(pixel(x, -y), c = col, legend = false, aspect_ratio = :equal)
if fmid>=0
x -= 1
fmid -= 2*b^2*x
end
y += 1
fmid += 2*a^2*y+a^2
end
fmid = fmid - (2*a^2*y + 2*b^2*x)/2 + 0.75*(b^2 - a^2)
#plot!(pixel(x, b), c = :black)
while x>=0
plot!(pixel(x, y), c = col)
plot!(pixel(-x, y), c = col)
plot!(pixel(-x, -y), c = col)
plot!(pixel(x, -y), c = col, legend = false, aspect_ratio = :equal)
if fmid<=0
y += 1
fmid += 2*a^2*y
end
x -= 1
fmid += -2*b^2*x + b^2
end
savefig("ellipse.png")
end

ellipse_final(5, 6)