function out = im_preprocess(path)
im = im2double(imresize(imread(path), 0.3));
n = 15;
sigma = ceil((n-1)/5);
gaussFilt = fspecial("gaussian", [n n], sigma);
imG = im.^(0.8);
out = imfilter(imG, gaussFilt);
end