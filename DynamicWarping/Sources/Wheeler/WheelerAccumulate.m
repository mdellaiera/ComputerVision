function a = WheelerAccumulate(e)

[nl, nk] = size(e);
lmax = (nl - 1) / 2;
lmin = -lmax;
a = zeros(nl, nk);

% Special case : k = 1
k = 1;
a(:, k) = e(:, k);

% Special case : k = 2
k = 2; 
for l = lmin + 1 : lmax + 1
    if mod(k + l, 2) == 0 
        if l - lmin - 1 >= 1
            alm = a(l - lmin - 1, k - 1);
        else
            alm = realmax;
        end
        
        if l - lmin + 1 >= nl
            alp = a(l - lmin + 1, k - 1);
        else
            alp = realmax;
        end
        
        a(l - lmin, k) = min(alm, alp) + e(l - lmin, k);
    end
end

% General case
for k = 3 : nk
    for l = lmin + 1 : lmax + 1
        if mod(k + l, 2) == 0 
            if l - lmin - 1 >= 1
                alm = a(l - lmin - 1, k - 1);
            else
                alm = realmax;
            end
            
            al = a(l - lmin, k - 2);

            if l - lmin + 1 <= nl
                alp = a(l - lmin + 1, k - 1);
            else
                alp = realmax;
            end

            a(l - lmin, k) = min([alm, al, alp]) + e(l - lmin, k);
        end
    end
end

end

