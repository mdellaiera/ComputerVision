close all
clear
clc

addpath('Inputs')
addpath('Outputs')
addpath('Sources')


%% Variables

% sourcePath = 'lion.png';
% targetPath = 'redfish.png';

sourcePath = 'mountain.png';
targetPath = 'valley.png';

CONTRAST = true;


%% Load data

source = im2double(imread(sourcePath));
target = im2double(imread(targetPath));


%% Process

out = ColorTransfer(source, target, CONTRAST);


%% Show

imshow(out)