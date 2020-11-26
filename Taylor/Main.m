close all
clear
clc

addpath('Inputs')
addpath('Outputs')
addpath('Sources')

% /!\ Taylor series have to converge


%% Initialisation

% Parameters
number_of_points = 100;
polynomial_order = 4;
evaluation_point = 50;

% Load data
axis = (0 : number_of_points - 1) / number_of_points;
axis = axis - axis(floor(number_of_points / 2));
axis = axis * 4 * pi;

signal = cos(axis);


%% Processing

coefficients = TaylorCoefficients(signal, axis, evaluation_point, polynomial_order);
polynomial = TaylorPolynomial(coefficients, axis, evaluation_point);


%% Plot results

plot(axis, signal, 'linewidth', 2)
hold on
plot(axis, polynomial, 'linewidth', 2)
xlim([min(axis), max(axis)])
ylim([-2, 2])
title('Taylor approximation')
legend('Cos', 'Taylor approximation')




