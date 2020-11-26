function coefficients = TaylorCoefficients(signal, axis, evaluation_point, polynomial_order)

number_of_points = length(signal);
coefficients = zeros(1, polynomial_order + 1);
frequency_rate = number_of_points / (abs(min(axis)) + abs(max(axis)));

for k = 0 : polynomial_order
    coefficients(k + 1) = signal(evaluation_point) / factorial(k);
    
    signal = SpectralDerivative(signal, frequency_rate);
end

end

