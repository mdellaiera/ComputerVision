function cartoon = Cartoon(image, sigma_spatial, sigma_luminance, max_gradient, min_edges, sharpness_levels, quantization_levels)

[~, ~, colors] = size(image);

% Apply bilateral filter
image = BilateralFilter(image, sigma_spatial, sigma_luminance);

% Get luminance
if colors == 3
    % RGB color space in not orthogonal, Lab is
    image_lab = rgb2lab(image); 
    
    luminance = image_lab(:, :, 1);
    color_a = image_lab(:, :, 2);
    color_b = image_lab(:, :, 3);
    
    % In Lab color space, 0 <= luminance <= 100
    max_luminance = 100; 
else
    luminance = image;
    
    max_luminance = 1;
end

% Normalise luminance
luminance = luminance / max_luminance; 

% Compute contours
contours = Contours(luminance, max_gradient, min_edges);

% Compute luminance quantization
luminance_quantization = Quantization(luminance, max_luminance, sharpness_levels, quantization_levels);

% Convert back to Lab color space
if colors == 3
    image_quantization = lab2rgb(cat(3, luminance_quantization, color_a, color_b));
    contours = repmat(contours, [1, 1, 3]);
else
    image_quantization = luminance_quantization;
end

% Add gradient edges 
cartoon = contours .* image_quantization;

end

