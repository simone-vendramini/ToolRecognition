function out=edge_segmentation(im)
    im_lab = rgb2lab(im);
    se = strel('disk', 5);
    edge_mask_A =edge(im_lab(:,:,2),"Canny",.5);
    edge_mask_B =edge(im_lab(:,:,3),"Canny",.5);
    edge_mask_united = edge_mask_A | edge_mask_B;
    iterations = 100;
    out = activecontour(im_lab, edge_mask_united, iterations, 'Chan-Vese');
    out = imclose(out,se);
end