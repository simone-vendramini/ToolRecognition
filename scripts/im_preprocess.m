function out = im_preprocess(path, n)
I = imresize(imread(path), 0.3);

sigma = ceil((n-1)/5);
gaussFilt = fspecial("gaussian", [n n], sigma);
I = imfilter(I, gaussFilt);

lvls = 15;

threshForPlanes = zeros(3,lvls);			

for i = 1:3
    threshForPlanes(i,:) = multithresh(I(:,:,i),lvls);
end

quantPlane = zeros( size(I) );

for i = 1:3
    value = [0 threshForPlanes(i,2:end) 255]; 
    quantPlane(:,:,i) = imquantize(I(:,:,i),threshForPlanes(i,:),value);
end

out = uint8(quantPlane);

% [IND,map] = rgb2ind(RGB,128,"dither");
% 
% m = 3;
% for channel = 1:size(IND, 3)
%     IND(:, :, channel) = medfilt2(IND(:, :, channel), [m m]);
% end
% 
% out = ind2rgb(IND, map);
end