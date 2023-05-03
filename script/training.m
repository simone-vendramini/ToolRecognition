close all;
clear;

[images, labels] = readlists('../image_tinta.list', '../label_tinta.list');

features = [];
%zeros(numel(images), 7);

for i=1 : numel(images)
    
    im = imresize(imread(['../dataset/' images{i}]), 0.5);

    bw = segmentation(im);

    im_features = compute_features(bw);

    features = [features; im_features];
    
end