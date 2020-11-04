function covariance_matrix = Covariance(feature_vector, neighborhood_radius)

gaussian_filter = Gaussian(neighborhood_radius);
feature_vector_average = GaussianAverage(feature_vector, neighborhood_radius);

[rows, cols, number_of_features] = size(feature_vector);
covariance_matrix = zeros(rows, cols, number_of_features, number_of_features);

for i = 1 : number_of_features
    for j = i : number_of_features
        feature_vector_i = feature_vector(:, :, i);
        feature_vector_j =  feature_vector(:, :, j);
        
        mean_i = feature_vector_average(:, :, i);
        mean_j = feature_vector_average(:, :, j);
        
        covariance_matrix(:, :, i, j) = conv2(conv2(feature_vector_i .* feature_vector_j, gaussian_filter, 'same'), gaussian_filter', 'same');
        covariance_matrix(:, :, i, j) = covariance_matrix(:, :, i, j) - mean_i .* mean_j;
        
        % Covariance matrix is symmetric
        covariance_matrix(:, : ,j, i) = covariance_matrix(:, :, i, j);
    end
end

end

