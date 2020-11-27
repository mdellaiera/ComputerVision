function signal = Recombine(frames, window_function, overlap)

number_of_frames = length(frames);
frame_size = length(frames{1});
step = frame_size - overlap;

number_of_points = (number_of_frames - 1) * step + frame_size;
signal = zeros(number_of_points, 1);
weights = zeros(number_of_points, 1);

for i = 1 : number_of_frames
    indices = 1 + (i - 1) * step : (i - 1) * step + frame_size;
    signal(indices) = signal(indices) + frames{i};
    weights(indices) = weights(indices) + window_function;
end

signal = signal ./ weights;

end

