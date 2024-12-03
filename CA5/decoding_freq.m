function decoded_message = decoding_freq(coded_sig,bit_rate)
    
    fs = 100;
    N = 100;
    decoded_message = [];
    mapset = create_mapset();

    % Extracting binary message
    bin_message = [];
    thresholds=[];
    for k=1:(2^bit_rate)-1
        thresholds(k) = ((k-1)*(round(39/((2^bit_rate)-1))))+5+(floor((round(39/((2^bit_rate)-1)))/2));
    end
   
    freq = (-fs/2):(fs/N):(fs/2)-(fs/N);
    for j=0:(length(coded_sig)/fs)-1
        to_check = coded_sig((j*fs)+1:((j+1)*fs));
        fftx = abs(fftshift(fft(to_check)));
        [M I] = max(fftx);
        frequ = abs(freq(I));
        for t=1:length(thresholds)
            if frequ<=thresholds(t)
                frequ = thresholds(t)-(floor((round(39/((2^bit_rate)-1)))/2));
                break;
            elseif t==length(thresholds)
                frequ = 44;
            end
        end
        bin_message = [bin_message dec2bin(((frequ-5)/(round(39/((2^bit_rate)-1)))),bit_rate)];
    end

    % Turning the binary message into string
    for p = 1:5:length(bin_message)-4
        message_to_check = bin_message(p:p+4);
        message_to_check = mapset{1,bin2dec(message_to_check)+1};
        decoded_message = [decoded_message message_to_check];
    end
    
end