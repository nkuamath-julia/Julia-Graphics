function draw_rectangle(x, y)
    # Define the coordinates of the rectangle vertices
    x_vertices = [x - 0.5, x + 0.5, x + 0.5, x - 0.5, x - 0.5]
    y_vertices = [y - 0.5, y - 0.5, y + 0.5, y + 0.5, y - 0.5]

    # Plot the rectangle
    plot(x_vertices, y_vertices, aspect_ratio=:equal,
         xlabel="x", ylabel="y", legend=false, linewidth=2, color=:blue, fill=true, alpha=0.5)
end

# Example usage:
draw_rectangle(2, 3)  # Draws a rectangle centered at (2, 3) with sides of length 1