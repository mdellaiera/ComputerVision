function [gaussian_filter, axis_spatial] = Gaussian(sigma, radius)

axis_spatial = -ceil(radius) : ceil(radius);
gaussian_filter = exp(-axis_spatial.^2 / (2 * sigma^2));
gaussian_filter = gaussian_filter / sum(gaussian_filter);

end

