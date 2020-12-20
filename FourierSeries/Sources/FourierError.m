function error = FourierError(signal, domain, number_of_coefficients)

error = zeros(1, number_of_coefficients);

for k = 1 : number_of_coefficients
    approximation = FourierSeries(signal, domain, k);
    
    error(k) = norm(signal - approximation) / norm(signal);
end

end

