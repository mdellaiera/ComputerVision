function u = HaleDTW(f, g, p, lmax, b)

dir = 1;
e = HaleErrors(f, g, p, lmax);
a = HaleAccumulate(e, b, dir);
u = HaleBacktrack(a, e, lmax, b, -dir);
u = interp1(1 : length(f), u, (1 : length(f)) + u);
sigma = 1;
u = RecursiveExponentialFilter(u, sigma);

end

