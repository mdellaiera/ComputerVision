close all
clear
clc

addpath('Inputs')
addpath('Outputs')
addpath('Sources')


%% Analysis

L = 1 : 20 : 61;

figure
for i = 1 : length(L)
    b = ones(1, L(i)) / L(i); % Numerator coefficients of filter transfer function
    a = 1;                    % Denominator coefficients of filter transfer function
    
    [transfer_function, omega] = freqz(b, a);
    
    plot(omega, 20 * log10(abs(transfer_function)), 'linewidth', 2)
    hold on
end
hold off
title('Transfer Function of the Moving Average Filter')
xlabel('\omega')
ylabel('|H(j\omega)|_{dB}')
legend(split(int2str(L)))


%% Example (Data filtering)

number_of_points = 500;
sigma = number_of_points / 5;
axis_temporal = (0 : number_of_points - 1);
x = exp(-axis_temporal.^2 / (2 * sigma^2)); % Real signal
noise = 0.1 * (rand(size(x)) - 0.5);
y = x + noise; % Observation

figure
plot(x, 'linewidth', 2)
hold on
plot(y, 'linewidth', 2)

L = 1 : 5 : 21;

for i = 1 : length(L)
    b = ones(1, L(i)) / L(i); % Numerator coefficients of filter transfer function
    a = 1;                    % Denominator coefficients of filter transfer function
    
    z = filter(b, a, y);
    plot(z, 'linewidth', 2)
end                 
hold off
title('Moving Average Filtering')
xlabel('t')
legend([{'Real signal (x)'}; {'Observation (y)'}; split(int2str(L))])






















