function out=segmentation(im)

    T = get_hue_threshold(im, 11);

    im_hsv = rgb2hsv(im);
    
    im_hsv_hue = im_hsv(:, :, 1);
    
    if T(1) > T(2)
        bw = im_hsv_hue < T(1) & im_hsv_hue > T(2);
    else
        bw = im_hsv_hue < T(1) | im_hsv_hue > T(2);
    end
    
    se = strel('disk', 5);
    
    out = imclose(bw, se);

end