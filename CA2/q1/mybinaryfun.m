%making the picture binary by using a threshold
%this function recieves a grayscale picture and returns the black and white
%picture
function bipic = mybinaryfun (pic,thresh)
    for i = 1:size(pic,1)
        for j = 1:size(pic,2)
            if pic(i,j) >= thresh
                bipic(i,j) = 1 ;
            else
                bipic(i,j) = 0 ;
            end
        end
    end
end
