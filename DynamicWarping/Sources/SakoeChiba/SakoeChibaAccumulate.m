function a = SakoeChibaAccumulate(e)

[nj, ni] = size(e);
a = zeros(nj, ni);

for i = 1 : ni
    for j = 1 : nj
        ajm1  = a(max(1, j - 1), i);
        aijm1 = a(max(1, j - 1), max(1, i - 1));
        aim1  = a(j, max(1, i - 1));
        
        amin = min([ajm1, aijm1, aim1]);
        a(j, i) = amin + e(j, i);
    end
end

end

