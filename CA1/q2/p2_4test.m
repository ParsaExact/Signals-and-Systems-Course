load p2.mat
[h,m]=p2_4(x,y);
noise=0.1*randn(1,1001);
new_y=zeros(1,1001);
for i=1:1001
    new_y(i)=(h*x(i))+m+noise(i);
end
plot(x,new_y,'.')
grid on