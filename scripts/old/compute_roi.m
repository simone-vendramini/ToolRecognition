function out = compute_roi(bw, image)

    labels = bwlabel(bw);

    max_label = max(max(labels));
    elements = cell(max_label,1);
    
    for n = 1 : max_label
        element_n = (labels == n);

        st = regionprops(element_n,'all');

        points = st.BoundingBox;

        element = imcrop(image, [points(1), points(2), points(3), points(4)]);

        elements{n} = element;
    end
       out = elements;
end