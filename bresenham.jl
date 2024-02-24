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

function octant_decider(x1, y1, x2, y2)
	dx = x2 - x1;
	dy = y2 - y1;
	if 0 < dy && dy <= dx
		return 1;
	elseif dy > dx && dx > 0
		return 2;
	elseif dy > -dx && dy > 0
		return 3;
	elseif dy < -dx && dy > 0
		return 4;
	elseif dy <= dx && dy < 0
		return 5;
	elseif dy > dx && dx < 0
		return 6;	
	elseif dy > -dx && dy < 0
		return 7;
	elseif dy < -dx && dy > 0
		return 8;
	end
end

# Bresenham algorithm for octants 1,2
function bresline(x1, y1, x2, y2, color)
	oct = octant_decider(x1, y1, x2, y2);
	
	if oct == 2
		temp = x1; x1 = y1; y1 = temp;
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
		if oct == 1
			global A = [A;(x, y, color)];
		elseif oct == 2
			global A = [A;(y, x, color)];
		end
		x += 1;
		if e < 0
			e += c1;
		else
			y += 1;
			e += c2;
		end
	end
end

# classic plot
#x = range(1, 2*pi, length = 100)
#plot(x, sin)

# Enter here the coordinates of the 2 points.
P1 = (50,195);
P2 = (100,200);
P3 = (95, 30);
P4 = (20, 0);
P5 = (25, 50);

x = range(0, 150);
y = range(0, 200);
A=[(0,0,1)];
bresline(P1[1], P1[2], P2[1], P2[2], 0.8);
bresline(P3[1], P3[2], P2[1], P2[2], 0.8);
bresline(P4[1], P4[2], P3[1], P3[2], 0.8);
bresline(P4[1], P4[2], P5[1], P5[2], 0.8);
heatmap(x, y, f, c = :deep, aspect_ratio=:equal);
