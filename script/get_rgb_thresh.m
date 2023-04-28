function out = get_rgb_thresh(im, treshold)
    R = imhist(im(:, :, 1));
    G = imhist(im(:, :, 2));
    B = imhist(im(:, :, 3));

    max_R = find(R == max(R));
    max_G = find(G == max(G));
    max_B = find(B == max(B));

    out.R = [max_R - treshold, max_R + treshold];
    out.G = [max_G - treshold, max_G + treshold];
    out.B = [max_B - treshold, max_B + treshold];

end