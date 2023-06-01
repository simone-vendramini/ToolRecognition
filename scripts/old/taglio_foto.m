close all;
clear;

[images, labels] = readlists('../lists/images_blue.list', '../lists/labels_blue.list');
wdt = 2604;
hei = 3906; % (3*wdt)/ 2

for i=1 : numel(images)
    im = imread(['../dataset/' images{i}]);
    rotated = imrotate(im, -90);
    cropped = imcrop(rotated, [0 0 wdt hei]);
    path = ['../dataset/' images{i}];
    imwrite(cropped, path);
end