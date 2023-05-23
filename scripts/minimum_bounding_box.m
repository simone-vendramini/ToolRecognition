function out = minimum_bounding_box(bw)

    labels = bwlabel(bw);

    max_label = max(max(labels));
    elements = cell(max_label,1);
    
    for n = 1 : max_label
        element_n = (labels==n);

        orStruct = regionprops(element_n,'Orientation');
        or = orStruct.Orientation;
        im_oriented = imrotate(element_n, 180-or);
        st=regionprops(im_oriented,'all');
        points = st.BoundingBox;
        element = element_n;

        se = strel('disk', 9);
        element = imclose(element, se);
        elements{n} = element;
        
    end
       out = elements;
end