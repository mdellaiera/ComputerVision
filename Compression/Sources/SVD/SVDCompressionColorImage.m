function [u_r, sigma_r, v_r] = SVDCompressionColorImage(image_rgb, compression_factor)

image_lab = rgb2lab(image_rgb);
u_r = [];
sigma_r = [];
v_r = [];

for c = 1 : size(image_lab, 3)
    [u_r_c, sigma_r_c, v_r_c] = SVDCompressionGrayScaleImage(image_lab(:, :, c), compression_factor);
    u_r = cat(3, u_r, u_r_c);
    sigma_r = cat(2, sigma_r, sigma_r_c);
    v_r = cat(3, v_r, v_r_c);
end

end

