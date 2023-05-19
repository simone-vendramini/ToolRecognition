close all;
clear;

[images, labels] = readlists('../lists/images_multiple.list', '../lists/labels_multiple.list');

for i=1 : numel(images)
    im = imresize(imread(['../dataset/' images{i}]), 0.3);
    im_hsv = rgb2hsv(im);

    bw = segmentation_black_and_white(im_hsv);
    bw_h = segmentation_hue(im_hsv(:,:,1),13);
    bw = filter_label(bw, 500);
    bw_h = filter_label(bw_h, 2500);

    bw = bw | bw_h;

    figure();
    imshow(bw),title(['im ' int2str(i)]);    
end