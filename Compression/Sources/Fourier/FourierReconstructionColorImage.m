function image_rgb = FourierReconstructionColorImage(indices, values, dimensions)

rows = dimensions(1);
cols = dimensions(2);

luminance = FourierReconstructionGrayScaleImage(indices, values(:, 1), [rows, cols]);
color_a = FourierReconstructionGrayScaleImage(indices, values(:, 2), [rows, cols]);
color_b = FourierReconstructionGrayScaleImage(indices, values(:, 3), [rows, cols]);

image_lab = cat(3, luminance, color_a, color_b);
image_rgb = lab2rgb(image_lab);

end

