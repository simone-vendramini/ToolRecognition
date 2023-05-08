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

bw_m  = filter_label(bw_m, 1000); 

min_bbox = minimum_bounding_box(bw_m);
proj = projections(min_bbox);

figure(3);
subplot(1, 3, 1), imshow(im);
subplot(1, 3, 2), imshow(bw_m);
subplot(1, 3, 3), imshow(min_bbox), axis equal;
eulerian_number = bweuler(bw_m);

figure(4);
subplot(1, 2, 1), plot(proj.x);
subplot(1, 2, 2), plot(proj.y);
x = proj.x ./ max(proj.x);
y = proj.y ./ max(proj.y);

% Calcolo stats
std_x = std(x);
std_y = std(y);

mean_x = mean(x);
mean_y = mean(y);