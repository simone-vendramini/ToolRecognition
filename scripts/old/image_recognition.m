% close all;
clear;

% load('model.mat');
load('model_knn.mat');

[images, labels] = readlists('../lists/images_multiple.list', '../lists/labels_green.list');

% for i=1 : numel(images)
for i = 115 : 115
    %im = im_preprocess(['../dataset/' images{i}]);
    im = im_preprocess("../dataset/284.jpg");

    bw = segmentation(im);

    min_bbox = get_labels(bw);

    figure();
    imshow(bw), title(['im ' int2str(i)]); 
    hold on;
    list_score = [];
    for j = 1 :numel(min_bbox)
        cm_features = compute_features(min_bbox{j});
        cm_features = cell2mat(struct2cell(cm_features{1})).';

        [label, score] = predict(cart, cm_features);
        label = replace(label, '_', ' ');
        score = sort(score, 'descend');
        if (score(1) - score(2)) <= 0.1
            label = 'Unknown';
        end

        list_score = [list_score; score];

        label = [label score(1)];
        bbox = regionprops(min_bbox{j}, "BoundingBox");
        rectangle('Position',bbox.BoundingBox,'EdgeColor','r', 'LineWidth',2);
        text(bbox.BoundingBox(1), bbox.BoundingBox(2), label, 'BackgroundColor', 'r', 'FontSize', 10, 'Color', 'w');
    end

    hold off;
end