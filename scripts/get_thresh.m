function out = get_thresh(image)
    tolerance = 0.005;
    hist = imhist(image);

    max_value = max(hist);
    norm_hist = hist ./ max_value;
    
    T1 = 0;
    T2 = 0;

    logic_hist = norm_hist < tolerance;

    for i = 1: size(logic_hist) - 1
        if logic_hist(i) == 0
            if i == 1
                T1 = -1;
            else
                if logic_hist(i + 1) == 1
                    T2 = i + 1;
                end

                if logic_hist(i - 1) == 1
                    T1 = i - 1;
                end
            end
        end
    end
    out = [T1, T2] ./ 256;
end