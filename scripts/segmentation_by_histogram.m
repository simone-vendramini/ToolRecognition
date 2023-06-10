function out=segmentation_by_histogram(im_channel)

    T = get_thresh(im_channel);

    out = im_channel < T(1) | im_channel > T(2);

end

function out = get_thresh(im_channel)
    hist = imhist(im_channel);

    hist = movmean(hist, 9);

    norm_hist = hist ./ max(hist);

    logic_norm_hist = norm_hist >= 0.01;

    label_hist = bwlabel(logic_norm_hist);
    max_val = find(norm_hist == max(norm_hist));
    max_label = label_hist(max_val(1));

    bw = label_hist ~= max_label;

    pos_min = find(bw == min(bw));
    T1 = pos_min(1);
    T2 = pos_min(end);

    out = [T1, T2] ./ 256;
end