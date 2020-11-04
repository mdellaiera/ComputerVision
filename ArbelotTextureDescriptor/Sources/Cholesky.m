function cholesky_matrix = Cholesky(covariance_matrix)

[rows, cols, ~, number_of_features] = size(covariance_matrix);
cholesky_matrix = zeros(rows, cols, number_of_features, number_of_features);

for j = 1 : number_of_features
    for i = j : number_of_features
        sum = 0;
        
        for k = 1 : j - 1
            sum = sum + cholesky_matrix(:, :, i, k) .* cholesky_matrix(:, :, j, k);
        end
        
        if i == j
            cholesky_matrix(:, :, i, j) = sqrt(covariance_matrix(:, :, i, j) - sum);
        else
            cholesky_matrix(:, :, i, j) = 1 ./ cholesky_matrix(:, :, j, j) .* (covariance_matrix(:, :, i, j) - sum);
        end
    end
end

end

