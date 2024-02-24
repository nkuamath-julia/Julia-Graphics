using Plots

A = [];

function f(x, y)
	x = Int64(x); y = Int64(y);
	for p in A
		if p[1] == x && p[2] == y
			return p[3];
		end
	end
	return 0;
end

# Bresenham algorithm for circle
function circle(x1, y1, r, color)
	x = 0; 
	y = r;
	e = 3-2*r;
	while x <= y
		global A = [A;(x+x1, y+y1, color)]; # octant 2
		global A = [A;(y+x1, x+y1, color)]; # octant 1
		global A = [A;(-x+x1, y+y1, color)]; # octant 3
		global A = [A;(-y+x1, x+y1, color)]; # octant 4
		global A = [A;(-y+x1, -x+y1, color)]; # octant 5
		global A = [A;(-x+x1, -y+y1, color)]; # octant 6
		global A = [A;(x+x1, -y+y1, color)]; # octant 7
		global A = [A;(y+x1, -x+y1, color)]; # octant 8
		x += 1;
		if e >= 0
			y -= 1;
			e -= 4*y;
		end
		e += 4*x + 2;
	end
end

# Enter here the coordinates of the 2 points.
P1 = (100,100);
R = 50;

x = range(0, 200);
y = range(0, 200);
for i in 1:20
	circle(P1[1], P1[2], R-i, div(i,2));
end

heatmap(x, y, f, c = :deep, aspect_ratio=:equal);
