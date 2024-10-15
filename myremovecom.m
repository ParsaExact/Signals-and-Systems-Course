%cleaning the picture by removing the extra parts of plate
%this function recieves a binary picture and a number (n) and returns the
%cleaned picture
function cleanpic = myremovecom (pic,thresh)
    pic = ~pic ;
    B=strel('square',3); 
    A=pic; 
    p=find(A==1); 
    p=p(1); 
    segpic=zeros([size(A,1) size(A,2)]);
    N=0; 
    while(~isempty(p)) 
        N=N+1; 
        p=p(1); 
        X=false([size(A,1) size(A,2)]); 
        X(p)=1; 
        Y=A&imdilate(X,B); 
        while(~isequal(X,Y)) 
            X=Y; 
            Y=A&imdilate(X,B); 
        end
        Pos=find(Y==1); 
        A(Pos)=0;  
        segpic(Pos)=N; 
        p=find(A==1); 
    end
    componentAreas = zeros(1,N);
    for label = 1:N
        componentAreas(label) = sum(segpic(:) == label);
    end
    validLabels = find(componentAreas >= thresh);
    cleanpic = ismember(segpic, validLabels);
end