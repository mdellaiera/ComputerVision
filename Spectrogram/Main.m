close all
clear
clc

addpath('Inputs')
addpath('Outputs')
addpath('Sources')


%% Initialisation

% Parameters
path = 'voice.wav';
frame_size = 51;
overlap = 25;
number_of_points_fft = 2^(10);

% Load data
[signal, frequency_rate] = audioread(path);
number_of_points = length(signal);


%% Processing

hamming = Hamming(frame_size);

time_frequency = Spectrogram(signal, hamming, overlap, number_of_points_fft, frequency_rate);

time_frequency_matlab = spectrogram(signal, hamming, overlap, number_of_points_fft, frequency_rate, 'yaxis');
time_frequency_matlab = 20 * log10(abs(time_frequency_matlab));
time_frequency_matlab = time_frequency_matlab(end : -1 : 1, :);


%% Plot results

figure
subplot(1, 2, 1)
imagesc(time_frequency)
colorbar
title('My Spectrogram')
subplot(1, 2, 2)
imagesc(time_frequency_matlab)
colorbar
title('Matlab Spectrogram')








