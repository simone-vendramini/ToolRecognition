function out=segmentation_hue(im, thresh)

    T = get_hue_threshold(im, thresh);

    
    if T(1) > T(2)
        bw = im < T(1) & im > T(2);
    else
        bw = im < T(1) | im > T(2);
    end

    lb = bwlabel(bw);

    bw = imclearborder(lb, 8);
    
    se = strel('disk', 10);
    out = imclose(bw, se);
end

function out = get_hue_threshold(im, treshold)

    hist = imhist(im);

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