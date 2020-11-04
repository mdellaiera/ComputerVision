function x = Huber(y, h, dx, dy, alpha, T, K)

mu = OptimalMu(y, h, dx, dy, K);

% Pre-computation
Y   = fft2(y);
H   = fft2(h, size(y, 1), size(y, 2));
Dx  = fft2(dx, size(y, 1), size(y, 2));
Dy  = fft2(dy, size(y, 1), size(y, 2));
D2  = abs(Dx).^2 + abs(Dy).^2;
H2  = abs(H).^2;
c   = mu/(2 * alpha);
den = 1 ./ (H2 + c*D2);
num = conj(H) .* Y;

% Initialisation
x = y;
X = fft2(x);

% Iteration
for k = 1:K
    
    % Update delta
    Delta_x = X .* Dx; 
    Delta_y = X .* Dy; 
    delta_x = ifft2(Delta_x); 
    delta_y = ifft2(Delta_y); 
    
    % Update a
    ax = (1 - alpha*min(1, T ./ abs(delta_x))) .* delta_x;
    ay = (1 - alpha*min(1, T ./ abs(delta_y))) .* delta_y;
    Ax = fft2(fftshift(ax));
    Ay = fft2(fftshift(ay));
    
    % Update TF_x
    X = den .* (num + c * (conj(Dx) .* Ax + conj(Dy) .* Ay));
    
end

x = ifft2(X);

end

