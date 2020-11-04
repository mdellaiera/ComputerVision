function data_average = GaussianAverage(data, radius)

data_size = size(data);
gaussian_filter = Gaussian(radius);
data_average = zeros(data_size);

if (length(data_size) == 3)

    for i = 1 : data_size(3)
        data_average(:, :, i) = conv2(conv2(data(:, :, i), gaussian_filter, 'same'), gaussian_filter', 'same');
    end

elseif (length(data_size) == 4)
    
    for i = 1 : data_size(3)
        for j = 1 : data_size(4)
            data_average(:, :, i, j) = conv2(conv2(data(:, : ,i, j),gaussian_filter, 'same'), gaussian_filter', 'same');
        end
    end

end

end

