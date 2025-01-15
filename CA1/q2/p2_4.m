function [m, h] = p2_4(x, y)
x_mean = mean(x);
y_mean = mean(y);
x_dev = x - x_mean;
y_dev = y - y_mean;
numerator = sum(x_dev .* y_dev);
denominator = sum(x_dev .^ 2);
m = numerator / denominator;
h = y_mean - m * x_mean;
end