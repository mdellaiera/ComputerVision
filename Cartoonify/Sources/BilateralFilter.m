function result = BilateralFilter(image, sigma_spatial, sigma_luminance)

% Set output
[rows, cols, colors] = size(image);
result = zeros(size(image));

% If input image is RGB, convert it in Lab color space
if colors == 3
    image = rgb2lab(image);
    sigma_luminance = 100 * sigma_luminance;
end

% Compute gaussian spatial filter
r = 3 * ceil(sigma_spatial);
[X, Y] = meshgrid(-r : r, -r : r);
filter_spatial = exp(-(X.^2 + Y.^2) / (2 * sigma_spatial^2));

% Pad input to avoid border issues
image_pad = padarray(image, [r, r]);

for i = r + 1 : rows + r
    for j = r + 1 : cols + r
        % Get local region
        center = image_pad(i, j, :);
        local_region = image_pad(i - r : i + r, j - r : j + r, :);

        % Compute guassian luminance filter
        filter_luminance = exp(-sum((local_region - center).^2, 3) / (2 * sigma_luminance^2));

        % Combine filter and normalise it
        filter = filter_luminance .* filter_spatial;
        filter = filter / sum(filter(:));
        filter = repmat(filter, 1, 1, colors);

        % Filter input
        result(i - r, j - r, :) = sum(sum(filter .* local_region));
    end
end

% Convert back to RGB color space
if colors == 3
    result = lab2rgb(result);
end

end

