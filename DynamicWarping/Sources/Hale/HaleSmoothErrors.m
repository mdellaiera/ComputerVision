function es = HaleSmoothErrors(e, b)

    [~, h, w] = size(e);
    es = zeros(size(e));

    % Vertical smoothing
    for k = 1 : size(e, 3)
        al = accumulateHale(e(:, :, k), b,  1); 
        ar = accumulateHale(e(:, :, k), b, -1); 
        es(:, :, k) = al + ar - e(:, :, k);
    end
    
    % Normalization
    es = (es - min(es(:))) / (max(es(:)) - min(es(:)));
    
    % Horizontal smoothing
%     for i = 1 : size(e, 1)
%         al = accumulateHale(squeeze(es(i, :, :)), b,  1); 
%         ar = accumulateHale(squeeze(es(i, :, :)), b, -1); 
%         es(i, :, :) = reshape(al, [1, h, w]) + reshape(ar, [1, h, w]) - es(i, :, :);
%     end
    
    % Normalization
    es = (es - min(es(:))) / (max(es(:)) - min(es(:)));
    
end

