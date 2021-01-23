function label_result = Metropolis(image, label_initialisation, number_of_classes, mu, sigma, beta, temperature, K, iteration_max)

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

            x = randi(number_of_classes);
            s = label(i, j);
            neighborhood = label(i - 1 : i + 1, j - 1 : j + 1);

            autologistic_potential_state = ((neighborhood ~= s) - (neighborhood == s)) .* mask * beta;
            energy_state = log(sigma(s) * sqrt(2*pi)) + (image(i,j) - mu(s))^2 / (2 * sigma(s) ^2) + sum(autologistic_potential_state(:));

            autologistic_potential_random = ((neighborhood ~= x) - (neighborhood == x)) .* mask * beta;
            energy_random = log(sigma(x) * sqrt(2*pi)) + (image(i,j) - mu(x))^2 / (2 * sigma(x) ^2) + sum(autologistic_potential_random(:));

            % Compare energies
            if (energy_random < energy_state)
               label(i, j) = x;
               number_of_changes = number_of_changes + 1; 
            else
               p = exp(abs(energy_random - energy_state)/temperature);
               r = rand(1);
               label(i, j) = x * (p < r) + s * (p >= r);
               
               if (p < r)
                   number_of_changes = number_of_changes + 1; 
               end
            end

        end
    end   

    temperature = K * temperature;
    
    iteration = iteration + 1;
    if (number_of_changes == 0 || iteration > iteration_max) 
        run = 0; 
    end  
end

label_result = label;
   
end



