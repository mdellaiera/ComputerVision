function angle_mask = AngleMask(angular_grid, orientation, number_of_orientations)

% Compute scaling coefficient
order = number_of_orientations - 1;
alpha = (2^(2 * order)) * (factorial(order)^2);
alpha = alpha / (number_of_orientations * factorial(2 * order));

angle = mod(pi + angular_grid - pi * (orientation - 1) / number_of_orientations, 2 * pi) - pi;

angle_mask = 2 * sqrt(alpha) * cos(angle).^order ; 
angle_mask = angle_mask .* (abs(angle) < pi / 2);

end
