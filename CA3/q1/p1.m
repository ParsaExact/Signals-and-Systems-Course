imageData = imread('UT_IMAGE.jfif');
grayImage = rgb2gray(imageData);

numChannels = 32;
charMap = cell(2, numChannels);
alphabet = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ ,;?.!';

for i = 1:numChannels
    charMap{1, i} = alphabet(i);
    charMap{2, i} = dec2bin(i - 1, 5);
end

msg = 'SIGNAL;';

encodedImage = coding(msg,grayImage,charMap);
subplot(1, 2, 1);
imshow(grayImage);
title('Original Image');

subplot(1, 2, 2);
imshow(encodedImage);
title('Encoded Image');


DcodedMessageBin = decoding(encodedImage,Alphabet);

sprintf(decodedMsgBin)
