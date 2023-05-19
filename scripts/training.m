close all;
clear;

[images, labels] = readlists('../lists/images_blue.list', '../lists/labels_blue.list');

features = [];

%for i=1 : numel(images)
for i = 239-131 : 239-131
    
    im_features = zeros(8);

    im = imresize(imread(['../dataset/' images{i}]), 0.3);

    bw = segmentation(im, 13);

    figure(1);
    imshow(bw),title(['im ' int2str(i)]);

    cm_features = compute_features(bw);

    if numel(cm_features) == 1
        im_features = cell2mat(struct2cell(cm_features{1}));
    else
        disp([images{i} ' segmentazione andata male']);
    end

    features = [features; im_features'];
end

save('data.mat', 'images', 'labels', "features");

