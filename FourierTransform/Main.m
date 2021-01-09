close all
clear
clc


%% Initialisation

% Parameters
time = 1; % In seconds
number_of_points = 2000;
number_of_points_fft = 2^16;
frequency = 5;

% Load data
frequency_rate = number_of_points / time;
axis_temporal = 0 : number_of_points - 1;
signal = sin(2 * pi * frequency * axis_temporal / number_of_points);


%% Find frequency

[transfer_function, axis_frequency] = freqz(signal, 1, number_of_points_fft, frequency_rate);
power_spectral_density = 20 * log10(abs(transfer_function));

[~, k] = max(power_spectral_density);
frequency_hat = k * frequency_rate / (2 * number_of_points_fft);


%% Plot result

figure
plot(axis_frequency, power_spectral_density)


















