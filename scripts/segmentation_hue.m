function out=segmentation_hue(im)
    T_der = get_th_hue_der(im);
    
    T_tol = get_th_hue_tol(im);

    if T_der(1) > T_der(2)
        bw1 = im < T_der(1) & im > T_der(2);
    else
        bw1 = im < T_der(1) | im > T_der(2);
    end

    if T_tol(1) > T_tol(2)
        bw2 = im < T_tol(1) & im > T_tol(2);
    else
        bw2 = im < T_tol(1) | im > T_tol(2);
    end
    
    se = strel('disk', 3);
    bw2 = imopen(bw2, se);

    out = bw1 | bw2;
    
end