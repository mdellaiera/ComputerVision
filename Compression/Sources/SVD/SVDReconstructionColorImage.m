function image_rgb = SVDReconstructionColorImage(u_r, sigma_r, v_r)

image_lab = [];

for c = 1 : size(u_r, 3)
    image_lab = cat(3, image_lab, SVDReconstructionGrayScaleImage(u_r(:, :, c), sigma_r(:, c), v_r(:, :, c)));
end

image_rgb = lab2rgb(image_lab);

end

