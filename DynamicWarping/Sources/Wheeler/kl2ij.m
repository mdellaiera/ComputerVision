function ij = kl2ij(kl, f, g)

ni = length(f);
nj = length(g);
N = size(kl, 1);
ij = [];

for n = 1 : N
    k = kl(n, 1);
    l = kl(n, 2);
    i = (k - l) / 2;
    j = (k + l) / 2;
    
    if (i >= 1 && i <= ni && j >= 1 && j <= nj ) 
        ij = [ij; [i, j]];
    end
end
    
end

