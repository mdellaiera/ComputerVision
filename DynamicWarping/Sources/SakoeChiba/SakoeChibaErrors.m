function e = SakoeChibaErrors(f, g)

ni = length(f);
nj = length(g);

e = zeros(nj, ni);

for i = 1 : ni
    for j = 1 : nj
        e(j, i) = abs(f(i) - g(j))^2;
    end
end

end

