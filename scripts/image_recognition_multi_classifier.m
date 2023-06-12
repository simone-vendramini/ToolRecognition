% close all;
clear;

load('multi_classifier.mat');

[images, labels] = readlists('../lists/images_multiple.list', '../lists/labels_green.list');

for i=1 : numel(images)
    im = im_preprocess(['../dataset/' images{i}], 11);

    bw = segmentation(im);

    min_bbox = get_labels(bw);

    figure();
    imshow(im), title(['im ' int2str(i)]); 
    hold on;

    for j = 1 :numel(min_bbox)
        cm_features_A = compute_features(min_bbox{j}, "ANOVA");
        cm_features_A = cell2mat(struct2cell(cm_features_A{1})).';

        cm_features_M = compute_features(min_bbox{j}, "MRMR");
        cm_features_M = cell2mat(struct2cell(cm_features_M{1})).';

        [label_T, score_T] = predict(cart, cm_features_M);
        [label_K, score_K] = predict(knnMahalanobis, cm_features_A);

        
        score = (score_T + score_K) / 2;
        
        label = cart.ClassNames(find(score == max(score)));
        
        label = replace(label, '_', ' ');
        score = sort(score, 'descend');
        if (score(1) - score(2)) <= 0.2 || score(1) <= 0.55
            label = 'Unknown';
        end
        
        if score(1) < 1
            label = label + " "  + string((score(1) * 100)) + "%";
        end

        % Visualizzazione
        bbox = regionprops(min_bbox{j}, "BoundingBox");
        rectangle('Position',bbox.BoundingBox,'EdgeColor','r', 'LineWidth',2);
        text(bbox.BoundingBox(1), bbox.BoundingBox(2), label, 'BackgroundColor', 'r', 'FontSize', 10, 'Color', 'w');
    end

    hold off;
end