function image_gray = SVDReconstructionGrayScaleImage(u_r, sigma_r, v_r)

r = length(sigma_r);
s_r = zeros(r, r);

for i = 1 : r
    s_r(i, i) = sigma_r(i);
end

image_gray = u_r * s_r * v_r';

end

