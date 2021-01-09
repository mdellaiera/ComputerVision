close all
clear
clc

addpath('Inputs')
addpath('Outputs')
addpath('Sources')


%% Initialisation

% Parameters
path_in = 'crane.avi';
path_out = 'Outputs/crane.avi';
RGB = false;


%% Processing

[video, frequency_rate] = Load(path_in, RGB);

Write(video, frequency_rate, path_out, RGB);

