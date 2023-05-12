function out = segmentation_edge(im)

    prewitt=edge(im,"prewitt");
    sobel=edge(im, "sobel");
    roberts=edge(im, "roberts");

    figure();
    subplot(1,3,1);
    imshow(prewitt), title('prewitt');
    subplot(1,3,2);
    imshow(sobel),  title('sobel');
    subplot(1,3,3);
    imshow(roberts),  title('roberts');

    out = prewitt;
end
