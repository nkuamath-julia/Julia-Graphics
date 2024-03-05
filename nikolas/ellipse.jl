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

# Kappel algorithm for ellipse
function ellipse(a, b, color)
	x = a;
	y = 0;
	asqr = a^2;
	bsqr = b^2;
	a22 = 2*asqr;
	b22 = 2*bsqr;
	xslope = b22*a;
	yslope = 0;
	fmid = bsqr*(0.25 - x) + asqr;
	
	# Area 1
	while (xslope > yslope)
		global A = [A;(x, y, color)];
		global A = [A;(-x, -y, color)];
		global A = [A;(x, -y, color)];
		global A = [A;(-x, y, color)];
		y += 1;
		yslope += a22 ;
		if fmid >= 0
			x -= 1;
			xslope -= b22;
			fmid -= xslope;
		end
		fmid += yslope + asqr;
	end
	
	# Border
	fmid += -( yslope + xslope )/2 + 0.75*(bsqr - asqr);
	
	# Area 2
	while ( x >= 0)
		global A = [A;(x, y, color)];
		global A = [A;(-x, -y, color)];
		global A = [A;(x, -y, color)];
		global A = [A;(-x, y, color)];
		x -= 1;
		xslope -= b22 ;
		if fmid <= 0
			y += 1;
			yslope += a22 ;
			fmid += yslope ;
		end
		fmid += -xslope + bsqr ;
	end
end

# Enter here the coordinates of the 2 points.
P1 = (100,100);
R = 50;

x = range(-200, 200);
y = range(-200, 200);
ellipse(100,150,1);

heatmap(x, y, f, c = :deep, aspect_ratio=:equal);
savefig("myplot.png")
