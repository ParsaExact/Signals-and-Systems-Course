function croppic = mycrop(full_picture)
    bluestrip=imread("bluestrip.png");

    pictureresized=imresize(full_picture,[NaN,800]);
    ratio=size(full_picture,1)/size(pictureresized,1);
    
    corr1=normxcorr2(bluestrip(:,:,1),pictureresized(:,:,1));
    corr2=normxcorr2(bluestrip(:,:,2),pictureresized(:,:,2));
    corr3=normxcorr2(bluestrip(:,:,3),pictureresized(:,:,3));
    corr=(corr1+corr2+corr3)/3;
    [corr_max,corrIdx]=max(abs(corr(:)));
    [peakY,peakX]=ind2sub(size(corr),corrIdx(1));
    corr_offset=[peakX-size(bluestrip,2),peakY-size(bluestrip,1)];
    bbox = [corr_offset(1),corr_offset(2),size(bluestrip,2),size(bluestrip,1)];
    bbox_full=[round((bbox(1)-10)*ratio),round((bbox(2)-10)*ratio),round((bbox(3)+2*10)*ratio),round((bbox(4)+2*10)*ratio)];
    bounding_box=bbox_full;
    bounding_box(3)=14*bbox(3)*ratio;
    
    croppic = imcrop(full_picture, bounding_box);
    imwrite(croppic, 'cropped_pic.jpg');
end
