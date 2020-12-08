function ar_process = GenerateAutoRegressiveProcess(number_of_points, sigma, poles)

% Generate centered white gaussian noise
noise = randn(1, number_of_points);
noise = sigma * (noise - mean(noise));

% Filter noise
ar_process = filter(1, poly([poles, conj(poles)]), noise); 

end

