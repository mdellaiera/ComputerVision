function [difference_of_gaussians, axis_spatial] = DifferenceOfGaussians(k, i, sigma, radius)

axis_spatial = -ceil(radius) : ceil(radius);

sigma_1 = k^(i + 1) * sigma;
sigma_2 = k^(i) * sigma;

[gaussian_1, ~] = Gaussian(sigma_1, radius);
[gaussian_2, ~] = Gaussian(sigma_2, radius);

difference_of_gaussians = gaussian_1 - gaussian_2;
difference_of_gaussians = difference_of_gaussians / sum(abs(difference_of_gaussians));

end

