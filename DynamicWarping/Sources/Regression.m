function g = Regression(f, REG_TYPE)

n = length(f);
avg = mean(f);
f = f - avg;
M = [];
m = [];

i = 2;
while i < n
    fim1 = abs(f(i - 1));
    fi   = abs(f(i));
    fip1 = abs(f(i + 1));
    
    if fi > fim1 && fi >= fip1
        imin = i;
        imax = i + 1;
        
        while (fi == abs(f(imax))) && (imax < n)
            imax = imax + 1;
        end
        
        i = imax;
        imid = imin + floor((imax - imin) / 2);
        
        if sign(f(i)) > 0
            M = [M; imid];
        else
            m = [m; imid];
        end
    else
        i = i + 1;
    end
end

g = zeros(1, n);

switch REG_TYPE
    case 'Minima'
        m = [1; m; n];
        
        for i = 1 : length(m) - 1
            g(m(i) : m(i + 1)) = linspace(f(m(i)), f(m(i + 1)), m(i + 1) - m(i) + 1);
        end
    case 'Maxima'
        M = [1; M; n];
        
        for i = 1 : length(M) - 1
            g(M(i) : M(i + 1)) = linspace(f(M(i)), f(M(i + 1)), M(i + 1) - M(i) + 1);
        end
    otherwise
        E = sort([1; m; M; n]);
        
        for i = 1 : length(E) - 1
            g(E(i) : E(i + 1)) = linspace(f(E(i)), f(E(i + 1)), E(i + 1) - E(i) + 1);
        end
end

g = g + avg;

end

