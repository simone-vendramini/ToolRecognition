function out = get_hue_threshold(image, treshold)
    im = rgb2hsv(image);
    hist = imhist(im(:, :, 1));

    max_value = max(hist);
    max_index = find(hist == max_value);

    if (max_index - treshold) < 1
       out = [256 + max_index - treshold max_index + treshold] ./ 256;
    elseif max_index + treshold > 256
       out = [max_index - treshold, max_index - 256 + treshold] ./ 256;
    else 
       out = [max_index - treshold, max_index + treshold] ./ 256;
    end
end