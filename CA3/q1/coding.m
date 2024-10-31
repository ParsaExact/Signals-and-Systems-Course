function [encodedImage]=coding(msg,grayImage,charMap)

msgLength = length(msg);
msgBin = cell(1, msgLength);

for i = 1:msgLength
    character = msg(i);
    index = strcmp(character, charMap(1, :));
    msgBin{i} = charMap{2, index};
end

binaryMsg = cell2mat(msgBin);
binaryMsgLength = length(binaryMsg);

encodedImage = grayImage;
for i = 1:binaryMsgLength
    pixelValue = grayImage(i);
    pixelBin = dec2bin(pixelValue);
    modifiedBin = pixelBin;
    modifiedBin(end) = binaryMsg(i);
    encodedImage(i) = bin2dec(modifiedBin);
end
end
