function out = choose_segmentation(hist_hue, hist_sat)
    hist_hue = normalize_hist(hist_hue);
    hist_sat = normalize_hist(hist_sat);

    pks_hue = findpeaks(hist_hue, 'MinPeakDistance', 20, 'MinPeakHeight', 0.05);
    pks_sat = findpeaks(hist_sat, 'MinPeakDistance', 20, 'MinPeakHeight', 0.05);

    max_pk_hue = 0;
    max_pk_sat = 0;

    for i = 1: numel(pks_hue)
        if pks_hue(i) ~= 1
            if pks_hue(i) > max_pk_hue
                max_pk_hue = pks_hue(i);
            end
        end
    end

    for i = 1: numel(pks_sat)
        if pks_sat(i) ~= 1
            if pks_sat(i) > max_pk_sat
                max_pk_sat = pks_sat(i);
            end
        end
    end

    if max_pk_sat > max_pk_hue
        out = 1;
    elseif  max_pk_hue > max_pk_sat
        out = 2;
    else
        out = -1;
    end
end

function out = normalize_hist(hist)
    max_value = max(hist);
    out = hist ./ max_value;
end