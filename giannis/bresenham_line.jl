using Plots

function Bresenham_first_oct(x1, y1, x2, y2) 
    dx = x2 - x1
    dy = y2 - y1
    x = x1
    y = y1
    c1 = 2 * dy
    e = 2 * dy - dx
    c2 = e - dx
    
    # Initialize L matrix with data points (x2-x1+1 points)
    L = zeros(Int, 2, dx + 1)
    
    L[1, 1] = x #x coordinates in 1st row
    L[2, 1] = y #y coordinates in 2nd row

    while x <= x2
        L[1, x - x1 + 1] = x
        L[2, x - x1 + 1] = y
        
        x += 1
        if e < 0
            e += c1
        else
            y += 1
            e += c2
        end
    end
    return [L[1,:], L[2,:]]
end

function Bresenham_line(x1, y1, x2, y2)
# Select starting point with the smallest y coordinate
    if y2 < y1
        x1, x2 = x2, x1
        y1, y2 = y2, y1
    end       
# Find octants
    dx = x2 - x1
    dy = y2 - y1
    s = dy/dx
    if s <= 1 && s >= 0 # oct 1
        xPoints, yPoints = Bresenham_first_oct(x1, y1, x2, y2)  
    elseif s > 1 # oct 2
        xPoints, yPoints = Bresenham_first_oct(y1, x1, y2, x2) 
        
        xPoints, yPoints = yPoints, xPoints #from 1st octant, back to 2nd so i switch xPoints with yPoints

    elseif s < -1 # oct 3
        xPoints, yPoints = Bresenham_first_oct(y1, -x1, y2, -x2) 
        #from 1st octant, back to 3rd: 
            xPoints, yPoints = yPoints, xPoints #1. switch xPoints with yPoints to go to 2nd octant 
            
            xPoints, yPoints = -xPoints, yPoints #2. mirror with respect to new xPoints to go from 2nd to third

    else # oct 4
        xPoints, yPoints = Bresenham_first_oct(-x1, y1, -x2, y2)
        
        xPoints, yPoints = -xPoints, yPoints #from 1st octant, back to 4rd so: mirror with respect to xPoints 
    end
    
    # return [xPoints,yPoints]

    scatter(xPoints, yPoints, markersize=3, xlabel="x", ylabel="y", legend=false)
    # plot(xPoints, yPoints, xlabel="x", ylabel="y", legend=false, lc=:red) uncomment to add line

    for i in 1:size(xPoints,1)
        draw_rectangle(xPoints[i], yPoints[i], "blue")
    end

    plot!(title = "Bresenham line: ($x1,$y1) -> ($x2,$y2)", aspect_ratio=1)
    scatter!(xPoints, yPoints, markersize=3, xlabel="x", ylabel="y", legend=false)
    savefig("giannis/outputs/line.png")   
end

function draw_rectangle(x, y, color)
    # Define the coordinates of the rectangle vertices
    x_vertices = [x - 0.5, x + 0.5, x + 0.5, x - 0.5, x - 0.5]
    y_vertices = [y - 0.5, y - 0.5, y + 0.5, y + 0.5, y - 0.5]

    # Plot the rectangle
    plot!(x_vertices, y_vertices, aspect_ratio=:equal, linewidth=2, color=color, fill=true,alpha=0.5)
end

function Bresenham_2(x1,y1,x2,y2,x3,y3,x4,y4)
    xPoints1,yPoints1 = Bresenham_line(x1, y1, x2, y2)
    xPoints2,yPoints2 = Bresenham_line(x3, y3, x4, y4)

    scatter(xPoints1, yPoints1, markersize=3, xlabel="x", ylabel="y", legend=false)
    scatter!(xPoints2, yPoints2, markersize=3, xlabel="x", ylabel="y", legend=false)

    for i in 1:size(xPoints1,1)
        draw_rectangle(xPoints1[i], yPoints1[i],"blue")  
    end
    for i in 1:size(xPoints2,1)
        draw_rectangle(xPoints2[i], yPoints2[i], "green")        
    end
    x = 0:0.1:8
    plot!(x, x, markersize=3, xlabel="x", ylabel="y", color="black", linewidth=0.5, legend=false, label="x=y")
    savefig("giannis/outputs/line-together.png")   
end    

Bresenham_line(0, 0, 3, 2)
# Bresenham_2(2, 1, 5, 3, 1, 2, 3, 5)  