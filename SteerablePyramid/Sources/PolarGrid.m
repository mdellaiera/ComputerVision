function [radial_grid, angular_grid] = PolarGrid(rows, cols)

x_center = ceil((cols + 0.5) / 2); 
y_center = ceil((rows + 0.5) / 2); 

% Compute x- and y-coordinates vector centered on x_center and y_center
x_vector = ((1 : cols) - x_center) / (cols / 2);
y_vector = ((1 : rows) - y_center) / (rows / 2); 

% Create 2-D grids of coordinates
[x_ramp, y_ramp] = meshgrid(x_vector, y_vector);

radial_grid = sqrt(x_ramp.^2 + y_ramp.^2);
angular_grid = atan2(y_ramp, x_ramp);

% Remove values equal to 0 for log computing
radial_grid(y_center, x_center) =  radial_grid(y_center, x_center - 1);

end
