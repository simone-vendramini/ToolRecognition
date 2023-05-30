function out = projections(element)
    orStruct = regionprops(element,'Orientation');
    or = orStruct.Orientation;
    im_oriented = imrotate(element, 180-or);

    minbbox = regionprops(im_oriented,'BoundingBox');
    element = imcrop(im_oriented, minbbox.BoundingBox);

    x = sum(element);
    y = sum(element.');

    if length(y) > length(x)
        temp = y;
        y = x;
        x = temp;
    end

    out.x = x;
    out.y = y;
end