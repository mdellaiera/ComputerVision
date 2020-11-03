function u = WheelerDTW(f, g, p, lmax)

e = WheelerErrors(f, g, p, lmax);
a = WheelerAccumulate(e);
kl = WheelerBacktrack(a);
ij = kl2ij(kl, f, g);
u = ij2u(ij, length(f));
sigma = 1;
u = RecursiveExponentialFilter(u, sigma);
    
end

