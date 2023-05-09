function out = choose_segmentation(hist_hue, hist_sat)
    hist_hue = normalize_hist(hist_hue);
    hist_sat = normalize_hist(hist_sat);

    pks_hue = findpeaks(hist_hue, 'MinPeakDistance', 20, 'MinPeakHeight', 0.05);
    pks_sat = findpeaks(hist_sat, 'MinPeakDistance', 20, 'MinPeakHeight', 0.05);

    out = [pks_sat, pks_hue];
end

function out = normalize_hist(hist)
    max_value = max(hist);

    out = hist ./ max_value;
end