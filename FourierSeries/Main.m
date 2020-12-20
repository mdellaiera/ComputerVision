close all
clear
clc

addpath('Inputs')
addpath('Outputs')
addpath('Sources')


%% Initialisation

% Parameters
number_of_coefficients = 20;
number_of_points = 2000;
time = 1; % In seconds

domain = (0 : number_of_points - 1) / number_of_points;
frequency_rate = number_of_points / time;

% Load data
signal = zeros(1, number_of_points);
signal(ceil(number_of_points / 4) : floor(3 * number_of_points / 4)) = 1;


%% Processing

approximation = FourierSeries(signal, domain, number_of_coefficients);

error = FourierError(signal, domain, number_of_coefficients);


%% Plot results

subplot(1, 2, 1)
plot(signal, 'b','linewidth', 2)
hold on
plot(approximation, 'r','linewidth', 2)
xlabel('x')
ylabel('f(x)')
legend('Initial signal', 'Approximated signal')
title('Fourier Series')

subplot(1, 2, 2)
plot(error, 'k')
xlabel('Coefficient')
ylabel('Error')
title('Error')















