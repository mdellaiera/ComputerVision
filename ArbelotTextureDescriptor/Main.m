close all
clear
clc

addpath('Inputs')
addpath('Outputs')
addpath('Sources')


%% Initialisation

% Variables
neighborhood_radius = 6;
path = 'forest.png';

% Load data
image = rgb2gray(im2double(imread(path)));


%% Process

descriptor_vector = TextureDescriptor(image, neighborhood_radius);

sigma = 1;

pixel_cloud = [250, 250];
similarity_cloud = PixelSimilarity(pixel_cloud, descriptor_vector, sigma);

pixel_trees = [350, 250];
similarity_trees = PixelSimilarity(pixel_trees, descriptor_vector, sigma);

pixel_grass = [450, 250];
similarity_grass = PixelSimilarity(pixel_grass, descriptor_vector, sigma);


%% Plot results

figure
subplot(2, 2, 1)
imshow(image)
title('Original image')
subplot(2, 2, 2)
imagesc(similarity_cloud)
hold on
plot(pixel_cloud(2), pixel_cloud(1), 'xr')
title('Similarity Map Cloud')
subplot(2, 2, 3)
imagesc(similarity_trees)
hold on
plot(pixel_trees(2), pixel_trees(1), 'xr')
title('Similarity Map Trees')
subplot(2, 2, 4)
imagesc(similarity_grass)
hold on
plot(pixel_grass(2), pixel_grass(1), 'xr')
title('Similarity Map Grass')
truesize(gcf)







