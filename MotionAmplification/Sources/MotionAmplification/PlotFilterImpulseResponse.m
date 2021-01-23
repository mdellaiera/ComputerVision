function PlotFilterImpulseResponse(filter, frequency_low, frequency_high, frequency_rate)

number_of_points_fft = 2^16;

[transfer_function, axis_frequency] = freqz(filter, 1, number_of_points_fft, frequency_rate);
transfer_function_db = 20 * log10(abs(transfer_function)); 

xl = axis_frequency(find(diff(sign(axis_frequency - frequency_low))));
xh = axis_frequency(find(diff(sign(axis_frequency - frequency_high))));
value_min = min(transfer_function_db) - 10;
value_max = max(transfer_function_db) + 10;

figure
plot(axis_frequency, transfer_function_db, 'b')
hold on
plot([xl, xl], [value_min, value_max], 'r')
plot([xh, xh], [value_min, value_max], 'r')
xlabel('Hz')
ylabel('|H|dB')
ylim([value_min, value_max])
title('Temporal filter impulse response')

end

