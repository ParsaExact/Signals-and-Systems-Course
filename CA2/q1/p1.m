clc
close all;
clear;

%1)extracting Original image
[file,path]=uigetfile({'*.jpg;*.bmp;*.png;*.tif'},'Choose an image');
w=[path,file];
picture=imread(w);
figure
subplot(3,2,1)
imshow(picture)
title('Original Picture')

%2)resizing the image for better correlation
picture=imresize(picture,[300 500]);
subplot(3,2,2)
imshow(picture)
title('Resized Picture')

%3)making the image gray
picture=mygrayfun(picture);
subplot(3,2,3)
imshow(picture)
title('Grayscale Picture')

%4)making the image binary(black & white)
threshold = 90 ;
%the number for threshold is extracted by trying different numbers
picture=mybinaryfun(picture,threshold);
subplot(3,2,4)
imshow(picture)
title('Binary Picture')

%5)cleaning the image by using connected pixels
number_of_pixels = 250 ;
picture=myremovecom(picture,number_of_pixels);
subplot(3,2,5)
imshow(picture)
title('Clean Picture')

%6)divide image into segments(letters and digits)
[picture,Ne]=mysegmentation(picture);
subplot(3,2,6)
imshow(picture)
title('Segmented Picture')

%7)loading the dataset for letters and digits
load TRAININGSETENG;
all_letters=size(TRAIN,2);

figure
final_result=[];
for n=1:Ne
    [r,c]=find(picture==n);
    Y=picture(min(r):max(r),min(c):max(c));
    imshow(Y)
    Y=imresize(Y,[42,24]);
    imshow(Y)
    pause(0.2)

    ro=zeros(1,all_letters);
    for k=1:all_letters   
        ro(k)=corr2(TRAIN{1,k},Y);
    end
    %if (n == 7) 
    %       disp(ro)
    %end
    [MAXRO,pos]=max(ro);
    if MAXRO>.47
        out=cell2mat(TRAIN(2,pos));       
        final_result=[final_result out];
    end
end

%8)writing the plate number into a text file
disp(final_result);
file = fopen('Number_Plate_1.txt', 'wt');
fprintf(file,'%s\n',final_result);
fclose(file);
winopen('Number_Plate_1.txt')