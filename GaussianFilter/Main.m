close all
clear
clc

addpath('Inputs')
addpath('Outputs')
addpath('Sources')


%% Initialisation

time = 1; % In second
sigma = 2;
radius = 3 * sigma;
number_of_points_fft = 2^16;


%% Processing 

[gaussian_filter, axis_spatial] = Gaussian(sigma, radius);
A = 1 / sum(gaussian_filter); 
B = sqrt(2 * pi) * sigma * A; 
gaussian_filter = gaussian_filter * A;

frequency_rate = length(axis_spatial) / time; % Number of points per second
b = gaussian_filter; % Numerator coefficients of filter transfer function
a = 1;               % Denominator coefficients of filter transfer function
[transfer_function, axis_frequency] = freqz(b, a, number_of_points_fft, frequency_rate);

C = sqrt(-log(10^(-3 / 20) / B) / (2 * pi^2 * sigma^2));
frequency_cut_off = C * frequency_rate;


%% Plot results

subplot(2, 1, 1)
plot(axis_spatial, gaussian_filter)
xlim([min(axis_spatial), max(axis_spatial)])
xlabel('Time')
title('Gaussian filter in temporal space')

subplot(2, 1, 2)
plot(axis_frequency, 20 * log10(abs(transfer_function)))
xlabel('Frequency (Hz)')
title('Gaussian filter impulse response (dB)')



