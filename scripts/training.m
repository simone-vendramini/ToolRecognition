close all;
clear;
tic
[images, labels] = readlists('../lists/images_single.list', '../lists/labels_single.list');

features = [];

for i=1 : numel(images)
%for i= 381:385
    
    im_features = zeros(15, 1);

    im = imresize(imread(['../dataset/' images{i}]), 0.3);

    bw = segmentation(im);

%     figure(1);
%     imshow(bw),title(['im ' int2str(i)]);

    cm_features = compute_features(bw);

    if numel(cm_features) == 1
        im_features = cell2mat(struct2cell(cm_features{1}));
    else
        disp([images{i} ' segmentazione andata male']);
    end

    features = [features; im_features'];
end

save('data.mat', 'images', 'labels', "features");
toc
% writematrix(features, 'features.csv');

