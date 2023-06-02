function out = compute_features(bw)

    min_bbox = get_labels(bw);
    
    out=cell(length(min_bbox),1);

    for i = 1: size(min_bbox)
        props = regionprops(min_bbox{i}, 'all');
        proj = projections(min_bbox{i});
        hu = cell2mat(struct2cell(hu_moments(min_bbox{i})));

        % Prove
        % [row, cols] = size(min_bbox{i});
        
        % elem.area = props.Area;
        % elem.centroid = double(compute_centroid(min_bbox{i}, props(1).Centroid));
        % elem.euler = props.EulerNumber;
        % elem.biggest_hole = double(compute_biggest_hole(min_bbox{i}));
        % elem.FilledArea = props.FilledArea;
        % elem.EquivDiameter = props.EquivDiameter;
        % elem.convexArea = props.ConvexArea;

        % Ordine secondo features selection
        elem.axis = double(props(1).MajorAxisLength / props(1).MinorAxisLength);
        elem.sol = props.Solidity;
        elem.circ = props.Circularity;
        elem.Eccentricity = props.Eccentricity;
        elem.spread = compute_central_moments(min_bbox{i}, 0, 2) + compute_central_moments(min_bbox{i}, 2, 0); % Non invariante per scala
%         elem.projY = double(std(proj.y));
%         elem.ap = double(props(1).Area ./ (props(1).Perimeter)^2);
%         elem.fullness = compute_fullness(min_bbox{i});
%         elem.projX = double(std(proj.x));
        
        for j = 1: numel(hu)
            if j == 1 || j== 2
                fieldName = ['hu', num2str(j)]; 
                elem.(fieldName) = hu(j);
            end 
        end

%         elem.Extent = props.Extent;
        
        out{i} = elem;

    end
end