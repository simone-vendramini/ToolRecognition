close all;
clear;

[images, labels] = readlists('../lists/images_single.list', '../lists/labels_single.list');

features = cell(numel(images),1);

for i=1 : numel(images)
    im = imresize(imread(['../dataset/' images{i}]), 0.3);
    im_hsv = rgb2hsv(im);

    bw = segmentation_black_and_white(im_hsv);
    bw_h = segmentation_hue(im_hsv(:,:,1),13);
    bw = filter_label(bw, 500);
    bw_h = filter_label(bw_h, 2500);

    bw = bw | bw_h;
    close all;

    figure();
    imshow(bw),title(['im ' int2str(i)]);

    im_features = compute_features(bw);

    features{i} = im_features;
    
    
end


