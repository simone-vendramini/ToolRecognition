function out = compute_fullness(image)
    orientation_struct = regionprops(image,'Orientation');
    im_oriented = imrotate(image, (180 - orientation_struct.Orientation));

    minbbox = regionprops(im_oriented,'BoundingBox', 'Area');
    [row, cols] = size(minbbox(1).BoundingBox);
    out = double(((row * cols) - minbbox(1).Area) ./ minbbox(1).Area);
end