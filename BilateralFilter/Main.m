close all
clear
clc

addpath('Inputs')
addpath('Outputs')
addpath('Sources')


%% Initialisation

% Parameters
path = 'lion.png';
sigma_spatial = 3;
sigma_luminance = 0.2;

% Load data
image_rgb = im2double(imread(path));
image_gray = rgb2gray(image_rgb);


%% Process

result_gray = BilateralFilter(image_gray, sigma_spatial, sigma_luminance);
result_rgb = BilateralFilter(image_rgb, sigma_spatial, sigma_luminance);


%% Plot results

figure
subplot(2, 2, 1)
imshow(image_gray)
title('Original Gray Scale Image')
subplot(2, 2, 2)
imshow(result_gray)
title('Filtered Gray Scale Image')
subplot(2, 2, 3)
imshow(image_rgb)
title('Original Color Image')
subplot(2, 2, 4)
imshow(result_rgb)
title('Filtered Color Image')

