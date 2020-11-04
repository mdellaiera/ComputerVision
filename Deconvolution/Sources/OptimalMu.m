function mu = OptimalMu(y, h, dx, dy, K)

alpha_e = size(y, 1) * size(y, 2) / 2;
alpha_x = size(y, 1) * size(y, 2) / 2;

x  = y;
X  = fft2(x);
Y  = fft2(y);
H  = fft2(h,  size(y, 1), size(y, 2));
Dx = fft2(dx, size(y, 1), size(y, 2));
Dy = fft2(dy, size(y, 1), size(y, 2));

mu_k = zeros(1, K);

for k = 1 : K
    beta_e = sum(sum(abs(Y - H .* X).^2))/2;
    gamma_e = RNDGamma(alpha_e, beta_e);
    
    beta_x = (sum(sum(abs(X .* Dx).^2)))/2 + (sum(sum(abs(X .* Dy).^2))) /2;
    gamma_x = RNDGamma(alpha_x, beta_x);
  
    std = 1./(gamma_e * abs(H).^2 + gamma_x * (abs(Dx).^2 + abs(Dy).^2));
    m = gamma_e * std .* conj(H) .* Y;
    mu_k(k) = (gamma_x / gamma_e);
    X = RNDGauss(m, std);
end

mu = mean(mu_k(K / 2 : K));

end


function SamplePrecision = RNDGamma(Alpha, Beta)	
% Random Noise Distribution Gamma

SamplePrecision = Alpha / Beta + sqrt(Alpha / Beta.^2) * randn;

end


function SampleImage = RNDGauss(mean, std)	
% Random Noise Distribution Gauss

n = length(mean);

BoutGauss = randn(n, n) + 1i * randn(n, n);
BoutGauss = fft2(real(ifft2(BoutGauss)));

SampleImage = mean + BoutGauss .* sqrt(std);
    
end

