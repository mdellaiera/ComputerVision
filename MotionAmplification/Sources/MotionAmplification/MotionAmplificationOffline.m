function video_magnified = MotionAmplificationOffline(video_in, OCTAVE_BANDWIDTH, ORIENTATION_4, amplification_factor, filter_temporal)

% Get parameters
if length(size(video_in)) == 3
    [rows, cols, number_of_frames] = size(video_in);
    number_of_channels = 1;
else
    [rows, cols, number_of_channels, number_of_frames] = size(video_in);
end

% Pre-compute filters and indices
[cropped_filters, indices] = CroppedSteerableFilters(rows, cols, OCTAVE_BANDWIDTH, ORIENTATION_4);
number_of_filters = length(cropped_filters);

% Move temporal filter in the frequency domain
tmp(1, 1, :) = fft(ifftshift(filter_temporal), number_of_frames);
filter_frequencial = single(repmat(tmp, rows, cols));

% Move input video in Lab color space and in frequency domain
video_lab_fft = zeros(size(video_in), 'single');

if number_of_channels == 3
    for k = 1 : number_of_frames
        frame_rgb = video_in(:, :, :, k);
        frame_lab = rgb2lab(frame_rgb);
        
        frame_fft = zeros(size(frame_lab));
        for c = 1 : number_of_channels
            frame_fft(:, :, c) = single(fftshift(fft2(frame_lab(:, :, c)))); 
        end
        
        video_lab_fft(:, :, :, k) = frame_fft;
    end
else
    for k = 1 : number_of_frames
        frame = video_in(:, :, k);
        video_lab_fft(:, :, k) = single(fftshift(fft2(frame)));
    end
end

% Amplification
video_magnified_fft = zeros(size(video_in), 'single');

for c = 1 : number_of_channels
    fprintf('Processing channel %d of %d\n', c, number_of_channels);
    
    for i = 2 : number_of_filters - 1
        fprintf('Processing level %d of %d\n', i - 1, number_of_filters - 2);
        
        % Load filter and indices
        filter = cropped_filters{i};
        indice_1 = indices{i, 1};
        indice_2 = indices{i, 2};
        
        % Get reference frame
        if number_of_channels == 3
            frame = video_lab_fft(indice_1, indice_2, c, 1);
        else
            frame = video_lab_fft(indice_1, indice_2, 1);
        end
        
        % Extract reference phase from reference frame
        level = BuildLevel(frame, filter);
        phase_reference = angle(level);
        
        % Substract reference phase on each other phase
        delta = zeros(length(indice_1), length(indice_2), number_of_frames, 'single');
        for k = 1 : number_of_frames
            % Get frame
            if number_of_channels == 3
                frame = video_lab_fft(indice_1, indice_2, c, k);
            else
                frame = video_lab_fft(indice_1, indice_2, k);
            end
            
            % Extract phase
            level = BuildLevel(frame, filter);
            phase = angle(level);
            
            % Substract
            delta(:, :, k) = phase_reference - phase;
        end
    
        % Temporal filtering in the frequencial domain
        delta = real(ifft(fft(delta, [], 3) .* filter_frequencial(indice_1, indice_2, :), [], 3));

        % Amplify filtered phase
        for k = 1 : number_of_frames
            % Get frame
            if number_of_channels == 3
                frame = video_lab_fft(indice_1, indice_2, c, k);
            else
                frame = video_lab_fft(indice_1, indice_2, k);
            end
            
            % Extract phase and magnitude
            level = BuildLevel(frame, filter);
            phase = angle(level);
            amplitude = abs(level);
            
            % Amplify phase and recombine level
            phase_magnified = amplification_factor * delta(:, :, k) + phase;
            level_magnified = amplitude .* exp(1i * phase_magnified);
            frame_magnified = CollapseLevel(level_magnified, filter);
            
            if number_of_channels == 3
                video_magnified_fft(indice_1, indice_2, c, k) = ...
                    video_magnified_fft(indice_1, indice_2, c, k) + ...
                    frame_magnified;
            else
                video_magnified_fft(indice_1, indice_2, k) = ...
                    video_magnified_fft(indice_1, indice_2, k) + ...
                    frame_magnified;
            end
        end
        
    end
    
    % Add residuals
    low_filter = cropped_filters{end};
    low_indice_1 = indices{end, 1};
    low_indice_2 = indices{end, 2};
    
    high_filter = cropped_filters{1};
    high_indice_1 = indices{1, 1};
    high_indice_2 = indices{1, 2};
            
    if number_of_channels == 3
        for k = 1 : number_of_frames
            
            low_level = BuildLevel(video_lab_fft(low_indice_1, low_indice_2, c, k), low_filter);
            
            video_magnified_fft(low_indice_1, low_indice_2, c, k) = ...
                video_magnified_fft(low_indice_1, low_indice_2, c, k) + ...
                CollapseLevel(low_level, low_filter) * 0.5;

            high_level = BuildLevel(video_lab_fft(high_indice_1, high_indice_2, c, k), high_filter);
            
            video_magnified_fft(high_indice_1, high_indice_2, c, k) = ...
                video_magnified_fft(high_indice_1, high_indice_2, c, k) + ...
                CollapseLevel(high_level, high_filter) * 0.5;
        end
    else
        for k = 1 : number_of_frames
            low_level = BuildLevel(video_lab_fft(low_indice_1, low_indice_2, k), low_filter);
            
            video_magnified_fft(low_indice_1, low_indice_2, k) = ...
                video_magnified_fft(low_indice_1, low_indice_2, k) + ...
                CollapseLevel(low_level, low_filter) * 0.5;

            high_level = BuildLevel(video_lab_fft(high_indice_1, high_indice_2, k), high_filter);
            
            video_magnified_fft(high_indice_1, high_indice_2, k) = ...
                video_magnified_fft(high_indice_1, high_indice_2, k) + ...
                CollapseLevel(high_level, high_filter) * 0.5;
        end
    end
    
end

% Move back in spatial domain
video_magnified = zeros(size(video_in));
if number_of_channels == 3
    for k = 1 : number_of_frames
        frame_fft = video_magnified_fft(:, :, :, k);
        
        frame_lab = zeros(size(frame_fft));
        for c = 1 : number_of_channels
            frame_lab(:, :, c) = real(ifft2(ifftshift(frame_fft(:, :, c))));
        end
        
        frame_rgb = lab2rgb(frame_lab);
        video_magnified(:, :, :, k) = frame_rgb;
    end
else
    for k = 1 : number_of_frames
        frame_fft = video_magnified_fft(:, :, k);
        video_magnified(:, :, k) = real(ifft2(ifftshift(frame_fft)));
    end
end

end

