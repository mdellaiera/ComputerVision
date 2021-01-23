function label_result = IteratedConditionalModes(image, label_initialisation, number_of_classes, mu, sigma, beta, iteration_max)

[rows, cols] = size(image);
label = label_initialisation;

mask = [0 1 0;
        1 0 1;
        0 1 0];
            
energy_gaussian = zeros(rows, cols, number_of_classes);
for k = 1 : number_of_classes
    energy_gaussian(:, :, k) = log(sigma(k) * sqrt(2 * pi)) + (image - mu(k)).^2 / (2 * sigma(k)^2);
end

run = 1;
iteration = 0;

while run == 1 
    number_of_changes = 0;

    % Edges are not taken into account
    for i = 2 : rows - 1
        for j = 2 : cols - 1

            neighborhood = label(i - 1 : i + 1, j - 1 : j + 1);
            energy_local = zeros(1, number_of_classes);
            
            for k = 1 : number_of_classes
                autologistic_potential = ((neighborhood ~= k) - (neighborhood == k)) .* mask * beta;
                energy_regularisation = sum(autologistic_potential(:));
                
                energy_local(k) = energy_gaussian(i, j, k) + energy_regularisation;
            end

            % Get best label
            [~, best_label] = min(energy_local);

            % Replace current label with best label
            if (label(i, j) ~= best_label)
               number_of_changes = number_of_changes + 1; 
               label(i, j) = best_label; 
            end

        end
    end   

    iteration = iteration + 1;
    if (number_of_changes == 0 || iteration > iteration_max) 
        run = 0; 
    end   
end

label_result = label;
   
end



