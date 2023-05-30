function out = get_th_hue_tol(im_channel)
    
    hist = imhist(im_channel);
    hist = cat(1,hist,hist);
    hist = movmean(hist, 9);
    hist(1) = hist(257);
    hist(2) = hist(258);
    hist(3) = hist(259);
    hist(4) = hist(260);
    hist(end-3) = hist(253);
    hist(end-2) = hist(254);
    hist(end-1) = hist(255);
    hist(end) = hist(256);
    norm_hist = hist ./ max(hist);

    logic_norm_hist = norm_hist >= 0.03;

    label_hist = bwlabel(logic_norm_hist);
    max_val = find(norm_hist == max(norm_hist));

    if max_val(1) > 128
        max_label = label_hist(max_val(1));
    else
        max_label = label_hist(max_val(2));
    end
    

    bw = label_hist ~= max_label;

    pos_min = find(bw == min(bw));
    T1 = pos_min(1);
    T2 = pos_min(end);

    if T1 > 256
            T1 = T1 - 256;
    end
    if T2 > 256
        T2 = T2 - 256;
    end

    out = [T1, T2] ./ 256;
end