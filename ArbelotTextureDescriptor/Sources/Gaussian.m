function kernel = Gaussian(radius)

sigma = radius / 3;
x = - radius : radius;
kernel = exp(-x.^2 / (2 * sigma * sigma));
kernel = kernel / sum(kernel);

end

