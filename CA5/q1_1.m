% part 1 - section 1
clear
fs = 50;
ts = 1 / fs;
t = -1 : ts : 1 - ts;
x1 = cos(10 * pi * t);
plot(t, x1);

y1 = fftshift(fft(x1));
N = length(t);
f = -fs / 2 : fs / N : (fs / 2) - (fs / N);

out = y1 / max(abs(y1));
figure;
plot(f, abs(out));
