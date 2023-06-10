function out = get_labels(bw)

    labels = bwlabel(bw);

    max_label = max(max(labels));
    elements = cell(max_label,1);
    
    for n = 1 : max_label
        element_n = (labels==n);

        element = element_n;

        se = strel('disk', 9);
        element = imclose(element, se);
        elements{n} = element;
        
    end
       out = elements;
end