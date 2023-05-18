function out = compute_saturation_threshold(saturation_hist)
    tollerance = 0.005;

    max_value = max(saturation_hist);
    max_index = find(saturation_hist == max_value);

    logic_norm_hist = (saturation_hist ./ max_value) < tollerance;

    norm_hist_pos = find(logic_norm_hist == 0);

    T = 25;

    index = abs(norm_hist_pos - max_index) <= T;

    valori_intorno = norm_hist_pos(index);

    out = [valori_intorno(1), valori_intorno(end)] ./ 256;
end
