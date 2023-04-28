close all;
clear;

im1 = imresize(imread("../image/foto1.png"), 0.3);
im2 = imresize(imread("../image/foto4.png"), 0.3);

T1 = get_hue_threshold(im1, 10);
T2 = get_hue_threshold(im2, 10);

im_hsv_1 = rgb2hsv(im1);
im_hsv_2 = rgb2hsv(im2);

im_hsv_hue_1 = im_hsv_1(:, :, 1);
im_hsv_hue_2 = im_hsv_2(:, :, 1);

if T1(1) > T1(2)
    bw_1 = im_hsv_hue_1 < T1(1) & im_hsv_hue_1 > T1(2);
else
    bw_1 = im_hsv_hue_1 < T1(1) | im_hsv_hue_1 > T1(2);
end

if T2(1) > T2(2)
    bw_2 = im_hsv_hue_2 < T2(1) & im_hsv_hue_2 > T2(2);
else
    bw_2 = im_hsv_hue_2 < T2(1) | im_hsv_hue_2 > T2(2);
end

se = strel('disk', 7);

bw_m_1 = imclose(bw_1, se);
bw_m_2 = imclose(bw_2, se);


min_bbox_1 = minimum_bounding_box(bw_m_1);
proj_1  = projections(min_bbox_1);

min_bbox_2 = minimum_bounding_box(bw_m_2);
proj_2  = projections(min_bbox_2);

diff.x = proj_1.x - proj_2.x;
diff.y = proj_1.y - proj_2.y;

% figure(1);
% subplot(1, , 1), plot(proj.x);
% subplot(1, 2, 2), plot(proj.y);


x = proj.x ./ max(proj.x);
y = proj.y ./ max(proj.y);

% Calcolo stats
std_x = std(x);
std_y = std(y);

mean_x = mean(x);
mean_y = mean(y);

