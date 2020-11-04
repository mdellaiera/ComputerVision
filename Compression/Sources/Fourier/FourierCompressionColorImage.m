function [indices, values] = FourierCompressionColorImage(image_rgb, compression_factor)

image_lab = rgb2lab(image_rgb);

[indices, values_L] = FourierCompressionGrayScaleImage(image_lab(:, :, 1), compression_factor);

color_a = fft2(image_lab(:, :, 2));
color_a = color_a(:);
color_b = fft2(image_lab(:, :, 3));
color_b = color_b(:);

values_a = color_a(indices);
values_b = color_b(indices);

values = [values_L, values_a, values_b];

end

