function e = HaleErrors(f, g, p, lmax)

ni = length(f);
nj = length(g);
lmax = min(max(ni, nj), lmax);
nl = 1 +  2 * lmax;

e = zeros(nl, ni);    % alignment errors
e_avg = zeros(1, nl); % average error at each lag
e_n = zeros(1, nl);   % number of valid values at each lag

for i = 1 : ni
    lm = max(1, lmax - i + 1);   % minimum valid lag indice
    lM = min(nl, ni + lmax - i); % maximum valid lag indice
    
    for l = lm : lM
        e(l, i) = abs(f(i) - g(i + l - lmax))^p;
        e_avg(l) = e_avg(l) + e(l, i);
        e_n(l) = e_n(l) + 1;
    end
end

e_avg = e_avg ./ e_n;

for i = 1 : ni
    lm = max(1, lmax - i + 1);   % minimum valid lag indice
    lM = min(nl, ni + lmax - i); % maximum valid lag indice
    
    for l = 1 : nl
        if (l < lm || l > lM)   % if indice is not valid
            e(l, i) = e_avg(l); % extrapolate with average lag
        end
    end
end

end

