close all;
clear;

[images, labels] = readlists('../lists/images_single.list', '../lists/labels_single.list');

features = [];

for i=1 : numel(images)
    
    im_features = zeros(9);

    im = imresize(imread(['../dataset/' images{i}]), 0.3);
    im_hsv = rgb2hsv(im);

    bw = segmentation_black_and_white(im_hsv);
    bw_h = segmentation_hue(im_hsv(:,:,1),13);
    bw = filter_label(bw, 500);
    bw_h = filter_label(bw_h, 2500);

    bw = bw | bw_h;

%     figure();
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

