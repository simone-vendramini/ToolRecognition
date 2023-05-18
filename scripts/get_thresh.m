function out = get_thresh(image)

    hist = imhist(image);
    hist = cat(1,hist,hist);

    max_index = find(hist==max(hist));
    local_min = islocalmin(hist);
    
%     T1 = 0;
%     T2 = 0;
%     flag = 0;

    local_min_pos = find(local_min == 1);

    if max_index(1) > 128
        diff = abs(local_min_pos - max_index(1));
        
        index_closest = find(diff == min(diff));
        if local_min_pos(index_closest) <= max_index(1)
            T1 = local_min_pos(index_closest - 1);
            T2 = local_min_pos(index_closest + 2);
        else 
            T1 = local_min_pos(index_closest - 2);
            T2 = local_min_pos(index_closest + 1);
        end
        
%         for i = max_index(1) : -1 : 1
%             if TF(i) == 1
%                 if flag
%                     flag = 0;
%                     T1 = i;
%                     break
%                 else
%                     flag = 1;
%                 end
%             end
%         end
%         
%         for i = max_index(1) : 512
%              if TF(i) == 1
%                 if flag
%                     T2 = i;
%                     break
%                 else
%                     flag = 1;
%                 end
%             end
%         end
    else
        diff = abs(local_min_pos - max_index(2));
        
        index_closest = find(diff == min(diff));
        if local_min_pos(index_closest) <= max_index(2)
            T1 = local_min_pos(index_closest - 1);
            T2 = local_min_pos(index_closest + 2);
        else 
            T1 = local_min_pos(index_closest - 2);
            T2 = local_min_pos(index_closest + 1);
        end
        if T1 > 256
            T1 = T1 - 256;
        end
        if T2 > 256
            T2 = T2 - 256;
        end
%         for i = max_index(2) : -1 : 1
%              if TF(i) == 1
%                 if flag
%                     flag = 0;
%                     T1 = i - 256;
%                     break
%                 else
%                     flag = 1;
%                 end
%             end
%         end
%         for i = max_index(2) : 512
%             if TF(i) == 1
%                 if flag
%                     T2 = i - 256;
%                     break
%                 else
%                     flag = 1;
%                 end
%             end
%         end
    end


    
    out = [T1, T2] ./ 256;
end