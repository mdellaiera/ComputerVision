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
sigma_luminance = 0.1;
max_gradient = 1;  
min_edges = 0; 
sharpness_levels = [3 14];
quantization_levels = 8;

% Load data
image_rgb = im2double(imread(path));
image_gray = rgb2gray(image_rgb);


%% Processing

cartoon_rgb = Cartoon(image_rgb, sigma_spatial, sigma_luminance, max_gradient, min_edges, sharpness_levels, quantization_levels);
cartoon_gray = Cartoon(image_gray, sigma_spatial, sigma_luminance, max_gradient, min_edges, sharpness_levels, quantization_levels);


%% Plot results 

figure
subplot(2, 2, 1)
imshow(image_gray)
title('Original gray-scale image')
subplot(2, 2, 2)
imshow(cartoon_gray)
title('Cartoon gray-scale image')
subplot(2, 2, 3)
imshow(image_rgb)
title('Original RGB image')
subplot(2, 2, 4)
imshow(cartoon_rgb)
title('Cartoon RGB image')
