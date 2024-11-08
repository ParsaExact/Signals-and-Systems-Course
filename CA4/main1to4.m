close all;
clc;
clear;

% 1- Creating the mapset
mapset = create_mapset();

% 2- Coding the message
fs = 100;
message = 'signal';
bit_rate = 3;
coded_signal = coding_amp(message,bit_rate);

% 3- Plotting the result
t = 0:(1/fs):(length(coded_signal)/fs)-(1/fs);
figure
plot(t,coded_signal)

% 3- Decoding the coded signal
decoded_message = decoding_amp(coded_signal,bit_rate)