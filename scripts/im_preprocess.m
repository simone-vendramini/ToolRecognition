function out = im_preprocess(path)
im = im2double(imresize(imread(path), 0.3));
gaussFilt = fspecial("gaussian", [25 25], 2);
imG = im.^(0.7);
out = imfilter(imG, gaussFilt);
end