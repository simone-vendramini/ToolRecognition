function out=segmentation(im, thresh)
    
    im_hsv = rgb2hsv(im);
    im_hsv_hue = im_hsv(:, :, 1);
    im_hsv_sat = im_hsv(:, :, 2);

    hist_sat = imhist(im_hsv_sat);

    max_sat = find(hist_sat == max(hist_sat));

    bw = segmentation_black_and_white(im_hsv);
    bw = filter_label(bw, 500);

    %if max_sat < 250

        bw_h_s = segmentation_hue(im_hsv_hue, thresh);
        bw_h_s = filter_label(bw_h_s, 2500);

%     else
%         bw_h_s = segmentation_saturation(im_hsv_sat, thresh);
%     end

    out = bw | bw_h_s;
end