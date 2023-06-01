close all;
clear;

im = imresize(imread("../dataset_v2/071.JPG"), 0.5);

im_hsv = rgb2hsv(im);

im_bin_hue = imbinarize(im_hsv(:, :, 1), 'adaptive');
im_bin_sat = imbinarize(im_hsv(:, :, 2), 'adaptive');

bw = segmentation(im, 13);

bw = filter_label(bw, 2500);

objs = compute_roi(bw, im_hsv);

for i = 1:numel(objs)
    hue = objs{i}(:, :, 1);
    sat = objs{i}(:, :, 2);

    hist_hue = imhist(hue);
    hist_sat = imhist(sat);

    figure();
    subplot(2, 2, 1), imshow(hue), title('hue');
    subplot(2, 2, 2), plot(hist_hue), title('hue hist');
    subplot(2, 2, 3), imshow(sat), title('sat');
    subplot(2, 2, 4), plot(hist_sat), title('sat hist');

    bin = imbinarize(sat);
    bin_hue = segmentation_hue(hue, 15);

    figure();
    subplot(1, 2, 1), imshow(bin_hue), title('hue');
    subplot(1, 2, 2), imshow(bin), title('sat');
    code = choose_segmentation(hist_hue, hist_sat);
% 
%     figure();
%     subplot(1, 3, 1), imshow(im);
% 
%     if code == 1
%         subplot(1, 3, 2), imshow(sat), title("saturation");
%         % T = graythresh(sat);
%         % bw2 = 1 - imbinarize(sat, T);
%         bw2 = segmentation_saturation(sat);
%     elseif code == 2
%         subplot(1, 3, 2), imshow(hue), title("hue");
%         T = graythresh(hue);
%         bw2 = 1 - imbinarize(hue, T);
%     else
%         %caso in cui non vanno bene entrambi
%     end
%     
%     subplot(1, 3, 3), imshow(bw2);
end

figure();
subplot(1, 2, 1), imshow(im_bin_hue), title('hue');
subplot(1, 2, 2), imshow(im_bin_sat), title('sat');

% figure();
% subplot(1, 2, 1), imshow(im_hsv(:, :, 1));
% subplot(1, 2, 2), imshow(bw);



