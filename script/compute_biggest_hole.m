function out = compute_biggest_hole(bw)

    bw = 1-bw;
    lb = bwlabel(bw);

    bw = imclearborder(lb, 8);

    lb = bwlabel(bw);

    max_label = max(max(lb));

    out=0;

    for i=1 : max_label

        region_n = (lb==i);
        props = regionprops(region_n, 'all');

        if props.Area > out
            out = props.Area;
        end

    end

end