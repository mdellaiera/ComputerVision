close all
clear
clc

addpath('Inputs')
addpath('Outputs')
addpath('Sources')


%% Initialisation

% Parameters
signal_noise_ratio = 10; % In dB
number_of_points = 2000;
time = 10; % In seconds
frequency = 1; % Hz
magnitude = 1.5;
number_of_points_fft = 2^8;

frequency_rate = number_of_points / time; % Samples per second

% Load data
axis_time = (0 : number_of_points - 1) / frequency_rate;
signal = sin(2 * pi * frequency * axis_time);


%% Processing

noise = Noise(signal, signal_noise_ratio);

signal_noise_ratio_calculated = 10 * log10(sum(signal.^2) / sum(noise.^2));
sprintf("Signal to Noise Ratio calculated : %.02f", signal_noise_ratio_calculated)



