function coefficients = FourierCoefficients(signal, domain, number_of_coefficients)

P = domain(end) + domain(1);
dx = domain(2) - domain(1);
A = zeros(number_of_coefficients + 1, 1);
B = zeros(number_of_coefficients + 1, 1);

A(1) = (2 / P * sum(signal) * dx) / 2;

for k = 1 : number_of_coefficients
    A(k + 1) = 2 / P * sum(signal .* cos(2 * pi * domain * k / P)) * dx;
    B(k + 1) = 2 / P * sum(signal .* sin(2 * pi * domain * k / P)) * dx;
end

coefficients = [A, B];

end

