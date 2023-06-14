RGB = imresize(imread('../dataset/387.JPG'), 0.3);

n = 11;
sigma = ceil((n-1)/5);
gaussFilt = fspecial("gaussian", [n n], sigma);
RGB = imfilter(RGB, gaussFilt);

[IND,map] = rgb2ind(RGB,64, "dither");

figure
subplot(2,2,1)
imagesc(RGB)
title("originale filtro gauss")
axis image
zoom(4)

subplot(2,2,2)
imagesc(IND)
title("indexed")
colormap(map)
axis image
zoom(4)

for channel = 1:size(IND, 3)
    IND(:, :, channel) = medfilt2(IND(:, :, channel), [3 3]);
end

RGB2 = ind2rgb(IND, map);

subplot(2,2,3)
imagesc(IND)
title("indexed filtro mediano")
colormap(map)
axis image
zoom(4)

subplot(2,2,4)
imagesc(RGB2)
title("rgb final")
axis image
zoom(4)
