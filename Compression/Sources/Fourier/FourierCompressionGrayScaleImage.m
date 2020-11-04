function [indices, values] = FourierCompressionGrayScaleImage(image_gray, compression_factor)

number_of_pixels = numel(image_gray);

% Sort Fourier coefficients magnitude from lower to higher
image_fft = fft2(image_gray);
magnitude = abs(image_fft);
magnitude_sort = sort(magnitude(:));

% Get mask of highest coefficients
threshold_index = number_of_pixels - floor(number_of_pixels * compression_factor) + 1;
threshold_value = magnitude_sort(threshold_index);
mask = magnitude > threshold_value;

% Get indices and values
image_mask = image_fft .* mask;
indices = find(image_mask);
values = image_mask(indices);

end

