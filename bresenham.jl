using Plots

function f(x, y)
	x = Int64(x); y = Int64(y);
	if (x,y) in A
		return 1;
	end
	return 0;
end

# Bresenham algorithm for 1st octant
function bresline1(x1, y1, x2, y2)
	A = []
	dx = x2 - x1;
	dy = y2 - y1;
	x = x1;
	y = y1;
	c1 = 2*dy;
	e = 2*dy - dx;
	c2 = e - dx;
	while x <= x2
		A = [A;(x,y)];
		x += 1;
		if e < 0
			e += c1;
		else
			y += 1;
			e += c2;
		end
	end
	return A;
end

# classic plot
#x = range(1, 2*pi, length = 100)
#plot(x, sin)

# Enter here the coordinates of the 2 points.
P1 = (0,0);
P2 = (200,150);

x = range(1, max(P1[1], P2[1]), length = max(P1[1], P2[1]));
y = range(1, max(P1[2], P2[2]), length = max(P1[2], P2[2]));
A = bresline1(P1[1], P1[2], P2[1], P2[2]);
heatmap(x, y, f, c = :deep, aspect_ratio=:equal);
