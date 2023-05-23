% close all;
clear;

im = imread('../dataset/213.jpg');
im_hsv = rgb2hsv(im);

sat_hist = imhist(im_hsv(:, :, 2));

T = compute_saturation_threshold(sat_hist);

bw_s = im_hsv(:, :, 2) < T(1) | im_hsv(:, :, 2) > T(2);
bw_v = im_hsv(:, :, 3) > 0.901 | im_hsv(:, :, 3) < 0.4;
bw_s_v = bw_s & bw_v;
lb = bwlabel(bw_s_v);
bw_s_v = imclearborder(lb, 8);
se = strel('disk', 10);
bw_s_v = imclose(bw_s_v, se);

bw_h = segmentation_hue(im_hsv(:, :, 1), 0);

bw = bw_s_v | bw_h;

figure();
subplot(1, 3, 1), imshow(bw_s_v);
subplot(1, 3, 2), imshow(bw_h);

bw = filter_label(bw, 3500);

subplot(1, 3, 3), imshow(bw);