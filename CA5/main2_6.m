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

% 3- Adding noise and testing functionality
for i=1:100
    sigma = 0.01*i
    noise = sigma*randn(1,length(coded_signal));
    coded_signal = coded_signal + noise;
    decoded_message = decoding_freq(coded_signal,bit_rate)
end