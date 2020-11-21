function derivative = SpectralDerivative(signal, frequency_rate)

number_of_points = length(signal);
axis_frequency = (-0.5 : 1 / number_of_points : 0.5 - 1 / number_of_points) * frequency_rate;

signal_fft = fftshift(fft(signal));

kappa = 1i * 2 * pi * axis_frequency;
derivative_fft = kappa .* signal_fft;

derivative = real(ifft(ifftshift(derivative_fft)));

end

