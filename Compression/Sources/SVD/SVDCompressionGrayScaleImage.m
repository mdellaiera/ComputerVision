function [u_r, sigma_r, v_r] = SVDCompressionGrayScaleImage(image_gray, compression_factor)

[u, s, v] = svd(image_gray, 'econ');

r = floor(size(s, 1) * compression_factor);

u_r = u(:, 1 : r);
s_r = s(1 : r, 1 : r);
v_r = v(:, 1 : r);

sigma_r = zeros(r, 1);

for i = 1 : r
    sigma_r(i) = s_r(i, i);
end

end

