function x = ADMM(y, h, dx, dy, rho, th, mask, K)

mu = OptimalMu(y, h, dx, dy, K);

% Precomputation
Y  = fft2(y);
H  = fft2(h, size(y, 1), size(y, 2));
Dx = fft2(dx, size(y, 1), size(y, 2));
Dy = fft2(dy, size(y, 1), size(y, 2));
D2 = abs(Dx).^2 + abs(Dy).^2;
H2 = abs(H).^2;

inv = 1 ./ (2 * H2 + 2 * mu * D2 + rho);

% Initialisation
v = zeros(size(y));
u = zeros(size(y));
X = zeros(size(y));
cpt = 0;
error = th + 1;

% ADMM
while (error > th)
    U = fft2(u);
    V = fft2(v);
    Xp = X;
    
    % Updata x
    X = inv .* (2 * conj(H) .* Y + rho * V - U);
    x = real(ifft2(X));
    
    % Updata v
    v = x + u/rho;
    v(v<0) = 0 ;
    v(~mask) = 0;
    
    % Updata u
    u = u + rho*(x - v);
    
    cpt = cpt + 1;
    error = sum(abs(X(:) - Xp(:)).*2);
end

end

