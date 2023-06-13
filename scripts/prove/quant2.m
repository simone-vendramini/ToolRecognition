RGB = imread('../dataset/022.JPG');

n = 11;
sigma = ceil((n-1)/5);
gaussFilt = fspecial("gaussian", [n n], sigma);
% RGB = imfilter(RGB, gaussFilt);

[IND,map] = rgb2ind(RGB,16);

figure
imagesc(RGB)
axis image
zoom(4)

for channel = 1:size(IND, 3)
    IND(:, :, channel) = medfilt2(IND(:, :, channel), [5 5]);
end



figure
imagesc(IND)
colormap(map)
axis image
zoom(4)

RGB2 = ind2rgb(IND, map);

figure
imagesc(RGB2)
axis image
zoom(4)
