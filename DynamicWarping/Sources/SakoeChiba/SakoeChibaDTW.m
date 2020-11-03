function u = SakoeChibaDTW(f, g)

e = SakoeChibaErrors(f, g);
a = SakoeChibaAccumulate(e);
ij = SakoeChibaBacktrack(a);
u = ij2u(ij, length(f));
sigma = 1;
u = RecursiveExponentialFilter(u, sigma);

end

