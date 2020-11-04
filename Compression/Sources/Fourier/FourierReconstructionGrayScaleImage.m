function image_gray = FourierReconstructionGrayScaleImage(indices, values, dimensions)

number_of_pixels = prod(dimensions);

% Place stored values at corresponding indices
image_fft = zeros(number_of_pixels, 1);
image_fft(indices) = values;
image_fft = reshape(image_fft, dimensions);

% Inverse Fourier transform
image_gray = real(ifft2(image_fft));

end

