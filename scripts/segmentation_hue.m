function out=segmentation_hue(im)
    T = get_thresh(im);
    
    if T(1) > T(2)
        bw = im < T(1) & im > T(2);
    else
        bw = im < T(1) | im > T(2);
    end

    lb = bwlabel(bw);

    bw = imclearborder(lb, 8);
    
    se = strel('disk', 10);
    out = imclose(bw, se);
end