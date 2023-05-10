function out=segmentation(im, thresh)
    
    im_hsv = rgb2hsv(im);
    im_hsv_hue = im_hsv(:, :, 1);
    im_hsv_sat = im_hsv(:, :, 2);

    hist_sat = imhist(im_hsv_sat);

    max_sat = find(hist_sat == max(hist_sat));

    if max_sat < 250
        out = segmentation_hue(im_hsv_hue, thresh);
    else
        out = segmentation_saturation(im_hsv_sat);
    end
end