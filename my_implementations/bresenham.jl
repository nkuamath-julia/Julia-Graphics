function Bresenham1(x1, y1, dx, dy)
L = Vector{Int32}()
x=x1
y=y1
cx = 2*dx
cy = 2*dy
e = cy-dx
while x<=x1+dx
x = x+1
if e<0
e = e+cy
else
e = e+cy-cx
y = y+1
end
push!(L, y)
end
return L
end

function Bresenham(x1, y1, x2, y2)
dy = y2-y1
dx = x2-x1
if dy>0 && dx>0
if dx>dy
Bresenham1(x1, y1, dx, dy)
else
Bresenham1(y1, x1, dy, dx)
#points of the form [L[y], y]
end
end
end

#println(Bresenham(1,1,3,2))
#println(Bresenham(1,1,2,3))