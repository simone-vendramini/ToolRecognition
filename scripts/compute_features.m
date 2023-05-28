function out = compute_features(bw)

    min_bbox = minimum_bounding_box(bw);
    
    out=cell(length(min_bbox),1);

    for i = 1: size(min_bbox)
        props = regionprops(min_bbox{i}, 'all');
        proj = projections(min_bbox{i});

        [row, cols] = size(min_bbox{i});
        
        % elem.area = props.Area;
        elem.centroid = double(compute_centroid(min_bbox{i}, props(1).Centroid));
        % elem.euler = props.EulerNumber;
        elem.axis = double(props(1).MajorAxisLength / props(1).MinorAxisLength);
        % elem.fullness = double(((row * cols) - props(1).Area) ./ props(1).Area);
        % elem.biggest_hole = double(compute_biggest_hole(min_bbox{i}));
        
        % Prova descrittori
        hu = cell2mat(struct2cell(hu_moments(min_bbox{i})));
        for j = 1: numel(hu)
            fieldName = ['hu', num2str(j)]; 
            elem.(fieldName) = hu(j);  
        end
        elem.projX = double(std(proj.x));
        elem.projY = double(std(proj.y));
        % elem.ap = double(props(1).Area ./ (props(1).Perimeter)^2);
        elem.circ = props.Circularity;
        % elem.convexArea = props.ConvexArea;
        elem.Eccentricity = props.Eccentricity;
        % elem.EquivDiameter = props.EquivDiameter;
        elem.Extent = props.Extent;
        % elem.FilledArea = props.FilledArea;
        elem.sol = props.Solidity;
        % elem.rect = props.Area / (props.BoundingBox(3) * props.BoundingBox(4));
        % elem.spread = M02 + M20
        
        out{i} = elem;

    end
end