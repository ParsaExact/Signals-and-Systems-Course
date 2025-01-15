my_signal = zeros(1, 10000);
td = 450 * 2 / 3e8;
ts = 1e-9;
tau = 1e-6;
start_index = ceil(td / ts);
end_index = ceil((td + tau) / ts);
my_signal(start_index:end_index) = 0.5;
time = (0:9999) * ts;
plot(time, my_signal);