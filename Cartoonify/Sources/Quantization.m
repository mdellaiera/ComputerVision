function luminance_quantization = Quantization(luminance, max_luminance, sharpness_levels, quantization_levels)

% Compute gradient
[gradient_x, gradient_y] = gradient(luminance);
luminance_gradient = sqrt(gradient_x.^2 + gradient_y.^2);

% Sharpening parameter
sharpness = diff(sharpness_levels) * luminance_gradient + sharpness_levels(1);

% Soft luminance quantization
luminance = luminance * max_luminance;
quantization = max_luminance / (quantization_levels - 1);
luminance_quantization = quantization * round(luminance / quantization);
luminance_quantization = luminance_quantization + (quantization / 2) * tanh(sharpness .* (luminance - luminance_quantization));

end

