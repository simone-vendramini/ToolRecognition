function out=segmentation_saturation(im)
    
    bw = im <  0.7 ;

    lb = bwlabel(bw);
    bw = imclearborder(lb, 8);
    
    se = strel('disk', 10);
    out = imclose(bw, se);

end
