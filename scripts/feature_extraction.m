function out = feature_extraction()
    [images, labels] = readlists('../lists/images_single.list', '../lists/labels_single.list');
    
    features_A = [];
    features_M = [];
    
    for i=1 : numel(images)
        
        if mod(i,10) == 0
            clc
            completion = (round(i/numel(images)*100));
            fprintf('Progresso: [%s%s] %.2f%%', repmat('#', 1, completion), repmat('.', 1, 100 - completion), completion);
            fprintf('\r');
        end
    
        im = im_preprocess(['../dataset/' images{i}]);

        bw = segmentation(im);
    
        cm_features_A = compute_features(bw, "ANOVA");
        cm_features_M = compute_features(bw, "MRMR");

        im_features_A = cell2mat(struct2cell(cm_features_A{1}));
        im_features_M = cell2mat(struct2cell(cm_features_M{1}));

    
        features_A = [features_A; im_features_A'];
        features_M = [features_M; im_features_M'];
    end
    
    out.features_ANOVA = features_A;
    out.features_MRMR = features_M;
    out.labels = labels;
    out.images = images;

    % save('data.mat', 'images', 'labels', "features");

end

