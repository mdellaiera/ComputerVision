close all
clear
clc

addpath('Inputs')
addpath('Outputs')
addpath('Sources')


%% Initialisation

% Parameters
path = 'voice.wav';
frame_length = 30; % In milliseconds
overlap_percentage = 0.75; % Between 0 and 1
position = 100;

% Load data
[signal, frequency_rate] = audioread(path);


%% Processing

frame_size = floor(frequency_rate * 10^(-3) * frame_length);
overlap = floor(frame_size * overlap_percentage);
hamming = Hamming(frame_size);

frames = Frames(signal, hamming, overlap);

signal_recombined = Recombine(frames, hamming, overlap);
signal_recombined = signal_recombined(1 : length(signal));

error = abs(signal - signal_recombined);


%% Plot results

plot(error)
title('Error between true signal and signal recombined')























