function out = segmentation_black_and_white(image_hsv)
    s = image_hsv(:,:,2);
    v = image_hsv(:,:,3);

    bw_s = s < 0.374;
    bw_v = v > 0.901 | v < 0.4;
    bw = bw_s & bw_v;

    lb = bwlabel(bw);
    bw = imclearborder(lb, 8);
    
    se = strel('disk', 10);
    out = imclose(bw, se);

end