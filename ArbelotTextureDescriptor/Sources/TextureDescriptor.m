function descriptor_vector = TextureDescriptor(image, neighborhood_radius)

feature_vector = FeatureVector(image);
feature_vector_average = GaussianAverage(feature_vector, neighborhood_radius);
covariance_matrix = Covariance(feature_vector, neighborhood_radius);
cholesky_matrix = real(Cholesky(covariance_matrix));
descriptor_matrix = cat(4, cholesky_matrix, feature_vector_average);

number_of_features = size(feature_vector, 3);

pos = [];
for i = 1 : number_of_features
    for j = i : number_of_features
        pos = [pos, j + (i - 1) * number_of_features];
    end
end

for k = number_of_features * number_of_features + 1 : number_of_features * (number_of_features + 1)
   pos = [pos, k]; 
end

descriptor_vector = descriptor_matrix(:, :, pos');

end

