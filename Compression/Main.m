close all
clear
clc

addpath('Inputs')
addpath('Outputs')
addpath('Sources/Fourier')
addpath('Sources/SVD')


%% Initialisation

% Parameters
path = 'lion.png';
compression_factor = 0.1;

% Load data
image_rgb = im2double(imread(path));
image_gray = rgb2gray(image_rgb);


%% Process

% Fourier Compression and Reconstruction on Gray Scale Image
[indices, values] = FourierCompressionGrayScaleImage(image_gray, compression_factor);
result_fourier_gray = FourierReconstructionGrayScaleImage(indices, values, size(image_gray));

% Fourier Compression and Reconstruction on Color Image
[indices, values] = FourierCompressionColorImage(image_rgb, compression_factor);
result_fourier_rgb = FourierReconstructionColorImage(indices, values, size(image_rgb));

% SVD Compression and Reconstruction on Gray Scale Image
[u_r, sigma_r, v_r] = SVDCompressionGrayScaleImage(image_gray, compression_factor);
result_svd_gray = SVDReconstructionGrayScaleImage(u_r, sigma_r, v_r);

% SVD Compression and Reconstruction on Color Image
[u_r, sigma_r, v_r] = SVDCompressionColorImage(image_rgb, compression_factor);
result_svd_rgb = SVDReconstructionColorImage(u_r, sigma_r, v_r);


%% Plot results

figure
subplot(2, 3, 1)
imshow(image_gray)
title('Original Gray Scale Image')
subplot(2, 3, 2)
imshow(result_fourier_gray)
title('Fourier Compressed Gray Scale Image')
subplot(2, 3, 3)
imshow(result_svd_gray)
title('SVD Compressed Gray Scale Image')
subplot(2, 3, 4)
imshow(image_rgb)
title('Original Color Image')
subplot(2, 3, 5)
imshow(result_fourier_rgb)
title('Fourier Compressed Color Image')
subplot(2, 3, 6)
imshow(result_svd_rgb)
title('SVD Compressed Color Image')
