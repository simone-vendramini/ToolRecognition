close all;
clear;

im = imresize(imread("../dataset_v2/079.JPG"), 0.5);

im_hsv = rgb2hsv(im);

bw = segmentation(im, 13);

bw = filter_label(bw, 2500);

objs = compute_roi(bw, im_hsv);

for i = 1:numel(objs)
    hue = objs{i}(:, :, 1);
    sat = objs{i}(:, :, 2);

    hist_hue = imhist(hue);
    hist_sat = imhist(sat);

    code = choose_segmentation(hist_hue, hist_sat);
    % Scegliamo la segmentazione in base al codice
%     T = graythresh(objs{i}(:, :, 2));
% 
%     bw = imbinarize(objs{i}(:, :, 2), T);
end

figure();
subplot(1, 2, 1), imshow(im_hsv(:, :, 1));
subplot(1, 2, 2), imshow(bw);



