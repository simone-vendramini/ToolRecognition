I = imresize(imread('../dataset/100.JPG'), 0.3);

n = 11;
sigma = ceil((n-1)/5);
gaussFilt = fspecial("gaussian", [n n], sigma);
I = imfilter(I, gaussFilt);

lvls = 11;

threshRGB = multithresh(I,lvls);

threshForPlanes = zeros(3,lvls);			

for i = 1:3
    threshForPlanes(i,:) = multithresh(I(:,:,i),lvls);
end

value = [0 threshRGB(2:end) 255]; 
quantRGB = imquantize(I, threshRGB, value);

quantPlane = zeros( size(I) );

for i = 1:3
    value = [0 threshForPlanes(i,2:end) 255]; 
    quantPlane(:,:,i) = imquantize(I(:,:,i),threshForPlanes(i,:),value);
end

quantPlane = uint8(quantPlane);


imshowpair(quantRGB,quantPlane,'montage') 
axis off
title('Full RGB Image Quantization        Plane-by-Plane Quantization')


dim = size( quantRGB );
quantRGBmx3   = reshape(quantRGB,   prod(dim(1:2)), 3);
quantPlanemx3 = reshape(quantPlane, prod(dim(1:2)), 3);

colorsRGB   = unique(quantRGBmx3,   'rows' );
colorsPlane = unique(quantPlanemx3, 'rows' );

disp(['Unique colors in RGB image            : ' int2str(length(colorsRGB))]);

disp(['Unique colors in Plane-by-Plane image : ' int2str(length(colorsPlane))]);


% RGB = imresize(imread('../dataset/387.JPG'), 0.3);
% 
% n = 11;
% sigma = ceil((n-1)/5);
% gaussFilt = fspecial("gaussian", [n n], sigma);
% RGB = imfilter(RGB, gaussFilt);
% 
% [IND,map] = rgb2ind(RGB,64, "dither");
% 
% figure
% subplot(2,2,1)
% imagesc(RGB)
% title("originale filtro gauss")
% axis image
% zoom(4)
% 
% subplot(2,2,2)
% imagesc(IND)
% title("indexed")
% colormap(map)
% axis image
% zoom(4)
% 
% for channel = 1:size(IND, 3)
%     IND(:, :, channel) = medfilt2(IND(:, :, channel), [3 3]);
% end
% 
% RGB2 = ind2rgb(IND, map);
% 
% subplot(2,2,3)
% imagesc(IND)
% title("indexed filtro mediano")
% colormap(map)
% axis image
% zoom(4)
% 
% subplot(2,2,4)
% imagesc(RGB2)
% title("rgb final")
% axis image
% zoom(4)
