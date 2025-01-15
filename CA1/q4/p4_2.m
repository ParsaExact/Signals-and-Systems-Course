[x, fs] = audioread('poem.wav');
t = (0:length(x)-1) / fs;
plot(t, x);
xlabel('Time (seconds)');
ylabel('Amplitude');
title('Audio Waveform');
sound(x,fs)