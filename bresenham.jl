using Plots

function f(x, y)
	x = Int64(x); y = Int64(y);
	if (x,y,1) in A
		return 1;
	end
	return 0;
end

function octant_decider(x1, y1, x2, y2)
	dx = x2 - x1;
	dy = y2 - y1;
	if 0 < dy && dy <= dx
		return 1;
	elseif dy > dx && dx > 0
		return 2;
	end
end


# Bresenham algorithm for 1st octant
function bresline1(x1, y1, x2, y2, color)
	A = []
	oct = octant_decider(x1, y1, x2, y2);
	
	if oct == 2
		temp = x2; x2 = y2; y2 = temp;
	end
	
	dx = x2 - x1;
	dy = y2 - y1;
	x = x1;
	y = y1;
	c1 = 2*dy;
	e = 2*dy - dx;
	c2 = e - dx;
	while x <= x2
		A = [A;(x, y, color)];
		x += 1;
		if e < 0
			e += c1;
		else
			y += 1;
			e += c2;
		end
	end
	
	if oct == 1
		return A;
	elseif oct == 2
		for i in 1:length(A)
			A[i] = (A[i][2], A[i][1], A[i][3]);
		end
		return A;
	end
end

# classic plot
#x = range(1, 2*pi, length = 100)
#plot(x, sin)

# Enter here the coordinates of the 2 points.
P1 = (0,0);
P2 = (150,200);

x = range(min(P1[1], P2[1]), max(P1[1], P2[1]));
y = range(min(P1[2], P2[2]), max(P1[2], P2[2]));
A = bresline1(P1[1], P1[2], P2[1], P2[2], 1);
heatmap(x, y, f, c = :deep, aspect_ratio=:equal);
