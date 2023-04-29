function out = central_moments(image, p, q)
    m00 = simple_moment(image, 0, 0);
    m10 = simple_moment(image, 1, 0);
    m01 = simple_moment(image, 0, 1);

    x_center = m10 / m00;
    y_center = m01 / m00;

    moment = 0;
    [rows, cols] = size(image);

    for i = 1:rows
        for j = 1: cols
            moment = moment + ((i - x_center)^p * (j - y_center)^q * image(i, j));
        end
    end

    out = moment;
end