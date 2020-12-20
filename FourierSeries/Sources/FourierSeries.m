function approximation = FourierSeries(signal, domain, number_of_coefficients)

P = domain(end) + domain(1);
coefficients = FourierCoefficients(signal, domain, number_of_coefficients);
approximation = zeros(size(signal));

for k = 0 : number_of_coefficients
    a = coefficients(k + 1, 1);
    b = coefficients(k + 1, 2);
    omega = 2 * pi * k / P;
    
    approximation = approximation + a * cos(omega * domain) + b * sin(omega * domain);
end

end

