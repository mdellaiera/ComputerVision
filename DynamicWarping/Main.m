close all
clear
clc

addpath('Inputs')
addpath('Outputs')
addpath('Sources')
addpath('Sources/Hale')
addpath('Sources/SakoeChiba')
addpath('Sources/Wheeler')


%% Test DTWs

REG_ORDER = 'Default' ;
p = 0.5;
lmax = 100;
b = 1;

data = load('data.mat');
f = data.f;
f = f - mean(f);
x = 1 : length(f);
A = 10;
s = A * sin(2 * pi * x / length(f));
g = interp1(x, f, x + s)';

uSakoeChiba = DynamicWarping(f, g, 'SakoeChiba', REG_ORDER);
uHale       = DynamicWarping(f, g, 'Hale'      , REG_ORDER, p, lmax, b);
uWheeler    = DynamicWarping(f, g, 'Wheeler'   , REG_ORDER, p, lmax);

plot(s, 'linewidth', 2)
hold on
plot(uSakoeChiba, 'linewidth', 2)
plot(uHale, 'linewidth', 2)
plot(uWheeler, 'linewidth', 2)
hold off
legend('Applied shifts', 'Sakoe Chiba', 'Hale', 'Wheeler')
ylim([-15, 15])

wSakoeChiba = interp1(x, g, x - uSakoeChiba)';
wHale       = interp1(x, g, x - uHale)';
wWheeler    = interp1(x, g, x - uWheeler)';

imgSakoeChiba = cat(2, g, f, wSakoeChiba);
imgHale       = cat(2, g, f, wHale);
imgWheeler    = cat(2, g, f, wWheeler);

figure
subplot(1, 3, 1)
imagesc(imgSakoeChiba)
xlabel('g, f, w')
title('Sakoe Chiba')

subplot(1, 3, 2)
imagesc(imgHale)
xlabel('g, f, w')
title('Hale')

subplot(1, 3, 3)
imagesc(imgWheeler)
xlabel('g, f, w')
title('Wheeler')







