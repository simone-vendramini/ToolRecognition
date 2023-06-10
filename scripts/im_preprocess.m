function out = im_preprocess(im, n)

    sigma = (n-1)/5;
    gaussFilt = fspecial("gaussian", [n n], sigma);

    out = imfilter(im, gaussFilt);
    
end