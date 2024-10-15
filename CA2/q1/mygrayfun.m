%making the picture gray by the given formula
%this function recieves the colorfull picture and returns the gray picture
function graypic = mygrayfun (x)
    for i = 1:size(x,1)
        for j = 1:size(x,2)
            graypic(i,j) = (0.299*x(i,j,1)) + (0.578*x(i,j,2)) + (0.114*x(i,j,3)) ;
        end
    end
end
