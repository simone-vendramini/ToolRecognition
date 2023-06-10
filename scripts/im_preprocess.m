function out = im_preprocess(path)
im = imresize(imread(path), 0.3);


n = 5; m = 5;
sigma = ceil((n-1)/5);
gaussFilt = fspecial("gaussian", [n n], sigma);

imFilt1 = imfilter(im, gaussFilt);
quant = my_quantization(imFilt1);

imFilt2 = quant;
for channel = 1:size(quant, 3)
    imFilt2(:, :, channel) = medfilt2(quant(:, :, channel), [m m]);
end

% figure();
% subplot(2,2,1), imshow(imFilt1), title("Guassiano");
% subplot(2,2,2), imshow(quant), title("Quantizzata");
% subplot(2,2,3), imshow(imFilt2), title("Mediano");

out = imFilt2;
end


function res = my_quantization(inImg)
%Number of colors to be present in the output
noOfColors = 20;

% inImg = im_preprocess("../dataset/011.JPG");
% inImg = imresize(imread("../dataset/011.JPG"), 0.3);
s_img = size(inImg);

%K-Means
r = inImg(:,:,1);
g = inImg(:,:,2);
b = inImg(:,:,3);
inputImg = zeros((s_img(1) * s_img(2)), 3);
inputImg(:,1) = r(:);
inputImg(:,2) = g(:);
inputImg(:,3) = b(:);
inputImg = double(inputImg);
% disp('K-Means Processing Started');
[idx, C] = kmeans(inputImg, noOfColors, 'EmptyAction', 'singleton');
% disp('K-Means Processing Completed');
palette = round(C);

%Color Mapping
idx = uint8(idx);
outImg = zeros(s_img(1),s_img(2),3);
temp = reshape(idx, [s_img(1) s_img(2)]);
for i = 1 : 1 : s_img(1)
    for j = 1 : 1 : s_img(2)
        outImg(i,j,:) = palette(temp(i,j),:);
    end
end

res = uint8(outImg);
end

% outImg = im_preprocess(outImg);
% 
% subplot(1,2,1), imshow(inImg), title("Originale");
% subplot(1,2,2), imshow(uint8(outImg)), title("Quantizzata e preprocessata");