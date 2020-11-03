function indices = IndicesFromFilter(filter)

threshold = 1e-10;

% Discard every coefficients lower than threshold
aboveZero = filter > threshold;

% Project the non-zero coefficients on the x-axis
dim1 = sum(aboveZero, 2) > 0;

% Ensure the same number of indices from either side of x-center
dim1 = or(dim1, rot90(dim1, 2));

% Project the non-zero coefficients on the y-axis
dim2 = sum(aboveZero, 1) > 0;

% Ensure the same number of indices from either side of y-center
dim2 = or(dim2, rot90(dim2, 2));

% Initialisation
[h, w] = size(filter);
idy = 1 : h;
idx = 1 : w;

idy = idy(dim1);
idy = min(idy) : max(idy);

idx = idx(dim2);
idx = min(idx) : max(idx);

indices{1} = idy;
indices{2} = idx;

end

