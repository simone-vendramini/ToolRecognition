im1 = rgb2gray(imread("../images/182 crop.jpg"));
im2 = rgb2gray(imread("../images/182.jpg"));

im2 = imcrop(im2, [0 0 size(im1)]);

figure(1),
imshow(im1');
figure(2),
imshow(im2);
figure(3), imshow(im2-im1');