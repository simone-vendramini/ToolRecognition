function label=kmeans_detection(im)
    im_lab = rgb2lab(im);
  
    [L,Centers] = imsegkmeans(single(im_lab),2);
    cc = regionprops(L);
    if(cc(1).Area>cc(2).Area)            
        label = L == 2;
    else
        label = L == 1;
    end
    out = imclearborder(label);
    out = imfill(out,'holes');
    %mask=(activecontour(im,bw,100));
end