clear;

im = imresize(imread("../image/foto5.png"), 0.3);

T = get_rgb_thresh(im, 10);

R = im(:, :, 1);
G = im(:, :, 2);
B = im(:, :, 3);

bw = (R < T.R(1) | R > T.R(2)) & (G < T.G(1) | G > T.G(2)) & (B < T.B(1) | B > T.B(2));

figure(1);
imshow(bw);
% se = strel('disk', 7);
% 
% bw_m = imclose(bw, se);
% 
% labels = bwlabel(bw_m);
% 
% min_bbox = minimum_bounding_box(bw_m);
% proj = projections(min_bbox);
% 
% figure(3);
% subplot(1, 3, 1), imshow(im);
% subplot(1, 3, 2), imshow(bw_m);
% subplot(1, 3, 3), imshow(min_bbox), axis equal;
% eulerian_number = bweuler(bw_m);
% 
% figure(4);
% subplot(1, 2, 1), plot(proj.x);
% subplot(1, 2, 2), plot(proj.y);
% x = proj.x ./ max(proj.x);
% y = proj.y ./ max(proj.y);
% 
% % Calcolo stats
% std_x = std(x);
% std_y = std(y);
% 
% mean_x = mean(x);
% mean_y = mean(y);