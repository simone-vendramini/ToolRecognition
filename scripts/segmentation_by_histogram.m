function out=segmentation_by_histogram(im_channel)

    T = get_thresh(im_channel);

    out = im_channel < T(1) | im_channel > T(2);
%     
%     se = strel('disk', 10);
%     out = imclose(bw, se);

end

function out = get_thresh(im_channel)
    hist = imhist(im_channel);

    hist = movmean(hist, 9);

    first_der = diff(hist);
    max_der = [find(first_der == max(first_der)) find(first_der == min(first_der))];
    sign_der = find(sign(first_der(1:end-1)) >= 0 & sign(first_der(2:end)) <= 0);
    max_der = sort(max_der(1,:)', 'ascend');

    difference_1 = (max_der(1) - sign_der);
    no_negative_1 = difference_1 > 0;
    index = find(no_negative_1 == max(no_negative_1));

    T1 = sign_der(index(end));

    difference_2 = (sign_der - max_der(2));
    no_negative_2 = difference_2 > 0;
    index = find(no_negative_2 == max(no_negative_2));
    if max(no_negative_2) == 0
        T2 = 256;
    else
        T2 = sign_der(index(1));
    end
    out = [T1, T2] ./ 256;
end