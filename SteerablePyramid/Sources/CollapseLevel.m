function image_fft = CollapseLevel(level, filter)

image_fft = 2 * filter .* fftshift(fft2(level));

end

