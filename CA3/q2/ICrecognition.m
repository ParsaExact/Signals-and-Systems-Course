function marked_image = ICrecognition (IC_image,PCB_image)
    %calculating correlation for three colors
    corr1 = normxcorr2(IC_image(:,:,1),PCB_image(:,:,1)) ;
    corr2 = normxcorr2(IC_image(:,:,2),PCB_image(:,:,2)) ;
    corr3 = normxcorr2(IC_image(:,:,3),PCB_image(:,:,3)) ;
    corr = (corr1+corr2+corr3)/3 ;
    corrIdx = find(abs(corr(:))>0.6) ;
    figure
    imshow("PCB.jpg") ;
    hold on ;
    % showing the IC by a blue rectangle
    for i=1:length(corrIdx) 
        [peakY,peakX] = ind2sub(size(corr),corrIdx(i)) ;
        corr_offset = [peakX-size(IC_image,2),peakY-size(IC_image,1)] ;
        bbox = [corr_offset(1),corr_offset(2),size(IC_image,2),size(IC_image,1)] ;
        rectangle('Position',bbox,'EdgeColor','b') ;
        hold on ;
    end
    %calculating correlation for rotated image
    rotated_ic = imrotate(IC_image,180) ;
    corr1 = normxcorr2(rotated_ic(:,:,1),PCB_image(:,:,1)) ;
    corr2 = normxcorr2(rotated_ic(:,:,2),PCB_image(:,:,2)) ;
    corr3 = normxcorr2(rotated_ic(:,:,3),PCB_image(:,:,3)) ;
    corr = (corr1+corr2+corr3)/3 ;
    corrIdx = find(abs(corr(:))>0.6) ;
    %showing the rotated IC by a blue rectangle
    for i=1:length(corrIdx) 
        [peakY,peakX] = ind2sub(size(corr),corrIdx(i)) ;
        corr_offset = [peakX-size(IC_image,2),peakY-size(IC_image,1)] ;
        bbox = [corr_offset(1),corr_offset(2),size(IC_image,2),size(IC_image,1)] ;
        rectangle('Position',bbox,'EdgeColor','b') ;
        hold on ;
    end
end