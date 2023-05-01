%regionprops va effettuata su labels e non sull'intera immagine bw
%l'out diventerà una lista di immagini bw dei singoli oggetti nella scena

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
        element = imcrop(im_oriented, [points(1), points(2), points(3), points(4)]);
        elements{n} = element;
        
    end
       out = elements;
end