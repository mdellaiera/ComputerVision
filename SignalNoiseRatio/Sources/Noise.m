function noise = Noise(signal, signal_noise_ratio)
% Generates a white gaussian noise (mean = 0, variance = sigma^2)

% Generate noise
noise = randn(size(signal));
noise = noise - mean(noise);

% Find current signal to noise ratio
signal_power = sum(signal.^2);
noise_power = sum(noise.^2);
ratio = signal_power / noise_power;

% Find variance to get desired signal to noise ratio
variance = ratio * 10^(-signal_noise_ratio / 10);

% Scale noise
noise = sqrt(variance) * noise;

end

