%regionprops va effettuata su labels e non sull'intera immagine bw
%l'out diventerà una lista di immagini bw dei singoli oggetti nella scena

function out = minimum_bounding_box(image)
    orStruct = regionprops(image,'Orientation');
    or = orStruct.Orientation;
    im_oriented = imrotate(image, 180-or);
    
    st=regionprops(im_oriented,'all');
    points = st.BoundingBox;

    element = imcrop(im_oriented, [points(1), points(2), points(3), points(4)]);

    out = element;
end