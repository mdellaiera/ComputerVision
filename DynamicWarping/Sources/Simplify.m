function g = Simplify(f, IN_TYPE, REG_TYPE)

g = zeros(size(f));

switch IN_TYPE
    case 'Signal'
        g = Regression(f, REG_TYPE);      
    case 'Image'
        for i = 1 : size(f, 2)
            g(:, i) = Regression(f(:, i), REG_TYPE);
        end      
    otherwise
        g = f;   
end

end

