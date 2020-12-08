function frames = Frames(signal, window_function, overlap)

number_of_points = length(signal);
frame_size = length(window_function);
step = frame_size - overlap;
number_of_frames = floor((number_of_points - overlap) / step);

residual = number_of_points - ((number_of_frames - 1) * step + frame_size);

if residual ~= 0
    signal = [signal; zeros(frame_size - residual, 1)];
    number_of_frames = number_of_frames + 1;
end
frames = cell(1, number_of_frames);

for i = 1 : number_of_frames
    frame = signal(1 + (i - 1) * step : (i - 1) * step + frame_size, 1);
    
    frames{i} = frame .* window_function;
end

end

