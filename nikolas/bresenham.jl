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
	if dy > 0
		if dx > 0
			if dy >= dx
				return 2;
			else
				return 1;
			end
		else
			if dy >= -dx
				return 3;
			else
				return 4;
			end
		end
	else
		if dx < 0
			if dy >= dx
				return 5;
			else
				return 6;
			end
		else
			if dy >= -dx
				return 8;
			else
				return 7;
			end
		end
	end
end

# Bresenham algorithm for octants 1,2
function bresline(x1, y1, x2, y2, color)
	oct = octant_decider(x1, y1, x2, y2);
	
	if oct == 2
		temp = x1; x1 = y1; y1 = temp;
		temp = x2; x2 = y2; y2 = temp;
	elseif oct == 3
		x2 = -x2;
		temp = x1; x1 = y1; y1 = temp;
		temp = x2; x2 = y2; y2 = temp;
	elseif oct == 4
		x2 = -x2;
	elseif oct == 5
		oct = 1
		temp = x1; x1 = x2; x2 = temp; # swap the 2 points to subsume to oct2 
		temp = y1; y1 = y2; y2 = temp;
	elseif oct == 6
		oct = 2
		temp = x1; x1 = x2; x2 = temp; # swap the 2 points to subsume to oct2 
		temp = y1; y1 = y2; y2 = temp;
		temp = x1; x1 = y1; y1 = temp; # swap for the symmetrical to y=x to implement oct1
		temp = x2; x2 = y2; y2 = temp;
	elseif oct == 7
		y2 = -y2;
		temp = x1; x1 = y1; y1 = temp;
		temp = x2; x2 = y2; y2 = temp;
	elseif oct == 8
		y2 = -y2;
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
		elseif oct == 3
			global A = [A;(-y, x, color)];
		elseif oct == 4
			global A = [A;(-x, y, color)];
		elseif oct == 7
			global A = [A;(y, -x, color)];
		elseif oct == 8
			global A = [A;(x, -y, color)];
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
P1 = (0,0);
P2 = (200,-100);


x = range(min(P1[1], P2[1]), max(P1[1], P2[1]));
y = range(min(P1[2], P2[2]), max(P1[2], P2[2]));
bresline(P1[1], P1[2], P2[1], P2[2], 1);
heatmap(x, y, f, c = :deep, aspect_ratio=:equal);
