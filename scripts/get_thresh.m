function out = get_thresh(image)

    hist = imhist(image);

    hist = cat(1,hist,hist);

    max_index = find(hist==max(hist));
    TF = islocalmin(hist);
    
    T1 = 0;
    T2 = 0;

    flag = 0;

    if max_index(1) > 128
        
        for i = max_index(1) : -1 : 1
            if TF(i) == 1
                if flag
                    flag = 0;
                    T1 = i;
                    break
                else
                    flag = 1;
                end
            end
        end
        
        for i = max_index(1) : 512
             if TF(i) == 1
                if flag
                    T2 = i;
                    break
                else
                    flag = 1;
                end
            end
        end
    else
        for i = max_index(2) : -1 : 1
             if TF(i) == 1
                if flag
                    flag = 0;
                    T1 = i - 256;
                    break
                else
                    flag = 1;
                end
            end
        end
        for i = max_index(2) : 512
            if TF(i) == 1
                if flag
                    T2 = i - 256;
                    break
                else
                    flag = 1;
                end
            end
        end
    end


    
    out = [T1, T2] ./ 256;
end