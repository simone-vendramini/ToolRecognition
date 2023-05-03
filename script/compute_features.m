function out = compute_features(bw)

    out=[];

    min_bbox = minimum_bounding_box(bw);
    
    for i = 1: size(min_bbox)

        props = regionprops(min_bbox{i}, 'all');
        proj = projections(min_bbox{i});
        
        elem.area=props.Area;
        elem.centroid=props.Centroid;
        elem.euler=props.EulerNumber;
        elem.axis=props.MajorAxisLength/props.MinorAxisLength;


        out = [out; elem];

    end
end