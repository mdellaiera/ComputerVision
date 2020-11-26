function polynomial = TaylorPolynomial(coefficients, axis, shift)

polynomial = zeros(size(axis));
polynomial_order = length(coefficients) - 1;
axis = axis - axis(shift);

for k = 0 : polynomial_order
    polynomial = polynomial + coefficients(k + 1) * axis.^k;
end

end

