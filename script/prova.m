close all;
clear;

im = imresize(imread("../image/foto2.png"), 0.3);

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


eulerian_number = bweuler(bw_m);




orStruct = regionprops(bw_m,'Orientation');
or = orStruct.Orientation;
im_oriented = imrotate(bw_m, 180-or);

subplot(1, 3, 3), imshow(im_oriented)
st=regionprops(im_oriented,'all');
points = st.BoundingBox;

element=imcrop(im_oriented, [points(1), points(2), points(3), points(4)]);


subplot(1, 3, 3), imshow(element)
% hold on
% rectangle('Position', [points(1), points(2), points(3), points(4)], 'EdgeColor','red','LineWidth',2)
% hold off