function [decodedMsgBin] = decoding(encodedImage,alphabet)
decodedMsgBin = [];
stopFlag = true;
index = 1;

while stopFlag
    charBin = zeros(1, 5);
    for count = 1:5
        pixelValue = encodedImage(index);
        pixelBin = dec2bin(pixelValue);
        charBin(count) = str2double(pixelBin(end));
        index = index + 1;
    end
    num = sum(charBin .* (2.^(4:-1:0))) + 1;
    if strcmp(alphabet(num), '!')
        stopFlag = false;
    else
        decodedMsgBin = [decodedMsgBin alphabet(num)];
    end
end
