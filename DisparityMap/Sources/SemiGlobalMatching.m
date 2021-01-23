function accumulated_costs = SemiGlobalMatching(unary_terms, alpha)

[rows, cols, number_of_disparities] = size(unary_terms);

cost_lr = permute(unary_terms, [3, 1, 2]); % left -> right
cost_rl = permute(unary_terms, [3, 1, 2]); % right -> left
cost_bt = permute(unary_terms, [3, 2, 1]); % bottom -> top
cost_tb = permute(unary_terms, [3, 2, 1]); % top -> bottom

penalty = ones(number_of_disparities, rows) .* (0 : number_of_disparities - 1)';

for i = 2 : cols
    for d = 1 : number_of_disparities
        % left -> right
        line = cost_lr(:, :, i - 1) + alpha * abs(penalty - d + 1) .* abs(penalty - d + 1);
        cost_lr(d, :, i) = cost_lr(d, :, i) + min(line);
        
        % right -> left
        line = cost_rl(:, :, cols - i + 2) + alpha * abs(penalty - d + 1) .* abs(penalty - d + 1);
        cost_rl(d, :, cols - i + 1) = cost_rl(d, :, cols - i + 1) + min(line);
    end
end

penalty = ones(number_of_disparities, cols) .* (0 : number_of_disparities - 1)';

for i = 2 : rows
    for d = 1 : number_of_disparities
        % bottom -> top
        line = cost_tb(:, :, rows - i + 2) + alpha * abs(penalty - d + 1) .* abs(penalty - d + 1);
        cost_tb(d, :, rows - i + 1) = cost_tb(d, :, rows - i + 1) + min(line);
        
        % top -> bottom
        line = cost_bt(:, :, i - 1) + alpha * abs(penalty - d + 1) .* abs(penalty - d + 1);
        cost_bt(d, :, i) = cost_bt(d, :, i) + min(line);
    end
end

cost_lr = permute(cost_lr, [2, 3, 1]);
cost_rl = permute(cost_rl, [2, 3, 1]);
cost_bt = permute(cost_bt, [3, 2, 1]);
cost_tb = permute(cost_tb, [3, 2, 1]);

accumulated_costs = cost_lr + cost_rl + cost_bt + cost_tb;

end

