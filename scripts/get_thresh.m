function out = get_thresh(image)

    hist = imhist(image);
    hist = cat(1,hist,hist);

    max_index = find(hist==max(hist));
    local_min = islocalmin(hist);

    hist = movmean(hist, 3);

    min_diff = diff(hist);

    max_var = find(min_diff == max(min_diff));
    min_var = find(min_diff == min(min_diff));

%     local_min_pos = find(local_min == 1);

    if max_index(1) > 128
        T1 = max_var(1) - 5;
        T2 = min_var(1) + 5;
%         difference = abs(local_min_pos - max_index(1));
%         
%         index_closest = find(difference == min(difference));
%         if local_min_pos(index_closest) <= max_index(1)
%             T1 = local_min_pos(index_closest - 1);
%             T2 = local_min_pos(index_closest + 2);
%         else 
%             T1 = local_min_pos(index_closest - 2);
%             T2 = local_min_pos(index_closest + 1);
%         end
    else
%         difference = abs(local_min_pos - max_index(2));
%         
%         index_closest = find(difference == min(difference));
%         if local_min_pos(index_closest) <= max_index(2)
%             T1 = local_min_pos(index_closest - 1);
%             T2 = local_min_pos(index_closest + 2);
%         else 
%             T1 = local_min_pos(index_closest - 2);
%             T2 = local_min_pos(index_closest + 1);
%         end
        T1 = max_var(end) - 5;
        T2 = min_var(end) + 5;

        if T1 > 256
            T1 = T1 - 256;
        end
        if T2 > 256
            T2 = T2 - 256;
        end
    end

    out = [T1, T2] ./ 256;
end