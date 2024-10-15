clc
close all;
clear;

%1)extracting Original image
[file,path]=uigetfile({'*.jpg;*.bmp;*.png;*.tif'},'Choose an image');
s=[path,file];
picture=imread(s);
figure
subplot(3,2,1)
imshow(picture)
title('Original Image')

%2)resizing the image for better correlation
picture=imresize(picture,[300 500]);
subplot(3,2,2)
imshow(picture)
title('Resized Image')


%3)making the image gray
picture=rgb2gray(picture);
subplot(3,2,3)
imshow(picture)
title('Grayscal Image')

%4)making the image binary(black & white)
threshold = graythresh(picture);
picture =~imbinarize(picture,threshold);
subplot(3,2,4)
imshow(picture)
title('Binary Image')

%5)cleaning the image by using connected pixels
number_of_pixels = 500 ;
picture = bwareaopen(picture,number_of_pixels);
background=bwareaopen(picture,5000);
picture=picture-background;
subplot(3,2,5)
imshow(picture)
title('Clean Image')

%6)divide image into segments(letters and digits)
[picture,Ne]=bwlabel(picture);
subplot(3,2,6)
imshow(picture)
title('Segmentated Image')

%7)loading the dataset for letters and digits
load TRAININGSETPER;
totalLetters=size(TRAINPER,2);

figure
final_output=[];
for n=1:Ne
    [r,c]=find(picture==n);
    Y=picture(min(r):max(r),min(c):max(c));
    imshow(Y)
    Y=imresize(Y,[42,24]);
    imshow(Y)
    pause(0.2)

    ro=zeros(1,totalLetters);
    for k=1:totalLetters   
        ro(k)=corr2(TRAINPER{1,k},Y);
    end
    [MAXRO,pos]=max(ro);
    if MAXRO>.5
        out=cell2mat(TRAINPER(2,pos));       
        final_output=[final_output out];
    end
end

%8)writing the plate number into a text file
disp(final_output);
file = fopen('Number_Plate_2.txt', 'wt');
fprintf(file,'%s\n',final_output);
fclose(file);
winopen('Number_Plate_2.txt')