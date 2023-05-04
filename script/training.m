close all;
clear;

[images, labels] = readlists('../image_tinta.list', '../label_tinta.list');

features = cell(numel(images),1);
%zeros(numel(images), 7);

for i=1 : numel(images)
    
    im = imresize(imread(['../dataset/' images{i}]), 0.3);

    bw = segmentation(im, 12);

    bw = filter_label(bw,1000);

    figure();
    imshow(bw),title(['im' int2str(i)]);

    im_features = compute_features(bw);

    features{i} = im_features;
    
end