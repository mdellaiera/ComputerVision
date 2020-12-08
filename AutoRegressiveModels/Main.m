close all
clear
clc

addpath('Inputs')
addpath('Outputs')
addpath('Sources')


%% Initialisation

% Parameters
number_of_points = 350;
number_of_points_fft = 2^16;
time = 1; % In seconds

frequency_rate = number_of_points / time;

% Generate auto-regressive process
sigma = 0.2; % Standard deviation
magnitudes = [0.90, 0.92, 0.85];
frequencies = [30, 70, 150];
omegas = 2 * pi * frequencies / frequency_rate;
poles = magnitudes .* exp(1i * omegas);

signal = GenerateAutoRegressiveProcess(number_of_points, sigma, poles);


%% Processing

% Estimate parameters and standard deviation
parameters_true = poly([poles, conj(poles)]);
order = length(parameters_true) - 1;
[parameters_estimated, sigma_estimated] = EstimateAutoRegressiveProcessParameters(signal, order);

% Compute transfer functions
[transfer_function_process, axis_frequency] = freqz(signal, 1, number_of_points_fft, frequency_rate);
[transfer_function_estimated, ~] = freqz(sigma_estimated, parameters_estimated, number_of_points_fft, frequency_rate);

% Compute estimated signal
signal_estimated = filter(-parameters_estimated(2 : end), 1, signal);


%% Plot results

scaling = sqrt(number_of_points); % due to biaised estimator 

subplot(2, 1, 1)
plot(axis_frequency, 20 * log10(abs(transfer_function_process)), 'color', 'b')
hold on
plot(axis_frequency, 20 * log10(abs(transfer_function_estimated) * scaling), 'linewidth', 2, 'color', 'r')
grid on
xlabel('Frequencies (Hz)')
ylabel('Magnitudes (dB)')
legend('Signal', 'Estimated auto-regressive process')
title('Transfer functions')

subplot(2, 1, 2)
plot(signal(2 : end))
hold on
plot(signal_estimated(1 : end - 1))
xlabel('Samples')
legend('Signal', 'Estimated signal')
title('Signals')
