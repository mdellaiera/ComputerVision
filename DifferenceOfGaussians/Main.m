close all
clear
clc

addpath('Inputs')
addpath('Outputs')
addpath('Sources')


%% Initialisation

time = 1; % In seconds
k = sqrt(2);
i = 2;
sigma = 2;
radius = 50;
number_of_points_fft = 2^16;


%% Processing 

sigma_1 = k^(i + 1) * sigma;
sigma_2 = k^(i) * sigma;

[gaussian_1, ~] = Gaussian(sigma_1, radius);
[gaussian_2, ~] = Gaussian(sigma_2, radius);
[difference_of_gaussians, axis_spatial] = DifferenceOfGaussians(k, i, sigma, radius);

frequency_rate = length(axis_spatial) / time; % Number of points per second          
[transfer_function_g1, ~] = freqz(gaussian_1, 1, number_of_points_fft, frequency_rate);
[transfer_function_g2, ~] = freqz(gaussian_2, 1, number_of_points_fft, frequency_rate);
[transfer_function_dog, axis_frequency] = freqz(difference_of_gaussians, 1, number_of_points_fft, frequency_rate);


%% Plot results

subplot(2, 1, 1)
plot(axis_spatial, difference_of_gaussians)
xlim([min(axis_spatial), max(axis_spatial)])
xlabel('Time')
title('Difference of Gaussians in temporal space')

subplot(2, 1, 2)
plot(axis_frequency, 20 * log10(abs(transfer_function_dog)), 'b')
hold on
plot(axis_frequency, 20 * log10(abs(transfer_function_g1)), 'r')
plot(axis_frequency, 20 * log10(abs(transfer_function_g2)), 'r')
xlabel('Frequency (Hz)')
title('Difference of Gaussians impulse response (dB)')






% frequency_rate = 30; % Ech / second
% frequency_to_filter = 1; % Hz
% radius = ceil(frequency_rate / (2 * frequency_to_filter));
% sigma = frequency_rate / (4 * frequency_to_filter);

% motion_freq_es = 10/3; % Hz
% 
% frame_rate = 30; % Image per second
% time_interval = 1 / 4 * 1 / motion_freq_es; % in sec. one quarter of sine wave;
% 
% % Find out frame interval.
% frame_interval = ceil(frame_rate * time_interval);
% 
% % Window size of our method (original one)  
% windowSize = 2 * frame_interval;                          
% signalLen  = (windowSize*2);                            
% sigma      = frame_interval/2;
% x          = linspace(-signalLen / 2, signalLen / 2, signalLen+1);
% kernel     = zeros(size(x));
% 
% 
% sigma1 = sigma/2; 
% sigma2 = sigma*2;
% 
% gaussFilter1 = exp(-x .^ 2 / (2 * sigma1 ^ 2));
% gaussFilter1 = gaussFilter1 / sum (gaussFilter1); 
% gaussFilter2 = exp(-x .^ 2 / (2 * sigma2 ^ 2));
% gaussFilter2 = gaussFilter2 / sum (gaussFilter2); 
% DOG_kernel   = gaussFilter1-gaussFilter2; 
% DOG_kernel  = DOG_kernel./sum(abs(DOG_kernel)); 








