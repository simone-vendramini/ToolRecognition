function out = compute_features(bw)

    min_bbox = minimum_bounding_box(bw);
    
    out=cell(length(min_bbox),1);

    for i = 1: size(min_bbox)
        props = regionprops(min_bbox{i}, 'all');
        proj = projections(min_bbox{i});

        [row, cols] = size(min_bbox{i});
        
        elem.area = props.Area;
        elem.centroid = props.Centroid; % Da convertire in numero
        elem.euler = props.EulerNumber;
        elem.axis = props(1).MajorAxisLength / props(1).MinorAxisLength;
        elem.fullness = ((row * cols) - elem.area) ./ elem.area;
        elem.biggest_hole = compute_biggest_hole(min_bbox{i});
        
        % Prova descrittori
        elem.hu = hu_moments(min_bbox{i}); % Da convertire in valori singoli
        elem.proj = std(proj.x);
        elem.ap = props(1).Area ./ props(1).Perimeter;
        elem.circ = props.Circularity;

        elem.sol = props.Solidity;
        out{i} = elem;

    end
end