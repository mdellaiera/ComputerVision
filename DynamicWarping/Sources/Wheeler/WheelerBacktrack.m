function kl = WheelerBacktrack(a)

[nl, nk] = size(a);
lmax = (nl - 1) / 2;
lmin = -lmax;
kl = [nk, 0];

% Special case : k = nk
k = nk;
amin = realmax;
for l = lmin + 1 : lmax + 1
    if mod((k + l), 2) == 0
        if a(l - lmin, k) < amin
            amin = a(l - lmin, k);
            kl(1, 2) = l;
        end
    end
end

% General case
l = kl(1, 2);
while k >= 1
    if l - lmin - 1 >= 1
        alm = a(l - lmin - 1, max(1, k - 1));
    else
        alm = realmax;
    end

    al = a(l - lmin, max(1, k - 2));

    if l - lmin + 1 <= nl
        alp = a(l - lmin + 1, max(1, k - 1));
    else
        alp = realmax;
    end
    
    amin = min([alm, al, alp]);
        
    if amin == al 
        k = k - 2;
    elseif amin == alm 
        k = k - 1;
        l = l - 1;
    else 
        k = k - 1;
        l = l + 1;
    end
    
    kl = [kl; [k, l]];
end
    
end

