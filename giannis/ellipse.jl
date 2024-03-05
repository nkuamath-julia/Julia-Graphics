using Plots

function draw_rectangle(x, y)
    # Define the coordinates of the rectangle vertices
    x_vertices = [x - 0.5, x + 0.5, x + 0.5, x - 0.5, x - 0.5]
    y_vertices = [y - 0.5, y - 0.5, y + 0.5, y + 0.5, y - 0.5]

    # Plot the rectangle
    plot!(x_vertices, y_vertices, aspect_ratio=:equal, linewidth=2, color=:blue, fill=true)
end

function ellipse(a,b)
    x = a;
    y = 0;
    asqr = a^2
    bsqr = b
    a22 = 2* asqr
    b22 = 2* bsqr
    xslope = b22 * a
    yslope = 0

    fmid = bsqr*(0.25-x) + asqr

    # Area1
    plot(0,0)
    while (xslope>yslope)
        draw_rectangle(x,y)
        draw_rectangle(-x,-y) 
        draw_rectangle(x,-y) 
        draw_rectangle(-x,y)
        y = y + 1;
        yslope = yslope + a22; 
        if fmid >= 0
            x = x - 1;  
            xslope = xslope - b22; 
            fmid = fmid - xslope;
        end 
        fmid = fmid + yslope + asqr;
    end
    
    #Border
    fmid = fmid - (yslope + xslope)/2 + 0.75*( bsqr - asqr);
    
    # Area 2 
    while x >= 0
        draw_rectangle(x,y)
        draw_rectangle(-x,-y)
        draw_rectangle(x,-y)
        draw_rectangle(-x,y)    
        x = x - 1;
        xslope = xslope - b22; 
        if fmid <= 0
            y = y + 1;
            yslope = yslope + a22; fmid = fmid + yslope;
        end 
        fmid = fmid - xslope + bsqr;
    end
    plot!(title = "Bresenham ellipe: K(a=$a,b=$b)", aspect_ratio=1, legend=false)
    # scatter!(xPoints, yPoints, markersize=3, xlabel="x", ylabel="y", legend=false)
    savefig("giannis/ellipse.png")       
end