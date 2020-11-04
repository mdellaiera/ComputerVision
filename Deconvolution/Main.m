close all
clear
clc

addpath('Inputs')
addpath('Outputs')
addpath('Sources')

load('support.mat')


%% Initialisation

% Load data
x = im2double(imread('img.png'));

% Generate first observation
H1 = ones(9, 9);
H1(5, 5) = 30;
H1 = H1 / sum(H1(:));           % Convolution matrix
N1 = 0.05 * rand(size(x));      % Noise
y1 = conv2(x, H1, 'same') + N1; % First obeservation

% Generate second observation
H2 = ones(9, 9);
H2 = H2 / sum(H2(:));           % Convolution matrix
N2 = 0.05 * rand(size(x));      % Noise
y2 = conv2(x, H2, 'same') + N2; % Second obeservation

% Patameters
K = 100;

grad_x = [0  0  0;
         0  1 -1;
         0  0  0];
 
grad_y = grad_x';


%% Wiener

x_wiener_1 = Wiener(y1, H1, grad_x, grad_y, K);
x_wiener_2 = Wiener(y2, H2, grad_x, grad_y, K);


%% Huber

alpha = 0.45;
T = 0.5;

x_huber_1 = Huber(y1, H1, grad_x, grad_y, alpha, T, K);
x_huber_2 = Huber(y2, H2, grad_x, grad_y, alpha, T, K);


%% ADMM

rho = 1;
th = 0.001;

x_admm_1 = ADMM(y1, H1, grad_x, grad_y, rho, th, mask, K);
x_admm_2 = ADMM(y2, H2, grad_x, grad_y, rho, th, mask, K);


%% Plot results

figure
subplot(2, 4, 1)
imshow(y1)
title('Observation 1')
subplot(2, 4, 2)
imshow(x_wiener_1)
title('Wiener 1')
subplot(2, 4, 3)
imshow(x_huber_1)
title('Huber 1')
subplot(2, 4, 4)
imshow(x_admm_1)
title('ADMM 1')
subplot(2, 4, 5)
imshow(y2)
title('Observation 2')
subplot(2, 4, 6)
imshow(x_wiener_2)
title('Wiener 2')
subplot(2, 4, 7)
imshow(x_huber_2)
title('Huber 2')
subplot(2, 4, 8)
imshow(x_admm_2)
title('ADMM 2')
