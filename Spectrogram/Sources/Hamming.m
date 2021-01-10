function hamming = Hamming(number_of_points)

alpha = 25/46;
x = -floor(number_of_points / 2) : floor((number_of_points - 1) / 2);
hamming = alpha + (1 - alpha) * cos(2 * pi * x / number_of_points)';

end

