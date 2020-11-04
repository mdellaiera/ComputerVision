function P = PixelSimilarity(pixel, descriptor, sigma)

distance = (descriptor - descriptor(pixel(1), pixel(2), :)).^2;
N = sum(distance, 3);
P = exp(-N / (2 * sigma^2));

end

