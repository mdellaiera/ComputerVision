function us = HaleDIW(f, g, p, lmax, b)

[h, w] = size(f);
lmax = min(h, lmax);
nl = 1 +  2 * lmax;
u = zeros(h, w);
e = zeros(nl, h, w);

for i = 1 : w
    e(:, :, i) = HaleErrors(f(:, i), g(:, i), p, lmax);
end

e = (e - min(e(:))) / (max(e(:)) - min(e(:)));
es = HaleSmoothErrors(e, b);

for i = 1 : w
    a = HaleAccumulate(es(:, :, i), b, 1);
    ui = HaleBacktrack(a, es(:, :, i), lmax, b, -1);
    u(:, i) = interp1(1 : length(ui), ui, (1 : length(ui)) + ui)';
end

sigma = 1;
us = smoothShifts(u, sigma);

end


















