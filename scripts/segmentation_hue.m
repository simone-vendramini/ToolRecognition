function out=segmentation_hue(im)
    T = get_thresh_hue(im);
    
    if T(1) > T(2)
        out = im < T(1) & im > T(2);
    else
        out = im < T(1) | im > T(2);
    end
    
%     se = strel('disk', 5);
%     out = imopen(bw, se);
end