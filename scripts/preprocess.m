function out = preprocess(im)
im = im2double(im);
gaussFilt = fspecial("gaussian", [25 25], 2);
imG = im.^(0.7);
out = imfilter(imG, gaussFilt);
end