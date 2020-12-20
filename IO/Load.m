function [video_out, frequency_rate] = Load(path, RGB)

disp('Loading video...')

video_reader = VideoReader(path);
frequency_rate = video_reader.FrameRate;

video_out = [];

while hasFrame(video_reader)
    frame = readFrame(video_reader);

    if RGB == true
        video_out = cat(4, video_out, im2double(frame));
    else
        video_out = cat(3, video_out, im2double(rgb2gray(frame)));
    end
end

disp('Video has been loaded.')