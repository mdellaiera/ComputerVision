close all
clear
clc

addpath('Inputs')
addpath('Outputs')
addpath('Sources')


%% Initialisation

% Variables
OCTAVE_BANDWIDTH = true;
ORIENTATION_4 = true;
path = 'lion.png';

% Load data
image = rgb2gray(im2double(imread(path)));
[rows, cols] = size(image);


%% Non-cropped version

% Compute filters
filters = SteerableFilters(rows, cols, OCTAVE_BANDWIDTH, ORIENTATION_4);
number_of_filters = length(filters);

sum_filters = zeros(size(image));

for k = 1 : number_of_filters
    sum_filters = sum_filters + filters{k};
end

% Build pyramid
image_fft = fftshift(fft2(image));
levels = cell(number_of_filters - 2, 1);

% High frequency residual filter is symmetric so the residual is real
residual_high_frequency = BuildLevel(image_fft, filters{1});

% Levels are complex because filters are assymetric
for k = 2 : number_of_filters - 1
    levels{k - 1} = BuildLevel(image_fft, filters{k});
end

% Low frequency residual filter is symmetric so the residual is real
residual_low_frequency = BuildLevel(image_fft, filters{end});

% Collapse pyramid
result_fft = zeros(size(image));

for k = 1 : number_of_filters - 2
    sub_fft = CollapseLevel(levels{k}, filters{k + 1});
    result_fft = result_fft + sub_fft;
end

% Add residuals
result_fft = ...
    result_fft + ...
    0.5 * CollapseLevel(residual_high_frequency, filters{1});
result_fft = ...
    result_fft + ...
    0.5 * CollapseLevel(residual_low_frequency, filters{end});

result = real(ifft2(ifftshift(result_fft)));

% Plot results
figure
subplot(1, 3, 1)
imshow(image)
title('Original image')
subplot(1, 3, 2)
imshow(result)
title('Reconstructed image (non-cropped filters)')
subplot(1, 3, 3)
imagesc(image - result)
title('Difference')
truesize(gcf)


%% Cropped version

% Compute cropped filters
[cropped_filters, indices] = ...
    CroppedSteerableFilters(rows, cols, OCTAVE_BANDWIDTH, ORIENTATION_4);
number_of_filters = length(filters);

sum_filters = zeros(size(image));

for k = 1 : number_of_filters
    sum_filters(indices{k, 1}, indices{k, 2}) = sum_filters(indices{k, 1}, indices{k, 2}) + cropped_filters{k};
end

% Build pyramid
image_fft = fftshift(fft2(image));
levels = cell(number_of_filters - 2, 1);

% High frequency residual filter is symmetric so the residual is real
residual_high_frequency = BuildLevel(image_fft(indices{1, 1}, indices{1, 2}), cropped_filters{1});

% Levels are complex because filters are assymetric
for k = 2 : number_of_filters - 1
    levels{k - 1} = BuildLevel(image_fft(indices{k, 1}, indices{k, 2}), cropped_filters{k});
end

% Low frequency residual filter is symmetric so the residual is real
residual_low_frequency = BuildLevel(image_fft(indices{end, 1}, indices{end, 2}), cropped_filters{end});

% Collapse pyramid
result_fft = zeros(size(image));

for k = 1 : number_of_filters - 2
    sub_fft = CollapseLevel(levels{k}, cropped_filters{k + 1});
    result_fft(indices{k + 1, 1}, indices{k + 1, 2}) = result_fft(indices{k + 1, 1}, indices{k + 1, 2}) + sub_fft;
end

% Add residuals
result_fft(indices{1, 1}, indices{1, 2}) = ...
    result_fft(indices{1, 1}, indices{1, 2}) + ...
    0.5 * CollapseLevel(residual_high_frequency, cropped_filters{1});
result_fft(indices{end, 1}, indices{end, 2}) = ...
    result_fft(indices{end, 1}, indices{end, 2}) + ...
    0.5 * CollapseLevel(residual_low_frequency, cropped_filters{end});

result = real(ifft2(ifftshift(result_fft)));

% Plot results
figure
subplot(1, 3, 1)
imshow(image)
title('Original image')
subplot(1, 3, 2)
imshow(result)
title('Reconstructed image (cropped filters)')
subplot(1, 3, 3)
imagesc(image - result)
title('Difference')
truesize(gcf)

