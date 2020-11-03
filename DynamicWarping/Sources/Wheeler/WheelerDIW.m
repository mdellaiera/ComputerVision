function u = WheelerDIW(f, g, p, lmax)

    [h, w] = size(f);
    u = zeros(h, w);

    for k = 1 : w
        ij = WheelerDTW(f(:, k), g(:, k), p, lmax);
        u(:, k) = ij2u(ij, w);
    end
    
end