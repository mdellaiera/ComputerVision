function filters = SteerableFilters(rows, cols, OCTAVE_BANDWIDTH, ORIENTATION_4)

if OCTAVE_BANDWIDTH == true
    scale = 1;
else
    scale = 0.5;
end

if ORIENTATION_4 == true
    number_of_orientations = 4;
else
    number_of_orientations = 8;
end

[radial_grid, angular_grid] = PolarGrid(rows, cols);

% Get scale values
pyramid_scale = floor(log2(min(rows, cols))) - 2;
r = 2.^(0 : -scale : -pyramid_scale);

% Get high-frequency residual filter
count = 1;
[high_mask, low_mask_previous] = RadialMaskPair(radial_grid, r(1));
filters{count} = high_mask;
count = count + 1;

for n = 2 : length(r)
   [high_mask, low_mask] = RadialMaskPair(radial_grid, r(n));
   radial_mask = high_mask .* low_mask_previous;
   
   for o = 1 : number_of_orientations
      angular_mask = AngleMask(angular_grid, o, number_of_orientations);
      filters{count} = radial_mask .* angular_mask / 2;
      count = count + 1;
   end
   
   low_mask_previous = low_mask;
end

% Get low-frequency residual filter
filters{count} = low_mask;

end

