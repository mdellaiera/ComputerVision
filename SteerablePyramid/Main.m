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

pyramid = BuildPyramid(image, filters);

result = CollapsePyramid(pyramid, filters);

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
[cropped_filters, indices] = CroppedSteerableFilters(rows, cols, OCTAVE_BANDWIDTH, ORIENTATION_4);

pyramid = BuildPyramid(image, cropped_filters, indices);

result = CollapsePyramid(pyramid, cropped_filters, indices);

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

