function out=segmentation(im)

    im_hsv = rgb2hsv(im);

    im_hsv_hue = im_hsv(:, :, 1);
    % im_hsv_sat = im_hsv(:, :, 2);

    bw_bw = segmentation_black_and_white(im_hsv);

    bw_bw = filter_label(bw_bw, 700);

    bw_h = segmentation_hue(im_hsv_hue);

    bw = bw_bw | bw_h;

    % bw_s = segmentation_saturation(im_hsv_sat);

    % bw = bw | bw_s;

    out = filter_label(bw, 2000);
end