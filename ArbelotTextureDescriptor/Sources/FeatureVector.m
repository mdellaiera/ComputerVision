function feature_vector = FeatureVector(image)

number_of_features = 6;
[rows, cols] = size(image);
feature_vector = zeros(rows ,cols, number_of_features);

first_order_filter = 0.5 * [1, 0, -1];
second_order_filter = [1, -2, 1];

feature_vector(:, :, 1) = conv2(image, first_order_filter, 'same');
feature_vector(:, :, 2) = conv2(image, first_order_filter', 'same');
feature_vector(:, :, 3) = conv2(image, second_order_filter, 'same');
feature_vector(:, :, 4) = conv2(image, second_order_filter', 'same');
feature_vector(:, :, 5) = conv2(conv2(image, first_order_filter, 'same'), first_order_filter', 'same');
feature_vector(:, :, 6) = image;

for k = 1 : number_of_features
    current_feature_vector = feature_vector(:, :, k);
    feature_vector(:, :, k) = current_feature_vector / std(current_feature_vector(:));
end

end

