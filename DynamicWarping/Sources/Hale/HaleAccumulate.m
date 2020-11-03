function a = HaleAccumulate(e, b, dir)

[nl, ni] = size(e);
a = zeros(nl, ni);

if dir >= 0
    ib = 1;  % i beginning
    ie = ni; % i end
    is = 1;  % i step
else
    ib = ni; % i beginning
    ie = 1;  % i end
    is = -1; % i step
end

a(:, ib) = e(:, ib);

for i = ib + is : is : ie
    ix1 = max(1, min(ni, i - is));     % i +/- 1
    ixb = max(1, min(ni, i - is * b)); % i +/- b
    
    for l = 1 : nl
        am = a(max(l - 1, 1), ixb);
        ai = a(l, ix1);
        ap = a(min(l + 1, nl), ixb);
        
        k = ix1;
        while(k ~= ixb)
            am = am + e(max(l - 1, 1), k);
            ap = ap + e(min(l + 1, nl), k);
            k = k - is;
        end
        
        a(l, i) = min([am, ai, ap]) + e(l, i);
    end
end

end
