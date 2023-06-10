close all;
clear;

load('multi_classifier.mat');

[images, labels] = readlists('../lists/images_multiple.list', '../lists/labels_multiple.list');

pred_labels = [];
% for i=1 : numel(images)
for i=80:80
    im = imresize(imread(['../dataset/' images{i}]), 0.3);
    
    im_F = im_preprocess(im, 11);

    bw = segmentation(im_F);

    min_bbox = get_labels(bw);

    figure();
    imshow(im), title(['im ' int2str(i)]); 
    hold on;
    figure();
    imshow(im_F), title(['im ' int2str(i)]); 
    hold on;

    
    labels_im = "";
    for j = 1 :numel(min_bbox)
        cm_features_A = compute_features(min_bbox{j}, "ANOVA");
        cm_features_A = cell2mat(struct2cell(cm_features_A{1})).';

        cm_features_M = compute_features(min_bbox{j}, "MRMR");
        cm_features_M = cell2mat(struct2cell(cm_features_M{1})).';

        [label_T, score_T] = predict(cart, cm_features_M);
        [label_K, score_K] = predict(knnMahalanobis, cm_features_A);

        
        score = (score_T * 0.2 + score_K * 0.8);
        
        label = cart.ClassNames(find(score == max(score)));
        
        label = replace(label, '_', ' ');
        score = sort(score, 'descend');
        if (score(1) - score(2)) <= 0.2 || score(1) <= 0.55
            label = 'Unknown';
        end

        labels_im = labels_im+","+ label;
        
        if score(1) < 1
            label = label + " "  + string(round(score(1) * 100)) + "%";
        end

        % Visualizzazione
        bbox = regionprops(min_bbox{j}, "BoundingBox");
        rectangle('Position',bbox.BoundingBox,'EdgeColor','r', 'LineWidth',2);
        text(bbox.BoundingBox(1), bbox.BoundingBox(2), label, 'BackgroundColor', 'r', 'FontSize', 10, 'Color', 'w');
    end
    if labels_im == ""
        labels_im = "-";
    end

    pred_labels = [pred_labels, labels_im];

    hold off;
end
pred_labels = pred_labels';