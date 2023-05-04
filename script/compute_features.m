function out = compute_features(bw)

    min_bbox = minimum_bounding_box(bw);
    
    out=cell(length(min_bbox),1);

    for i = 1: size(min_bbox)

        props = regionprops(min_bbox{i}, 'all');
        proj = projections(min_bbox{i});
        
        elem.area = props.Area;
        elem.centroid = props.Centroid;
        elem.euler = props.EulerNumber;
        elem.axis = props(1).MajorAxisLength / props(1).MinorAxisLength;
        elem.fullness = (length(min_bbox{i}) * width(min_bbox{i}) - elem.area) / elem.area;
        elem.biggest_hole = compute_biggest_hole(min_bbox{i});
        

        out{i} = elem;

    end
end