close all
clear
clc

addpath('Inputs')
addpath('Outputs')
addpath('Sources')
addpath('Sources/IO')
addpath('Sources/MotionAmplification')
addpath('Sources/SteerablePyramid')


%% Initialisation

% Parameters
path = 'crane.avi';
RGB = false;
OCTAVE_BANDWIDTH = true;
ORIENTATION_4 = true;
frequency_low = 0.20; % in Hz
frequency_high = 0.25; % in Hz
amplification_factor = 80;

% Load data
[video_in, frequency_rate] = Load(path, RGB);


%% Processing

number_of_frames = size(video_in, length(size(video_in)));

% Compute temporal filter
N = number_of_frames - 1;
filter_temporal = fir1(N, [2 * frequency_low / frequency_rate, 2 * frequency_high / frequency_rate]);
% PlotFilterImpulseResponse(filter_temporal, frequency_low, frequency_high, frequency_rate);

% Motion amplification
% video_magnified = MotionAmplificationOnline(video_in, OCTAVE_BANDWIDTH, ORIENTATION_4, amplification_factor, filter_temporal);
video_magnified = MotionAmplificationOffline(video_in, OCTAVE_BANDWIDTH, ORIENTATION_4, amplification_factor, filter_temporal);


%% Write output

Write(video_magnified, frequency_rate, 'Outputs/result.avi', RGB);
























