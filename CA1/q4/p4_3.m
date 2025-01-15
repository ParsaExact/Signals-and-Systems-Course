function x=p4_3(x,speed)
Fs=48000;
len=length(x);
if speed==2
    x_filtered = zeros(1, round(0.5 * len));
    x_filtered = x(1:2:len);
    sound(x_filtered,Fs);
elseif speed==0.5
    r=zeros(2*len,2);
    for i=1:(len)
        j=i;
        r(2*j,:)=x(i,:);
    end
    for k=1:len-1
        r(2*k+1,1)=(r(2*k,1)+r(2*k+2,1))/2;
        r(2*k+1,2)=(r(2*k,2)+r(2*k+2,2))/2;
    end
    x=r;
    sound(x,Fs);
else 
    x=('error');
end
end