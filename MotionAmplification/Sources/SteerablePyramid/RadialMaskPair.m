function [high_mask, low_mask] = RadialMaskPair(radial_grid, radial_scale)

radial_grid_log = log2(radial_grid) - log2(radial_scale);

high_mask = radial_grid_log;

% Range values between '0' and '-pi / 2'
high_mask(high_mask > 0) = 0;
high_mask(high_mask < -1) = -1;
high_mask = high_mask * pi / 2;

high_mask = abs(cos(high_mask));   
low_mask = sqrt(1 - high_mask.^2);

end

