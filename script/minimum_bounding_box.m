function out = minimum_bounding_box(bw)
    s = regionprops(bw,'all');
    centroids = cat(1,s.Centroid);
    imshow(bw)
    hold on
    plot(centroids(:,1),centroids(:,2),'b*')
    hold off
end