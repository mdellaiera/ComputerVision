function u = DynamicWarping(f, g, METHOD, REG_TYPE, p, lmax, b)

if length(size(f)) ~= length(size(g))
    error('SIZE OF ARGUMENTS ERROR');
else
    for i = 1 : length(size(f))
        if size(f, i) ~= size(g, i)
            error('SIZE OF ARGUMENTS ERROR');
        end
    end
end

if length(size(f)) > 2
    IN_TYPE = '';
else
    if size(f, 1) == 1 || size(f, 2) == 1
        IN_TYPE = 'Signal';
    else
        IN_TYPE = 'Image';
    end
end

switch METHOD
    case 'SakoeChiba'
        if nargin ~= 4
            error('NUMBER OF ARGUMENTS ERROR');
        end
    case 'Hale'
        if nargin ~= 7
            error('NUMBER OF ARGUMENTS ERROR');
        end
    case 'Wheeler'
        if nargin ~= 6
            error('NUMBER OF ARGUMENTS ERROR');
        end
    otherwise
        error('METHOD ERROR');
end

switch REG_TYPE
    case 'Default' 
        
    case 'Minima'
        f = Simplify(f, IN_TYPE, REG_TYPE);
        g = Simplify(g, IN_TYPE, REG_TYPE);
    case 'Maxima'
        f = Simplify(f, IN_TYPE, REG_TYPE);
        g = Simplify(g, IN_TYPE, REG_TYPE);
    case 'Extrema'
        f = Simplify(f, IN_TYPE, REG_TYPE);
        g = Simplify(g, IN_TYPE, REG_TYPE);
    otherwise
        error('REGRESSION TYPE ERROR');
end

if nargin > 4
    if mod(floor(lmax), 2) ~= 0
        lmax = floor(lmax) - 1;
    else
        lmax = floor(lmax);
    end
end

switch IN_TYPE
    case 'Signal'       
        switch METHOD
            case 'SakoeChiba'
                u = SakoeChibaDTW(f, g);
            case 'Hale'
                u = HaleDTW(f, g, p, lmax, b);
            case 'Wheeler'
                u = WheelerDTW(f, g, p, lmax);
            otherwise
                error('METHOD ERROR');
        end
    case 'Image'       
        switch METHOD
            case 'SakoeChiba'
                u = SakoeChibaDIW(f, g);
            case 'Hale'
                u = HaleDIW(f, g, p, lmax, b);
            case 'Wheeler'
                u = WheelerDIW(f, g, p, lmax);
            otherwise
                error('METHOD ERROR');
        end
    otherwise
        error('TYPE ERROR');
end

end