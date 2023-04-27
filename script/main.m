close all;
clear;

im = imresize(imread("../image/foto1.png"), 0.3);

T = get_hue_threshold(im, 10);

im_hsv = rgb2hsv(im);

im_hsv_hue = im_hsv(:, :, 1);

if T(1) > T(2)
    bw = im_hsv_hue < T(1) & im_hsv_hue > T(2);
else
    bw = im_hsv_hue < T(1) | im_hsv_hue > T(2);
end

se = strel('disk', 7);

bw_m = imclose(bw, se);

labels = bwlabel(bw_m);

figure(1);
subplot(1, 3, 1), imshow(im);
subplot(1, 3, 2), imshow(bw_m);
subplot(1, 3, 3), imagesc(labels), axis image, colorbar;

eulerian_number = bweuler(bw_m);