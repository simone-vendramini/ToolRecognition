function out=segmentation_saturation(im)
    
    bw = im < 235/256;

    lb = bwlabel(bw);
    bw = imclearborder(lb, 8);
    
    se = strel('disk', 10);
    out = imclose(bw, se);

end
