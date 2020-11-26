close all
clear
clc

addpath('Inputs')
addpath('Outputs')
addpath('Sources')


%% Initialisation

% Parameters
time = 2; % In seconds
number_of_points = 200;
number_of_points_fft = 2^16;
frequency = 10;


%% Processing

frequency_rate = number_of_points / time;

zeros = 0.99 .* exp(1i * 2 * pi * frequency / frequency_rate); % Attenuation
poles = 0.98 .* exp(1i * 2 * pi * frequency / frequency_rate); % Amplification

b = poly(zeros);
a = poly(poles);


%% Plot results

freqz(b, a, number_of_points_fft, frequency_rate)










