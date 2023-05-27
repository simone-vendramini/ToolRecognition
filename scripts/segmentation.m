function out=segmentation(im)

    se = strel('disk', 5);

    im_hsv = rgb2hsv(im);

    im_hsv_hue = im_hsv(:, :, 1);
    im_hsv_sat = im_hsv(:, :, 2);

    bw_bw = segmentation_black_and_white(im_hsv);

    bw_h = segmentation_hue(im_hsv_hue);
    %bw_h = segmentation_by_histogram(im_hsv_hue);

    bw_s = segmentation_by_histogram(im_hsv_sat);
    bw_s = imclearborder(bw_s, 8);
    
    bw_s = imopen(bw_s, se);

    bw = bw_bw | bw_h | bw_s;

    bw = imclearborder(bw, 8);
 
    bw = filter_label(bw, 2000);

    out = imclose(bw, se);

end