close all
clear
clc

addpath('Inputs')
addpath('Outputs')
addpath('Sources')


%% Initialisation

% Parameters
time = 30; % In seconds
number_of_points = 1000;
sigma = time / 8; % For exponential
frequency = 0.2; % Number of oscillations per seconds

% Load data
frequency_rate = number_of_points / time; % Number of points per second
axis_temporal = (0 : number_of_points - 1) / frequency_rate - time / 2;
omega = 2 * pi * frequency;

c = cos(omega * axis_temporal); % Cos function
s = sin(omega * axis_temporal); % Sin function
e = exp(-axis_temporal.^2 / (2 * sigma^2)); % Exp function

signal = c .* e;
derivative_true = -(omega * s + axis_temporal / sigma^2 .* c) .* e;


%% Processing

derivative_spectral = SpectralDerivative(signal, frequency_rate);
derivative_finite_difference = FiniteDifference(signal, frequency_rate);


%% Plot results

subplot(2, 1, 1)
plot(axis_temporal, signal)
xlabel('Time (s)')
title('Function f')

subplot(2, 1, 2)
plot(axis_temporal, derivative_true)
hold on
plot(axis_temporal, derivative_spectral)
plot(axis_temporal, derivative_finite_difference)
xlabel('Time (s)')
title('First signal derivative')
legend('True derivative', 'Approximated derivative with FFT', 'Approximated derivative with finite difference')

error_spectral = sum(abs(derivative_true - derivative_spectral));
error_finite_difference = sum(abs(derivative_true - derivative_finite_difference));



