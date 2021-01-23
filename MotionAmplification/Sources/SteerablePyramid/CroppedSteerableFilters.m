function [cropped_filters, indices] = CroppedSteerableFilters(rows, cols, OCTAVE_BANDWIDTH, ORIENTATION_4)

% Get filters of dimensions [rows, cols]
filters = SteerableFilters(rows, cols, OCTAVE_BANDWIDTH, ORIENTATION_4);

% Initialisation
number_of_filters = length(filters);
indices = cell(number_of_filters, 2);    
cropped_filters = cell(1, number_of_filters);

for k = 1 : number_of_filters
    % Get indices where filters coefficients are non-zeros
    filter_indices = IndicesFromFilter(filters{k});
    
    % Store those indices
    indices{k, 1} = filter_indices{1};
    indices{k, 2} = filter_indices{2};
    
    % Store non-zero coefficients only
    cropped_filters{k} = filters{k}(filter_indices{1}, filter_indices{2});
end

end
