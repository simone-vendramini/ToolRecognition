close all;
clear;


im = imresize(imread("../dataset/foto_331.JPG"), 0.5);

G21=fspecial("gaussian",21,4);
F5=fspecial("average", 30);

im_hsv = rgb2hsv(im);
im_hsv_hue = im_hsv(:, :, 1);


im=imfilter(im_hsv_hue,F5);

bw = segmentation_hue(im, 13);

bw = filter_label(bw, 2500);

figure();
subplot(1, 2, 1), imshow(im_hsv_hue);
subplot(1, 2, 2), imshow(bw);

% min_bbox = minimum_bounding_box(bw_m);
% for i = 1: size(min_bbox)
%     proj = projections(min_bbox{i});
%     
%     figure();
%     subplot(1, 3, 1), imshow(im);
%     subplot(1, 3, 2), imshow(bw_m);
%     props = regionprops(min_bbox{i}, 'all');
%     subplot(1, 3, 3), imshow(min_bbox{i}), axis equal;
%     hold on;
%     plot(props.Centroid(:,1),props.Centroid(:,2),'b*')
%     hold off;
%     
%     figure();
%     subplot(1, 2, 1), plot(proj.x);
%     subplot(1, 2, 2), plot(proj.y);
%     
%     % Calcola la trasformata di distanza dell'immagine binaria
%     dist_img = bwdist(~min_bbox{i});
% 
%     % Visualizza l'immagine di distanza
%     imshow(dist_img, []);
%     
%     x = proj.x ./ max(proj.x);
%     y = proj.y ./ max(proj.y);
%     
%     % Calcolo stats
%     std_x = std(x);
%     std_y = std(y);
%     
%     mean_x = mean(x);
%     mean_y = mean(y);
% end
% 
% out = hu_moments(min_bbox);



