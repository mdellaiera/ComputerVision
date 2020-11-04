function x = Wiener(y, h, dx, dy, K)

mu = OptimalMu(y, h, dx, dy, K);

H  = fft2(h,  size(y, 1), size(y, 2));
Dx = fft2(dx, size(y, 1), size(y, 2));
Dy = fft2(dy, size(y, 1), size(y, 2));
Y  = fft2(y);

Gpls = conj(H) ./ (abs(H).^2 + mu * (abs(Dx).^2  + abs(Dy).^2));
X = Gpls .* Y;
x = ifft2(X);

end