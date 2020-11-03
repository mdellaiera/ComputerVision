function u = SakoeChibaDIW(f, g)

[h, w] = size(f);
u = zeros(h, w);
    
for k = 1 : w
    ij = SakoeChibaDTW(f(:, k), g(:, k));
    u(:, k) = ij2u(ij, h);
end

end