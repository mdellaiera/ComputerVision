close all
clear 
clc

addpath('Inputs')
addpath('Outputs')
addpath('Sources')
addpath('Sources/TimeSegmentation')


%% Initialisation

% Paramètres
path = 'voice.wav';
frame_length = 30; % In milliseconds
overlap_percentage = 0.75; % Between 0 and 1
threshold_power = 2;
threshold_zero_crossing = 70;

% Load data
[signal, frequency_rate] = audioread(path);


%% Analysis

frame_size = floor(frequency_rate * 10^(-3) * frame_length);
overlap = floor(frame_size * overlap_percentage);
hamming = Hamming(frame_size);

frames = Frames(signal, hamming, overlap);

number_of_frames = length(frames);
frames_power = zeros(1, number_of_frames);
zeros_crossings = zeros(1, number_of_frames);

for i = 1 : number_of_frames
    frame = frames{i};
    
    power = sum(frame .* frame);
    frames_power(i) = power;
    
    mask = (frame >= 0) + (frame < 0) * -1;
    zero_crossing = conv(mask, [1, 1], 'same');
    number_of_zero_crossing = sum(zero_crossing == 0); 
    zeros_crossings(i) = number_of_zero_crossing;
end

figure
subplot(3, 1, 1)
plot(1 : number_of_frames, threshold_power * ones(1, number_of_frames), 'r')
hold on
plot(frames_power, 'b')
xlabel('Frame')
ylabel('Power')
legend('Threshold')
title('Frames power')

subplot(3, 1, 2)
plot(1 : number_of_frames, threshold_zero_crossing * ones(1, number_of_frames), 'r')
hold on
plot(zeros_crossings, 'b')
xlabel('Frame')
ylabel('Number')
legend('Threshold')
title('Number of zero-crossings')

subplot(3, 1, 3)
plot((frames_power > threshold_power) & (zeros_crossings < threshold_zero_crossing), 'b')
ylim([-1, 2])
xlabel('Frame')
title('(Power > Threshold Power) & (Number of zero-crossings < Threshold Zero-Crossings)')


%% Processing

[indices_voiced, indices_unvoiced] = VoicedUnvoicedDecomposition(frames, threshold_power, threshold_zero_crossing);

frames_voiced = frames(indices_voiced);
frames_unvoiced = frames(indices_unvoiced);

voice = Recombine(frames_voiced, hamming, overlap);
silence = Recombine(frames_unvoiced, hamming, overlap);

figure
subplot(3, 1, 1)
plot(signal)
ylim([-0.5, 0.5])
title('Initial speech')
subplot(3, 1, 2)
plot(voice)
ylim([-0.5, 0.5])
title('Voiced speech')
subplot(3, 1, 3)
plot(silence)
ylim([-0.5, 0.5])
title('Unvoiced speech')
