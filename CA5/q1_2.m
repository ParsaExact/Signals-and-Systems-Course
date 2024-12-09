clear;
startT = 0;
endT = 1;
sampleRate = 100;
timeStep = 1 / sampleRate;
totalTime = endT - startT;
numSamples = totalTime / timeStep;
timeVec = startT : timeStep : endT - timeStep;
freqVec = (-sampleRate / 2) : (sampleRate / numSamples) : (sampleRate / 2 - sampleRate / numSamples);
signal2 = cos(30 * pi * timeVec + pi / 4);
plot(timeVec, signal2);

% Calculate FFT
fftResult2 = fftshift(fft(signal2));
normalizedFft2 = fftResult2 / max(abs(fftResult2));
figure;
plot(freqVec, abs(normalizedFft2));

% Phase Analysis
tolerance = 1e-6;
normalizedFft2(abs(normalizedFft2) < tolerance) = 0;
phaseAngles = angle(normalizedFft2);
figure;
plot(freqVec, phaseAngles / pi);
xlabel('Frequency (Hz)');
ylabel('Phase');
