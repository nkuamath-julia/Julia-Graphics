using Plots

function Bresenham_first_oct(x1, y1, x2, y2)
    println("(x1,y1)",x1,y1)
    println("(x2,y2)",x2,y2)
    
    dx = x2 - x1
    dy = y2 - y1
    x = x1
    y = y1
    c1 = 2 * dy
    e = 2 * dy - dx
    c2 = e - dx
    
    # Initialize L matrix with data points (x2-x1+1 points)
    L = zeros(Int, 2, dx + 1)
    
    L[1, 1] = x
    L[2, 1] = y

    while x <= x2
        # Push x and y into matrix L
        L[1, x - x1 + 1] = x
        L[2, x - x1 + 1] = y
        
        x += 1
        # println("x",x)
        if e < 0
            e += c1
        else
            y += 1
            e += c2
        end
    end
    println(L)
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
        println("oct1")
        xPoints, yPoints = Bresenham_first_oct(x1, y1, x2, y2)  
    elseif s > 1 # oct 2
        println("oct2")
        xPoints, yPoints = Bresenham_first_oct(y1, x1, y2, x2) 
        
        #from 1st octant, back to 2nd so i switch xPoints with yPoints
        xPoints, yPoints = yPoints, xPoints
    elseif s < -1 # oct 3
        println("oct3")
        xPoints, yPoints = Bresenham_first_oct(y1, -x1, y2, -x2) 
        #from 1st octant, back to 3rd so:
            #1. switch xPoints with yPoints to go to 2nd octant 
            xPoints, yPoints = yPoints, xPoints
            #2. mirror with respect to new xPoints to go from 2nd to third
            xPoints, yPoints = -xPoints, yPoints

    else # oct 4
        println("oct4")
        xPoints, yPoints = Bresenham_first_oct(-x1, y1, -x2, y2)
         #from 1st octant, back to 4rd so:
            #1. mirror with respect to xPoints 
            xPoints, yPoints = -xPoints, yPoints
    end
    
    
    scatter(xPoints, yPoints, markersize=3, xlabel="x", ylabel="y", legend=false)
    # plot(xPoints, yPoints, xlabel="x", ylabel="y", legend=false, lc=:red) uncomment to add line
    for i in 1:length(xPoints)
        draw_rectangle(xPoints[i], yPoints[i])
    end

    plot!(title = "Bresenham line: ($x1,$y1) -> ($x2,$y2)", aspect_ratio=1)
    # scatter!(xPoints, yPoints, markersize=3, xlabel="x", ylabel="y", legend=false)
    savefig("giannis/line.png")   
end

function draw_rectangle(x, y)
    # Define the coordinates of the rectangle vertices
    x_vertices = [x - 0.5, x + 0.5, x + 0.5, x - 0.5, x - 0.5]
    y_vertices = [y - 0.5, y - 0.5, y + 0.5, y + 0.5, y - 0.5]

    # Plot the rectangle
    plot!(x_vertices, y_vertices, aspect_ratio=:equal, linewidth=2, color=:blue, fill=true, alpha=0.5)
end

Bresenham_line(-3, 5, 0, 0)