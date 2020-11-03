function u = HaleBacktrack(a, e, lmax, b, dir)

bInv = 1.0 / b;
[nl, ni] = size(a);
u = zeros(1, ni);

if dir >= 0
    ib = 1;  % i beginning
    ie = ni; % i end
    is = 1;  % i step
else
    ib = ni; % i beginning
    ie = 1;  % i end
    is = -1; % i step
end

i = ib;
[~, l] = min(a(:, i));
u(i) = l;

while (i ~= ie) 
    ix1 = max(1, min(ni, i + is));     % i +/- 1
    ixb = max(1, min(ni, i + is * b)); % i +/- b
    
    am = a(max(l - 1, 1), ixb);
    ai = a(l, ix1);
    ap = a(min(l + 1, nl), ixb);
    
    k = ix1;
    while(k ~= ixb)
        am = am + e(max(l - 1, 1), k);
        ap = ap + e(min(l + 1, nl), k);
        k = k + is;
    end

    amin = min([am, ai, ap]);
   
    if amin ~= ai
        if (amin == am)
            l = l - 1;
        elseif amin == ap
            l = l + 1;
        end
    end
    
    i = i + is;
    u(i) = l;
    
    if (amin == am) || (amin == ap)
        du = (u(i) - u(i - is)) * bInv;
        u(i) = u(i - is) + du;

        k = ix1;
        while(k ~= ixb)
            i = i + is;
            u(i) = u(i - is) + du;
            k = k + is;
        end
    end
end

u = u - lmax;
u = u(end : -1 : 1);

end
