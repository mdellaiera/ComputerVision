function pyramid = BuildPyramid(image, filters, indices)

number_of_filters = length(filters);
image_fft = fftshift(fft2(image));
pyramid = cell(number_of_filters, 1);

if nargin == 2 % Non-cropped filters
    
    % High frequency residual filter is symmetric so the residual is real
    pyramid{1} = BuildLevel(image_fft, filters{1});

    % Levels are complex because filters are assymetric
    for k = 2 : number_of_filters - 1
        pyramid{k} = BuildLevel(image_fft, filters{k});
    end

    % Low frequency residual filter is symmetric so the residual is real
    pyramid{end} = BuildLevel(image_fft, filters{end});
    
else % Cropped filters

    % High frequency residual filter is symmetric so the residual is real
    pyramid{1} = BuildLevel(image_fft(indices{1, 1}, indices{1, 2}), filters{1});

    % Levels are complex because filters are assymetric
    for k = 2 : number_of_filters - 1
        pyramid{k} = BuildLevel(image_fft(indices{k, 1}, indices{k, 2}), filters{k});
    end

    % Low frequency residual filter is symmetric so the residual is real
    pyramid{end} = BuildLevel(image_fft(indices{end, 1}, indices{end, 2}), filters{end});

end

