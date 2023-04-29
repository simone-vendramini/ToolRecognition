function out = filter_label(bw, treshold)

    labels = bwlabel(bw);
    max_label = max(max(labels));
    mask = zeros(size(bw));
    
    for n = 1 : max_label
      region_n = (labels==n);
      area_n = sum(sum(region_n));
      if (area_n>treshold)
         mask = mask | region_n;
      end
    end

    out = mask;
end