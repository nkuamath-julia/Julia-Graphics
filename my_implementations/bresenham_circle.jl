using Plots
rectangle(w, h, x, y) = Shape([x, x+w, x+w, x, x], [y, y, y+h, y+h, y])
pixel(x, y) = rectangle(1, 1, x, y)#using old definition, tell me if you prefer it over pixel(x, y) = rectangle(1, 1, x-0.5, y-0.5)

function circle(r, x_c, y_c, col=:yellow)
er = 3-2*r
x = 0
y = r
axis_lim = 1.5*r
plot(xlims = (x_c - axis_lim, x_c + axis_lim), y_lims = (y_c - axis_lim, y_c + axis_lim), legend = false, aspect_ratio = :equal)
while x<=y
plot!(pixel(x+x_c, y+y_c), c = col)
plot!(pixel(y+x_c, x+y_c), c = col)
plot!(pixel(y+x_c, -x+y_c), c = col)
plot!(pixel(x+x_c, -y+y_c), c = col)
plot!(pixel(-x+x_c, -y+y_c), c = col)
plot!(pixel(-y+x_c, -x+y_c), c = col)
plot!(pixel(-y+x_c, x+y_c), c = col)
plot!(pixel(-x+x_c, y+y_c), c = col)
if er>=0
y -= 1
er -= 4*y
end
x += 1
er += 4*x + 2
end
savefig("circle.png")
end

#for i=5:10
#circle(i, 0, 0, RGBA(1, 1, 0, 5/i))
#end

circle(5, 8, 4)