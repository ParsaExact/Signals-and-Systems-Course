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

% 5- Noise
column = length(coded_signal);
noise=randn(1,column);
figure
histogram(noise)
Mean=mean(noise)
variance=var(noise)

% 6- change variance of noise
m = 0.01;
noisy = m * noise;
coded1 = noisy + coded_signal;
decoded = decoding_amp(coded1,bit_rate)
figure
plot(t,coded1)

%7 -sligth change in noise
n=0.01;
for i=1:500
    noisy=n*noise;
    coded=noisy+coded_signal;
    decoded=decoding_amp(coded,bit_rate);
    if ~strcmp(decoded, message)
        variance=n*n;
        disp(variance)
        disp(decoded)
        figure
        plot(coded)
        break
    end
    n=n+0.01;
end

