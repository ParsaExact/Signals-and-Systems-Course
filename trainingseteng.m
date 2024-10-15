%loading the english digits and leters dataset
files=dir('Map Set English\');
len=length(files)-2;
TRAIN=cell(2,len);

for i=1:len
   TRAIN{1,i}=imread(['Map Set English','\',files(i+2).name]);
   TRAIN{2,i}=files(i+2).name(1);
end

save('TRAININGSETENG.mat','TRAIN');