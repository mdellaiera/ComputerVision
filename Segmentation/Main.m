close all
clear
clc

addpath('Inputs')
addpath('Outputs')
addpath('Sources')


%% Initialisation

% Parameters
path = 'coins.png'; % Each class must follow a Guassian distribution
mu = [70, 180]; % Mean values of each class
sigma = [15, 15]; % Standard deviation of each class
beta = 3;
temperature = 30;
K = 0.8; % Decay temperature constant
iteration_max = 10;

% Load data
image = im2double(imread(path)) * 255;

number_of_classes = length(sigma);
label_initialisation = ones(size(image));


%% Process

result_icm = IteratedConditionalModes(image, label_initialisation, number_of_classes, mu, sigma, beta, iteration_max);
result_metropolis = Metropolis(image, label_initialisation, number_of_classes, mu, sigma, beta, temperature, K, iteration_max);


%% Plot results

figure
subplot(1, 3, 1)
imagesc(image), colormap('gray')
title('Original Image')
subplot(1, 3, 2)
imagesc(result_icm), colormap('gray')
title('ICM Segmentation')
subplot(1, 3, 3)
imagesc(result_metropolis), colormap('gray')
title('Metropolis Segmentation')

    
    