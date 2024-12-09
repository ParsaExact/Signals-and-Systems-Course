% part 1 - section 0
f=-10:1:9;
fs=20;
ts=1/fs;
t=0:ts:1-ts;
x1=exp(1i*2*pi*5*t)+exp(1i*2*pi*8*t);
x2=exp(1i*2*pi*5*t)+exp(1i*2*pi*5.1*t);
y1=fftshift(fft(x1));
y2=fftshift(fft(x2));
out1=y1/max(abs(y1));
out2=y2/max(abs(y2));
plot(f,abs(out1));
figure
plot(f,abs(out2));