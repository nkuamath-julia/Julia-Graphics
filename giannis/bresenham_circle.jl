using Plots

function draw_rectangle(x, y)
    # Define the coordinates of the rectangle vertices
    x_vertices = [x - 0.5, x + 0.5, x + 0.5, x - 0.5, x - 0.5]
    y_vertices = [y - 0.5, y - 0.5, y + 0.5, y + 0.5, y - 0.5]

    # Plot the rectangle
    plot!(x_vertices, y_vertices, aspect_ratio=:equal, linewidth=2, color=:blue, fill=true)
end

# Bresenham algorithm for circle
function Bresenham_circle(x_c, y_c, r)
    x = 0
    y = r

    er = 3-2*r
    plot(0,0)
    while x <= y
		draw_rectangle(x+x_c ,y+y_c)
		draw_rectangle(x+x_c ,-y+y_c)
		draw_rectangle(-x+x_c ,y+y_c) 
		draw_rectangle(-x+x_c ,-y+y_c) 
		draw_rectangle(y+x_c ,x+y_c)
		draw_rectangle(-y+x_c ,x+y_c)
		draw_rectangle(y+x_c ,-x+y_c) 
		draw_rectangle(-y+x_c ,-x+y_c)
		
		x = x + 1;
		if er >= 0
			y = y - 1;
			er = er - 4 * y;
		end 
		er = er + 4*x + 2;
	end
    plot!(title = "Bresenham circle: C($x_c,$y_c, r=$r)", aspect_ratio=1, legend=false)
    # scatter!(xPoints, yPoints, markersize=3, xlabel="x", ylabel="y", legend=false)
    savefig("giannis/circle.png")   
end


Bresenham_circle(1, 1, 100)