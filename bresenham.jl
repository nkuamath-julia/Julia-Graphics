using Plots

function f(x, y)
	x = Int64(x); y = Int64(y);
    if A[x,y] == 1
		return 1
	else
		return 0
	end
end

# Bresenham algorithm for 1st octant
function bresline1(x1, y1, x2, y2)
	A = zeros(x2, y2);
	dx = x2 - x1;
	dy = y2 - y1;
	x = x1;
	y = y1;
	c1 = 2*dy;
	e = 2*dy - dx;
	c2 = e - dx;
	while x <= x2
		A[x,y] = 1;
		x = x +1;
		if e < 0
			e = e + c1;
		else
			y = y + 1;
			e = e + c2;
		end
	end
	return A;
end

# Enter here the coordinates of the 2 points.
P1 = (1,1); 
P2 = (200,150);

x = range(1, max(P1[1], P2[1]), length = max(P1[1], P2[1]))
y = range(1, max(P1[2], P2[2]), length = max(P1[2], P2[2]))
A = bresline1(P1[1], P1[2], P2[1], P2[2]);
heatmap(x, y, f, c = :deep, aspect_ratio=:equal);
