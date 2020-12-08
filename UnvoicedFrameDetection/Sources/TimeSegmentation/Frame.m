function frame = Frame(signal, position, window_function, overlap)

frame_size = length(window_function);
step = frame_size - overlap;

frame = signal(1 + (position - 1) * step : (position - 1) * step + frame_size, 1);

frame = frame .* window_function;

end

