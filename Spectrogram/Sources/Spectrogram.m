function time_frequency = Spectrogram(signal, window_function, overlap, number_of_points_fft, frequency_rate)

number_of_points = length(signal);
frame_size = length(window_function);
step = frame_size - overlap;
number_of_frames = floor((number_of_points - overlap) / step);

time_frequency = zeros(floor(number_of_points_fft / 2), number_of_frames);

for i = 1 : number_of_frames
    frame = signal(1 + (i - 1) * step : (i - 1) * step + frame_size, 1);
    frame = frame .* window_function;
    
    frame_fft = fftshift(fft(frame, number_of_points_fft));
    frame_fft = frame_fft(1 : floor(number_of_points_fft / 2));
    
    frame_psd = 20 * log10(abs(frame_fft));
    time_frequency(:, i) = frame_psd;
end

if nargout == 0
%     axis_time = (0 : number_of_frames - 1) / number_of_frames * number_of_points / frequency_rate;
%     axis_frequency = (0 : number_of_points_fft - 1) / number_of_points_fft * frequency_rate / 2;

    imagesc(time_frequency);
    ylabel('Frequency')
    xlabel('Time')
    title('Spectrogram (dB)')
end

end

