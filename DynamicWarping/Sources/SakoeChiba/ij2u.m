function u = ij2u(ij, ni)

u = zeros(1, ni);
i = ij(:, 1);
j = ij(:, 2);

for l = 1 : ni
    lag = l - j(i == l);
    u(l) = sum(lag) / length(lag);
end

end

