close all;
clear;

[images, labels] = readlists('../lists/images_single.list', '../lists/labels_single.list');

media = [];
gaussiano = [];
sharp = [];
    
for i=1 : numel(images)
    if mod(i,10) == 0
        clc
        completion = (round(i/numel(images)*100));
        fprintf('Progresso: [%s%s] %.2f%%', repmat('#', 1, completion), repmat('.', 1, 100 - completion), completion);
        fprintf('\r');
    end
    
    im = imresize(imread(['../dataset/' images{i}]), 0.3);
    
    bw = segmentation(im);

    M3 = fspecial("average", 3);
    im_M = imfilter(im, M3);
    bw_M = segmentation(im_M);
    differenza = bw - bw_M;
    mse = sum(sum(differenza.^2)) / (numel(bw));
    media = [media; mse];

    G11 = fspecial("gaussian", 11, 2);
    im_G = imfilter(im, G11);
    bw_G = segmentation(im_G);
    differenza = bw - bw_G;
    mse = sum(sum(differenza.^2)) / (numel(bw));
    gaussiano = [gaussiano; mse];



    im_S = im + (im - im_M);
    bw_S = segmentation(im_S);
    differenza = bw - bw_S;
    mse = sum(sum(differenza.^2)) / (numel(bw));
    sharp = [sharp; mse];
end