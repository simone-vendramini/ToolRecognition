function out = compute_centroid(bw_image, centroid)
    flag = 0;

    x = floor(centroid(1));
    y = floor(centroid(2));

    if bw_image(y, x) == 1
        bw_image = 1 - bw_image;
        flag = 1;
    end

    tr_dist = bwdist(bw_image);

    dist = tr_dist(y, x);


    if flag == 0
        dist = -1 * dist;
    end

    out = dist;
end