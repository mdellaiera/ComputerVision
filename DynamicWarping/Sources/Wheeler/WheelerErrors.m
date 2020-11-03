function e = WheelerErrors(f, g, p, lmax)

ni = length(f);
nj = length(g);
lmax = min(max(ni, nj), lmax);
lmin = -lmax;
nl = lmax - lmin + 1;
nk = ni + nj - 1;
e = zeros(nl, nk);

for k = 1 : nk
    for l = lmin + 1 : lmax + 1
        if mod(k + l, 2) == 0
            i = (k - l) / 2;
            j = (k + l) / 2;
            
            if i >= 1 && i <= ni
                fi = f(i);
            else
                fi = f(randi(ni));
            end
            
            if j >= 1 && j <= nj
                gj = g(j);
            else
                gj = g(randi(nj));
            end
            
            e(l - lmin, k) = abs(fi - gj)^p;
        end
    end
end
    
end
