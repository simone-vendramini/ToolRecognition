function feature_extraction()
    [images, labels] = readlists('../lists/images_single.list', '../lists/labels_single.list');
    
    features = [];
    
    for i=1 : numel(images)
        
        if mod(i,10) == 0
            completion = (round(i/numel(images)*100));
            fprintf('Progresso: [%s%s] %.2f%%', repmat('#', 1, completion), repmat('.', 1, 100 - completion), completion);
            fprintf('\r');
        end
    
        
        im_features = zeros(6, 1);
    
        im = imresize(imread(['../dataset/' images{i}]), 0.3);
    
        bw = segmentation(im);
    
        cm_features = compute_features(bw);
    
%         if numel(cm_features) == 1
        im_features = cell2mat(struct2cell(cm_features{1}));
%         else
% %             figure(1);
% %             imshow(bw),title(['im ' int2str(i)]);
% %             disp([images{i} ' segmentazione andata male ' labels{i}]);
%             im_features = cell2mat(struct2cell(cm_features{1}));
%         end
    
        features = [features; im_features'];
    end
    
    save('data.mat', 'images', 'labels', "features");

end

