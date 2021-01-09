function Write(video_in, frequency_rate, path, RGB)

disp('Writing video...')

video_in(video_in > 1) = 1;
video_in(video_in < 0) = 0;

video_writer = VideoWriter(path);
video_writer.FrameRate = frequency_rate;
open(video_writer)

if (RGB == true && length(size(video_in)) == 4)
    video_out = video_in;
else
    video_out = zeros(size(video_in, 1), size(video_in, 2), 3, size(video_in, length(size(video_in))));
    
    for k = 1 : size(video_in, length(size(video_in)))
        if length(size(video_in)) == 4
            frame = video_in(:, :, :, k);
            frame = rgb2gray(frame);
        else
            frame = video_in(:, :, k);
        end
        
        video_out(:, :, :, k) = cat(3, frame, frame, frame);
    end
end

writeVideo(video_writer, video_out)
close(video_writer)

disp('Video has been written.')

end

