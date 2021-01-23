function level = BuildLevel(image_fft, filter)

level = ifft2(ifftshift(filter .* image_fft));

end

