function out = get_sat_threshold(image, treshold)

    hist = imhist(image);
    max_value = max(hist);
    max_index = find(hist == max_value);
    out = [max_index - treshold, max_index + treshold] ./ 256;

end