signal=zeros(1,1e4);
for i=1:1e3
    signal(i)=1;
end
t=zeros(1,10000);
for j=1:10000
    t(j)=j/1e9;
end
plot(t,signal)
