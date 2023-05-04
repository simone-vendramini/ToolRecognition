function out=segmentation(im, thresh)

    T = get_hue_threshold(im, thresh);

    im_hsv = rgb2hsv(im);
    
    im_hsv_hue = im_hsv(:, :, 1);
    
    if T(1) > T(2)
        bw = im_hsv_hue < T(1) & im_hsv_hue > T(2);
    else
        bw = im_hsv_hue < T(1) | im_hsv_hue > T(2);
    end

    lb = bwlabel(bw);

    bw = imclearborder(lb, 8);
    
    se = strel('disk', 10);
    out = imclose(bw, se);
end