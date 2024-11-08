close all;
clc;
clear;

% 1- Creating the mapset
Nch = 32 ;
mapset = cell(2,Nch) ;
Alphabet = 'abcdefghijklmnopqrstuvwxyz .,!";' ;
for i = 1:Nch
    mapset{1,i} = Alphabet(i) ;
    mapset{2,i} = dec2bin(i-1,5) ;
end

% 2- Coding function
X = imread('Amsterdam.jpg') ;
initialpic = rgb2gray(X) ;

message = 'signal;' ;
codedpic = coding(message,initialpic,mapset) ;

% 3- plotting 
figure
plot1 = subplot(1,2,1) ;
imshow(initialpic)
title('Original PIC')
plot2 = subplot(1,2,2) ;
imshow(codedpic)
title('Coded PIC')
linkaxes([plot1 plot2])

% 4- Decoding function
blocks_size = 5 ;
DcodedMessage = decoding(codedpic,Alphabet,blocks_size) ;

