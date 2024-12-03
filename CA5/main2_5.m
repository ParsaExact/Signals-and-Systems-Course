close all;
clc;
clear;

% 1- Creating the mapset
mapset = create_mapset();

% 2- Coding the message
fs = 100;
message = 'signal';
bit_rate = 1;
coded_signal = coding_freq(message,bit_rate);

% 3- Adding some noise
sigma = 0.01;
noise = sigma*randn(1,length(coded_signal));
coded_signal = coded_signal + noise;

% 4- Plotting the result
t = 0:(1/fs):(length(coded_signal)/fs)-(1/fs);
figure
plot(t,coded_signal)

% 5- Decoding the coded signal
decoded_message = decoding_freq(coded_signal,bit_rate)