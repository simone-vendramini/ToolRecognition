function out = compute_simple_moments(image, p, q)
    [rows, cols] = size(image);

    moment = 0;
    for x = 1:rows
        for y = 1: cols
            moment = moment + ((x^p) * (y^q) * image(x, y));
        end
    end

    out = moment;
end