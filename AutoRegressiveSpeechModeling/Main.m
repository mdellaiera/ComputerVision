close all
clear
clc

addpath('Inputs')
addpath('Outputs')
addpath('Sources')
addpath('Sources/AutoRegressiveModels')
addpath('Sources/TimeSegmentation')


%% Initialisation

% Parameters
path = 'voice.wav';
frame_length = 20; % In milliseconds
overlap_percentage = 0.50; % Between 0 and 1
position = 50;
order = 14;
number_of_points_fft = 2^16;

% Load data
[signal, frequency_rate] = audioread(path);


%% Processing

% Decompose signal into frames
frame_size = floor(frequency_rate * 10^(-3) * frame_length);
overlap = floor(frame_size * overlap_percentage);
hamming = Hamming(frame_size);

frames = Frames(signal, hamming, overlap);

% Process one frame
frame = frames{position};
[parameters, sigma] = EstimateAutoRegressiveProcessParameters(frame', order);

% Compute transfer function
[transfer_function_frame, ~] = freqz(frame, 1, number_of_points_fft, frequency_rate);
[transfer_function_ar, axis_frequency] = freqz(sigma, parameters, number_of_points_fft, frequency_rate);

% Compute estimated signal
frame_estimated = filter(-parameters(2 : end), 1, frame);


%% Plot results

scaling = sqrt(frame_size); % due to biaised estimator 

subplot(2, 1, 1)
plot(axis_frequency, 20 * log10(abs(transfer_function_frame)), 'color', 'b')
hold on
plot(axis_frequency, 20 * log10(abs(transfer_function_ar) * scaling), 'linewidth', 2, 'color', 'r')
grid on
xlabel('Frequencies (Hz)')
ylabel('Magnitudes (dB)')
legend('Frame', 'Estimated auto-regressive process')
title('Transfer function')

subplot(2, 1, 2)
plot(frame(2 : end))
hold on
plot(frame_estimated(1 : end - 1))
xlabel('Samples')
legend('Signal', 'Estimated signal')
title('Signals')
