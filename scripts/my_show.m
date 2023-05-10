close all;
clear;

im_rgb = imread('../dataset_v2/130.JPG');
% im_rgb = imread('../pinza.jpg');
im = rgb2hsv(im_rgb);
figure();
subplot(1, 3, 1), imshow(im(:, :, 1));
subplot(1, 3, 2), imshow(im(:, :, 2));
subplot(1, 3, 3), imshow(im_rgb);

hist_sat = imhist(im(:, :, 2));
mean_sat = mean(hist_sat);
std_sat = std(hist_sat);

figure();
subplot(1, 2, 1), plot(imhist(im(:, :, 1)));
subplot(1, 2, 2), plot(imhist(im(:, :, 2)));

line([0 255], [mean_sat mean_sat], 'LineWidth', 1, 'Color', 'r');

T = graythresh(im(:,:, 2));

bw = imbinarize(im(:, :, 2), T);

figure(), imshow(1 - bw);