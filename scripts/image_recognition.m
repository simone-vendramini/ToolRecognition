close all;
clear;

load('model.mat');

[images, labels] = readlists('../lists/images_multiple.list', '../lists/labels_multiple.list');

for i=1 : numel(images)
%for i = 2 : 2
    im = imresize(imread(['../dataset/' images{i}]), 0.3);

    bw = segmentation(im);

    min_bbox = get_labels(bw);

    figure();
    imshow(im), title(['im ' int2str(i)]); 
    hold on;
    for j = 1 :numel(min_bbox)
        cm_features = compute_features(min_bbox{j});
        cm_features = cell2mat(struct2cell(cm_features{1})).';

        label = predict(cart, cm_features);
        label = replace(label, '_', ' ');
        bbox = regionprops(min_bbox{j}, "BoundingBox");
        rectangle('Position',bbox.BoundingBox,'EdgeColor','r', 'LineWidth',5);
        text(bbox.BoundingBox(1), bbox.BoundingBox(2), label, 'BackgroundColor', 'r', 'FontSize', 14, 'Color', 'w');
    end

    hold off;
end