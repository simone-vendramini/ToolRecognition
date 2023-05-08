close all;
clear;

[images, labels] = readlists('../image_small.list', '../label_small.list');

features = cell(numel(images),1);

for i=1 : numel(images)
    im = imresize(imread(['../dataset/' images{i}]), 0.3);
    bw = segmentation(im, 13);
    bw = filter_label(bw, 2500);

    im_features = compute_features(bw);
    features{i} = im_features; 
end

cart = fitctree(features, labels);