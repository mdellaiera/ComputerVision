function derivative = FiniteDifference(signal, frequency_rate)

number_of_points = length(signal);
step = 1 / frequency_rate;
derivative = zeros(size(signal));

for i = 1 : number_of_points - 1
    derivative(i) = (signal(i + 1) - signal(i)) / step;
end

derivative(end) = derivative(end - 1);

end

