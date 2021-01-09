function contours = Contours(luminance, max_gradient, min_edges)

[gradient_x, gradient_y] = gradient(luminance);
luminance_gradient = sqrt(gradient_x.^2 + gradient_y.^2);

% Clip gradient beetwen max_gradient and min_gradient
luminance_gradient(luminance_gradient > max_gradient) = max_gradient;

% Normalise gradient
luminance_gradient = luminance_gradient / max_gradient; 

% Create a simple edge map using the gradient magnitudes.
edge_map = luminance_gradient; 
edge_map(edge_map < min_edges) = 0;

% Get contours
contours = 1 - edge_map;

end

