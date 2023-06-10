% close all;
clear;

load('multi_classifier.mat');

[images, labels] = readlists('../lists/images_single.list', '../lists/labels_single.list');

predict_labels = [];

for i=1 : numel(images)
    im = imresize(imread(['../dataset/' images{i}]), 0.3);

    bw = segmentation(im);

    min_bbox = get_labels(bw);

%     figure();
%     imshow(im), title(['im ' int2str(i)]); 
%     hold on;

    cm_features_A = compute_features(min_bbox{1}, "ANOVA");
    cm_features_A = cell2mat(struct2cell(cm_features_A{1})).';

    cm_features_M = compute_features(min_bbox{1}, "MRMR");
    cm_features_M = cell2mat(struct2cell(cm_features_M{1})).';

    [label_T, score_T] = predict(cart, cm_features_M);
    [label_K, score_K] = predict(knnMahalanobis, cm_features_A);

        
    score = (score_T + score_K) / 2;
        
    label = cart.ClassNames(find(score == max(score)));

    predict_labels = [predict_labels; label];

    score = sort(score, 'descend');
    if (score(1) - score(2)) <= 0.2 || score(1) <= 0.55
        label = 'Unknown';
    end
    
%     label = replace(label, '_', ' ');
% 
%     if score(1) < 1
%         label = label + " "  + string((score(1) * 100)) + "%";
%     end
% 
%     % Visualizzazione
%     bbox = regionprops(min_bbox{1}, "BoundingBox");
%     rectangle('Position',bbox.BoundingBox,'EdgeColor','r', 'LineWidth',2);
%     text(bbox.BoundingBox(1), bbox.BoundingBox(2), label, 'BackgroundColor', 'r', 'FontSize', 10, 'Color', 'w');

%     hold off;
end

performance_test = confmat(predict_labels, labels);
    
figure();
show_confmat(performance_test.cm_raw, performance_test.labels);