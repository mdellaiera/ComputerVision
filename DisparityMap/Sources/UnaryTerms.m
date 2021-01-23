function unary_terms = UnaryTerms(image_1, image_2, disparity_max, disparity_min)

[rows, cols, ~] = size(image_1);
number_of_disparities = abs(disparity_max - disparity_min) + 1;
unary_terms = zeros(rows, cols, number_of_disparities);

% Spatial average filter
kernel_size = 5;
kernel = ones(kernel_size);
kernel = kernel / sum(kernel(:));

% Pad reference image with 0s
image_1 = padarray(image_1, [0, disparity_min], 'pre');
image_1 = padarray(image_1, [0, disparity_max], 'post');

% Compute unary terms
for k = 1 : number_of_disparities
    % Cost of sum of absolute differences
    absolute_differences = abs(image_1(:, k : k + cols - 1) - image_2);
    
    unary_terms(:, :, k) = imfilter(absolute_differences, kernel);
end

end




