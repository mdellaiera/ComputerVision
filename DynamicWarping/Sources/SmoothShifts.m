function us = SmoothShifts(u, sigma)

us = zeros(size(u));

for i = 1 : size(u, 2)
    us(:, i) = RecursiveExponentialFilter(u(:, i), sigma);
end

end

