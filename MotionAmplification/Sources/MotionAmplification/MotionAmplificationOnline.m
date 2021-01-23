function video_magnified = MotionAmplificationOnline(video_in, OCTAVE_BANDWIDTH, ORIENTATION_4, amplification_factor, filter_temporal)

% Get parameters
if length(size(video_in)) == 3
    [rows, cols, number_of_frames] = size(video_in);
    number_of_channels = 1;
else
    [rows, cols, number_of_channels, number_of_frames] = size(video_in);
end

video_magnified = zeros(size(video_in));

% Pre-compute filters and indices
[cropped_filters, indices] = CroppedSteerableFilters(rows, cols, OCTAVE_BANDWIDTH, ORIENTATION_4);

% Convolution kernel for temporal filtering
number_of_elements = 0;
for i = 2 : length(indices) - 1
    number_of_elements = number_of_elements + size(indices{i, 1}, 2) * size(indices{i, 2}, 2);
end

kernel = zeros(number_of_elements, length(filter_temporal));

% Amplification
for k = 1 : number_of_frames
    fprintf('Processing frame %d of %d\n', k, number_of_frames);
    
    % Load frame
    if (number_of_channels == 1)
        frame = video_in(:, :, k);
    else
        frame = rgb2lab(video_in(:, :, :, k));
    end
    
    frame_magnified = zeros(size(frame));
    
    for c = 1 : number_of_channels
        % Compute pyramid
        pyramid = BuildPyramid(frame(:, :, c), cropped_filters, indices);
        
        % Get phase and magnitude
        phase = [];
        magnitude = [];
        shape = [];
        for l = 2 : length(pyramid) - 1
            level = pyramid{l};
            shape = [shape; size(level, 1), size(level, 2)];
            
            phase_level = angle(level);
            phase = [phase; phase_level(:)];
            
            magnitude_level = abs(level);
            magnitude = [magnitude; magnitude_level(:)];
        end
        
        % Temporal filtering
        kernel(:, end) = [];
        kernel = [phase, kernel];
        phase_filtered = sum(kernel .* filter_temporal, 2);
        
        % Phase amplification
        phase_magnified = amplification_factor * phase_filtered + phase;
        
        % Recombine levels
        pyramid_magnified = pyramid;
        index = 1;
        for l = 1 : length(pyramid) - 2
            position = index : index + prod(shape(l, :)) - 1;
            level = magnitude(position) .* exp(1i * phase_magnified(position));
            pyramid_magnified{l + 1} = reshape(level, shape(l, :));
            
            index = index + prod(shape(l, :));
        end
        
        % Collapse pyramid
        frame_magnified(:, :, c) = CollapsePyramid(pyramid_magnified, cropped_filters, indices);
    end
    
    % Write frame
    if (number_of_channels == 1)
        video_magnified(:, :, k) = frame_magnified;
    else
        video_magnified(:, :, :, k) = lab2rgb(frame_magnified);
    end
end

end

