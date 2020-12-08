function [parameters, sigma] = EstimateAutoRegressiveProcessParameters(ar_process, order)

auto_correlation = xcorr(ar_process, order, 'biased');
auto_correlation = auto_correlation(order + 1 : end);

% Create linear system Rx = r
r = auto_correlation(2 : end)';

R = toeplitz(auto_correlation(1 : end - 1));

% Solve Yule-Walker equation
x = -(R \ r)';

parameters = [1, x];
sigma = sqrt(parameters * auto_correlation');

end

