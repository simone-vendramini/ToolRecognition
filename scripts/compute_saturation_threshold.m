function out = compute_saturation_threshold(saturation_hist)
    tollerance = 0.005;

    max_value = max(saturation_hist);
    max_index = find(saturation_hist == max_value);

    logic_norm_hist = (saturation_hist ./ max_value) < tollerance;

    norm_hist_pos = find(logic_norm_hist == 0);

    norm_diff = diff(abs(norm_hist_pos - max_index));

    pos_min_diff = find(norm_diff == min(norm_diff));
    pos_max_diff = find(norm_diff == max(norm_diff));

    if isnumeric(pos_max_diff) && isvector(pos_max_diff)
        pos_max_diff = pos_max_diff(end);
    end

    if isnumeric(pos_max_diff) && isvector(pos_max_diff)
        pos_min_diff = pos_min_diff(1);
    end

    out = [norm_hist_pos(pos_min_diff), norm_hist_pos(pos_max_diff + 1)] ./ 256;
end
