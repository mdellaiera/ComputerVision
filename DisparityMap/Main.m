close all
clear 
clc

addpath('Inputs')
addpath('Outputs')
addpath('Sources')


%% Initialisation

disparity_max = 60;
disparity_min = 0;
alpha = 0.1;


%% Load data

image_1 = rgb2gray(im2double(imread('masques1.png')));
image_2 = rgb2gray(im2double(imread('masques2.png')));


%% Processing

% Compute cost volumes
unary_terms_1 = UnaryTerms(image_1, image_2, disparity_max, disparity_min);
unary_terms_2 = UnaryTerms(image_2, image_1, disparity_min, disparity_max);

% Semi-Global Matching
accumulated_costs_1 = SemiGlobalMatching(unary_terms_1, alpha);
accumulated_costs_2 = SemiGlobalMatching(unary_terms_2, alpha);
% accumulated_costs_1 = unary_terms_1;
% accumulated_costs_2 = unary_terms_2;

% Get path of minimum costs
[~, position_1] = min(accumulated_costs_1, [], 3);
[~, position_2] = min(accumulated_costs_2, [], 3);

disparity_1 = position_1 - 1 + disparity_min;
disparity_2 = -(position_2 - 1 + disparity_min);


%% Plot results

subplot(2, 2, 1)
imagesc(image_1)
title('Image 1')
axis off

subplot(2, 2, 2)
imagesc(image_2)
title('Image 2')
axis off

subplot(2, 2, 3)
imagesc(disparity_2)
title('Disparity on image 1')
axis off

subplot(2, 2, 4)
imagesc(disparity_1)
title('Disparity on image 2')
axis off




