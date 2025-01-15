function p4_4(x, speed)
    if speed <= 0
        error('Speed must be greater than 0.');
    end
    fs =  48000;
    new_fs = speed * fs;
    x_resampled = resample(x, fs, new_fs);
    sound(x_resampled, new_fs);
end