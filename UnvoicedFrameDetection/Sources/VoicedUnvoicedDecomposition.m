function [indices_voiced, indices_unvoiced] = VoicedUnvoicedDecomposition(frames, threshold_power, threshold_zero_crossing)

number_of_frames = length(frames);

indices_unvoiced = [];
indices_voiced   = [];

for i = 1 : number_of_frames
    frame = frames{i};
    power = sum(frame .* frame);
    
    mask = (frame >= 0) + (frame < 0) * -1;
    zero_crossing = conv(mask, [1, 1], 'same');
    number_of_zero_crossing = sum(zero_crossing == 0); 
    
    if (power < threshold_power) && (number_of_zero_crossing > threshold_zero_crossing)
        indices_unvoiced = [indices_unvoiced, i];
    else
        indices_voiced = [indices_voiced, i];
    end
end

end

