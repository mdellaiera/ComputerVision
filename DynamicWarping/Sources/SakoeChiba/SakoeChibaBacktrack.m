function ij = SakoeChibaBacktrack(a)

[nj, ni] = size(a);
i = ni;
j = nj;

ij = [ni, nj];

while (i > 0) && (j > 0)
    if i == 1
        j = j - 1;
    elseif j == 1
        i = i - 1;
    else
        ajm1  = a(max(1, j - 1), i);
        aijm1 = a(max(1, j - 1), max(1, i - 1));
        aim1  = a(j, max(1, i - 1));
        
        amin = min([ajm1, aijm1, aim1]);
        
        if amin == aijm1
            i = i - 1;
            j = j - 1;
        elseif amin == ajm1
            j = j - 1;
        else
            i = i - 1;
        end
    end
    
    ij = [ij; [i, j]];
end

ij = ij(end - 1 : -1 : 1, :);

end

