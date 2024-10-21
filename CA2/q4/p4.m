vidObj = VideoReader('car_plate.mp4');
timestamp = 1; % Example: Accessing the frame at 1 seconds
frame_number = round(vidObj.FrameRate * timestamp);
vidObj.CurrentTime = (frame_number - 1) / vidObj.FrameRate;
frame1 = readFrame(vidObj);
imshow(frame1);
imwrite(frame1, 'plate_frame.png');
timestamp = 1.5; % Example: Accessing the frame at 1 seconds
frame_number = round(vidObj.FrameRate * timestamp);
vidObj.CurrentTime = (frame_number - 1) / vidObj.FrameRate;
frame2 = readFrame(vidObj);
imshow(frame2);

gray1 = rgb2gray(frame1);
gray2 = rgb2gray(frame2);
points1 = detectSURFFeatures(gray1);
points2 = detectSURFFeatures(gray2);
[features1, validPoints1] = extractFeatures(gray1, points1);
[features2, validPoints2] = extractFeatures(gray2, points2);
indexPairs = matchFeatures(features1, features2);
matchedPoints1 = validPoints1(indexPairs(:, 1), :);
matchedPoints2 = validPoints2(indexPairs(:, 2), :);
displacements = matchedPoints2.Location - matchedPoints1.Location;
averageDisplacement = mean(sqrt(sum(displacements.^2, 2)));
timeInterval = 0.5; % Time difference between frames, adjust as needed
velocity = averageDisplacement / timeInterval;
disp(['Velocity: ', num2str(velocity), ' pixels per second']);

%clc
%close all;
%clear;

%1
[file,path]=uigetfile({'*.jpg;*.bmp;*.png;*.tif'},'Choose an image');
s=[path,file];
frame1=imread(s);
figure
subplot(3,3,1)
imshow(frame1)
title('Original Image')

%2
mycrop(frame1);
frame1=imread("cropped_pic.jpg");
subplot(3,3,2)
imshow(frame1)
title('Cropped Image')

%3
frame1=imresize(frame1,[300 500]);
subplot(3,3,3)
imshow(frame1)
title('Resized Image')


%4
frame1=rgb2gray(frame1);
subplot(3,3,4)
imshow(frame1)
title('Grayscal Image')

%5
threshold = graythresh(frame1);
frame1 =~imbinarize(frame1,threshold);
subplot(3,3,5)
imshow(frame1)
title('Binary Image')

%6
number_of_pixels=700;
frame1 = bwareaopen(frame1,number_of_pixels);
background=bwareaopen(frame1,5500);
frame1=frame1-background;
subplot(3,3,6)
imshow(frame1)
title('Clean Image')

%7
[frame1,Ne]=bwlabel(frame1);
subplot(3,3,8)
imshow(frame1)
title('Segmentated Image')

%8
load TRAININGSETPER;
totalLetters=size(TRAINPER,2);

figure
final_output=[];
for n=1:Ne
    [r,c]=find(frame1==n);
    Y=frame1(min(r):max(r),min(c):max(c));
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

%9
disp(final_output);
file = fopen('Number_Plate_3.txt', 'wt');
fprintf(file,'%s\n',final_output);
fclose(file);
winopen('Number_Plate_3.txt')
