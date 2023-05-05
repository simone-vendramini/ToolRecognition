close all;
clear;


im = imresize(imread("../dataset/foto_181.JPG"), 0.5);

T = get_hue_threshold(im, 11);

im_hsv = rgb2hsv(im);

im_hsv_hue = im_hsv(:, :, 1);

if T(1) > T(2)
    bw = im_hsv_hue < T(1) & im_hsv_hue > T(2);
else
    bw = im_hsv_hue < T(1) | im_hsv_hue > T(2);
end

lb = bwlabel(bw);
bw = imclearborder(lb, 8);

se = strel('disk', 5);

bw_m = imclose(bw, se);

bw_m = filter_label(bw_m, 100);

min_bbox = minimum_bounding_box(bw_m);
for i = 1: size(min_bbox)
    proj = projections(min_bbox{i});
    
    figure();
    subplot(1, 3, 1), imshow(im);
    subplot(1, 3, 2), imshow(bw_m);
    props = regionprops(min_bbox{i}, 'all');
    subplot(1, 3, 3), imshow(min_bbox{i}), axis equal;
    hold on;
    plot(props.Centroid(:,1),props.Centroid(:,2),'b*')
    hold off;
    
    figure();
    subplot(1, 2, 1), plot(proj.x);
    subplot(1, 2, 2), plot(proj.y);
    
    % Calcola la trasformata di distanza dell'immagine binaria
    dist_img = bwdist(~min_bbox{i});

    % Visualizza l'immagine di distanza
    imshow(dist_img, []);
    
    x = proj.x ./ max(proj.x);
    y = proj.y ./ max(proj.y);
    
    % Calcolo stats
    std_x = std(x);
    std_y = std(y);
    
    mean_x = mean(x);
    mean_y = mean(y);
end

out = hu_moments(min_bbox);



