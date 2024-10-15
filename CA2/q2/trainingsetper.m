files=dir('Map Set Persian\');
len=length(files)-2;
TRAINPER=cell(2,len);

for i=1:len
    threshold = graythresh(double(imread(['Map Set Persian','\',files(i+2).name])));
    TRAINPER{1,i}=imbinarize(double(imresize(imread(['Map Set Persian','\',files(i+2).name]),[42,24])),threshold);
    TRAINPER{2,i}=files(i+2).name(1);
end

save('TRAININGSETPER.mat','TRAINPER');

