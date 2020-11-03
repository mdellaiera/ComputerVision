function out = ColorTransfer(source, target, CONTRAST)

% RGB to Lab color space
sourceLab = rgb2lab(source);
targetLab = rgb2lab(target);

% Color Transfer
outLab = zeros(size(targetLab));

if CONTRAST == false
    outLab(:, :, 1) = targetLab(:, :, 1);
    i = 2;
else
    i = 1;
end

for c = i : 3
    sourceChannel = sourceLab(:, :, c);
    targetChannel = targetLab(:, :, c);
    
    sourceMean = mean(sourceChannel(:));
    sourceStd  = std(sourceChannel(:));
    targetMean = mean(targetChannel(:));
    targetStd  = std(targetChannel(:));
    
    outLab(:, :, c) = (targetChannel - targetMean) * (sourceStd / targetStd) + sourceMean;
end

% Lab to RGB color space
out = lab2rgb(outLab);

end

