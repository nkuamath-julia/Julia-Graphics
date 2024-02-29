using Plots
rectangle(w, h, x, y) = Shape([x, x+w, x+w, x, x], [y, y, y+h, y+h, y])
pixel(x, y) = rectangle(1, 1, x, y)

function circle(r, x_c, y_c, col=:yellow)
er = 3-2*r
x = 0
y = r
axis_lim = 1.5*r
while x<=y
plot!(pixel(x+x_c, y+y_c), xlims = (-axis_lim, axis_lim), y_lims = (-axis_lim, axis_lim), c = col, legend = false, aspect_ratio = :equal)
plot!(pixel(y+x_c, x+y_c), xlims = (-axis_lim, axis_lim), y_lims = (-axis_lim, axis_lim), c = col, aspect_ratio = :equal)
plot!(pixel(y+x_c, -x+y_c), xlims = (-axis_lim, axis_lim), y_lims = (-axis_lim, axis_lim), c = col, aspect_ratio = :equal)
plot!(pixel(x+x_c, -y+y_c), xlims = (-axis_lim, axis_lim), y_lims = (-axis_lim, axis_lim), c = col, aspect_ratio = :equal)
plot!(pixel(-x+x_c, -y+y_c), xlims = (-axis_lim, axis_lim), y_lims = (-axis_lim, axis_lim), c = col, aspect_ratio = :equal)
plot!(pixel(-y+x_c, -x+y_c), xlims = (-axis_lim, axis_lim), y_lims = (-axis_lim, axis_lim), c = col, aspect_ratio = :equal)
plot!(pixel(-y+x_c, x+y_c), xlims = (-axis_lim, axis_lim), y_lims = (-axis_lim, axis_lim), c = col, aspect_ratio = :equal)
plot!(pixel(-x+x_c, y+y_c), xlims = (-axis_lim, axis_lim), y_lims = (-axis_lim, axis_lim), c = col, aspect_ratio = :equal)
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

circle(5, 0, 0)