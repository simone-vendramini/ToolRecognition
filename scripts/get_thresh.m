function out = get_thresh(image)
    hist = imhist(image);
    hist = cat(1,hist,hist);

    tmp1=(hist(1)+hist(2)+hist(end))/3;

    tmp_end=(hist(1)+hist(end-1)+hist(end))/3;

    hist = movmean(hist, 3);

    hist(1) = tmp1;
    hist(end) = tmp_end;
    
    
    % Calcolo derivate
    first_der = diff(hist);

    % Troviamo i massimi
    max_index = find(hist==max(hist));    

    % Troviamo i massimi della derivata seconda
    max_second_der = [find(first_der == max(first_der)) find(first_der == min(first_der))];

    sign_der = find(sign(first_der(1:end-1)) >= 0 & sign(first_der(2:end)) <= 0);

    if max_index(1) > 128
        max_second_der = sort(max_second_der(1,:)', 'ascend');

        difference_1 = (max_second_der(1) - sign_der);
        no_negative_1 = difference_1 > 0;
        index = find(no_negative_1 == max(no_negative_1));
        T1 = sign_der(index(end));

        difference_2 = (sign_der - max_second_der(2));
        no_negative_2 = difference_2 > 0;
        index = find(no_negative_2 == max(no_negative_2));
        T2 = sign_der(index(1));
    else
        max_second_der = sort(max_second_der(2,:)', 'ascend');

        difference_1 = (max_second_der(1) - sign_der);
        no_negative_1 = difference_1 > 0;
        index = find(no_negative_1 == max(no_negative_1));
        T1 = sign_der(index(end));

        difference_2 = (sign_der - max_second_der(2));
        no_negative_2 = difference_2 > 0;
        index = find(no_negative_2 == max(no_negative_2));
        T2 = sign_der(index(1));

        if T1 > 256
            T1 = T1 - 256;
        end
        if T2 > 256
            T2 = T2 - 256;
        end
    end


    out = [T1, T2] ./ 256;
end