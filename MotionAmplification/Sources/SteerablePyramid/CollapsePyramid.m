function image = CollapsePyramid(pyramid, filters, indices)

number_of_filters = length(filters);
image_fft = zeros(size(pyramid{1}));

if nargin == 2 % Non-cropped filters

    % Add valid levels
    for k = 2 : number_of_filters - 1
        sub_fft = CollapseLevel(pyramid{k}, filters{k});
        image_fft = image_fft + sub_fft;
    end

    % Add residuals
    image_fft = ...
        image_fft + ...
        0.5 * CollapseLevel(pyramid{1}, filters{1});
    image_fft = ...
        image_fft + ...
        0.5 * CollapseLevel(pyramid{end}, filters{end});

else % Cropped filters

    % Add valid levels
    for k = 2 : number_of_filters - 1
        sub_fft = CollapseLevel(pyramid{k}, filters{k});
        image_fft(indices{k, 1}, indices{k, 2}) = image_fft(indices{k, 1}, indices{k, 2}) + sub_fft;
    end

    % Add residuals
    image_fft(indices{1, 1}, indices{1, 2}) = ...
        image_fft(indices{1, 1}, indices{1, 2}) + ...
        0.5 * CollapseLevel(pyramid{1}, filters{1});
    image_fft(indices{end, 1}, indices{end, 2}) = ...
        image_fft(indices{end, 1}, indices{end, 2}) + ...
        0.5 * CollapseLevel(pyramid{end}, filters{end});

end

image = real(ifft2(ifftshift(image_fft)));

