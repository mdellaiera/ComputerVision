close all
clear
clc

addpath('Inputs')
addpath('Outputs')
addpath('Sources')
addpath('Sources/AutoRegressiveModels')
addpath('Sources/SignalNoiseRatio')
addpath('Sources/TimeSegmentation')
addpath('Sources/UnvoicedFrameDetection')


%% Initialisation

% Parameters
path = 'voice.wav';
frame_length = 20; % In milliseconds
overlap_percentage = 0.50; % Between 0 and 1
position = 50;
order = 14;
number_of_points_fft = 2^16;
signal_noise_ratio = 5; % In dB
threshold_power = 2;
threshold_zero_crossing = 70;

% Load data
[signal, frequency_rate] = audioread(path);


%% Get frame

% Decompose signal into frames
frame_size = floor(frequency_rate * 10^(-3) * frame_length);
overlap = floor(frame_size * overlap_percentage);
hamming = Hamming(frame_size);

frames = Frames(signal, hamming, overlap);

% Find voiced and unvoiced frames
[indices_voiced, indices_unvoiced] = VoicedUnvoicedDecomposition(frames, threshold_power, threshold_zero_crossing);

% Get frame
frame = frames{indices_voiced(position)};

% Add gaussian noise 
noise = Noise(frame, signal_noise_ratio);
frame_noisy = frame + noise;

% Find auto-regressive parameters
[parameters, sigma] = EstimateAutoRegressiveProcessParameters(frame_noisy', order);


%% Kalman filtering

% parameters
sigma_process_noise = sigma;
sigma_measurement = std(noise);

Q = sigma_process_noise^2; % Process noise uncertainty
R = sigma_measurement^2; % Measurement uncertainty

F = [-parameters(2 : end); [eye(order - 1), zeros(order - 1, 1)]];
G = [1, zeros(1, order - 1)]';
H = [1, zeros(1, order - 1)]; 
I = eye(order);

% Initialisation
Xn = frame(1 : order); % State matrix
Pn = sigma_measurement^2 * eye(order); % Estimation uncertainty
En = zeros(size(frame)); % Estimate

% Kalman
for n = 1 : frame_size
    % Update
    Xnp1 = F * Xn;
    Pnp1 = F * Pn * F' + G * Q * G';
    
    % Measure
    Zn = frame(n);
    Kn = Pnp1 * H' / (H * Pnp1 * H' + R);
    Xn = Xnp1 + Kn * (Zn - H * Xnp1);
    Pn = (I - Kn * H) * Pnp1;
    
    % Output
    En(n) = Xn(1);
end


%% Plot results

plot(En, 'b')
hold on
plot(frame, 'g')
plot(frame_noisy, 'r')
xlabel('Time')
ylim([-0.5, 0.5])
legend('Estimate', 'Frame', 'Frame + Noise')
title('Kalman filter')




