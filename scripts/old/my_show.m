function my_show(im_rgb)

    im = rgb2hsv(im_rgb);

    figure();
    subplot(2, 3, 1), imshow(im_rgb);
    subplot(2, 3, 2), imshow(im(:, :, 1)), title("Hue");
    subplot(2, 3, 3), imshow(im(:, :, 2)), title("Saturation");
    %subplot(2, 3, 4), plot(imhist(im(:, :, 1)));
    subplot(2, 3, 5), plot(imhist(im(:, :, 1)));
    subplot(2, 3, 6), plot(imhist(im(:, :, 2)));
    
end

