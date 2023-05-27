function out=segmentation_hue(im)
    T_der = get_thresh_hue(im);
    
    T_tol = get_hue_thresh(im);

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
    
    out = bw1 | bw2;
%     se = strel('disk', 5);
%     out = imopen(bw, se);
end