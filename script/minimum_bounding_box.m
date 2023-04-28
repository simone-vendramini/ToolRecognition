function out = minimum_bounding_box(image)
    orStruct = regionprops(image,'Orientation');
    or = orStruct.Orientation;
    im_oriented = imrotate(image, 180-or);
    
    st=regionprops(im_oriented,'all');
    points = st.BoundingBox;

    element = imcrop(im_oriented, [points(1), points(2), points(3), points(4)]);

    out = element;
end