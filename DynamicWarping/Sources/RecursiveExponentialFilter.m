function g = RecursiveExponentialFilter(f, sigma)

f(isnan(f)) = 0;

if sigma <= 0
    a = 0;
else
    a = 1 + sigma^2 - sqrt(1 + 2 * sigma^2) / sigma^2;
end

n = length(f);
aa = a^2;
ss = 1 - a;
gg = aa - a;
c = (1 - aa - ss) / ss;
d = 1 / (1 - aa + gg * (1 + c * aa^(n - 1)));

% Copy scaled input to output
g = f * (1 - a)^2;

% Reversed triangular factorization
k = 2 * n - 2; % 1 <= k <= 2 * n - 2
gnm1 = 0;
m = k - n + 1; % 2 - n <= m <= n - 1

for i = m + 1 : -1 : 2
    gnm1 = a * gnm1 + g(i);
end

gnm1 = gnm1 * c;

if (n - k < 1)
    gnm1 = a * gnm1 + (1 + c) * g(1);
end

m = max(n - k, 1); % 1 <= m <= n-1

for i = m + 1 : n
    gnm1 = a * gnm1 + g(i);
end

gnm1 = gnm1 * d;

% Reverse substitution
g(n) = g(n) - gg * gnm1;

for i = n - 1 : -1 : 1
    g(i) = g(i) + a * g(i + 1);
end

g(1) = g(1) / ss;

% Forward substitution
for i = 2 : n
    g(i) = g(i) + a * g(i - 1);
end

g(n) = gnm1;

end