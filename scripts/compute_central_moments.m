function out = compute_central_moments(image, p, q)
    m_00 = compute_simple_moments(image, 0, 0);
    m_10 = compute_simple_moments(image, 1, 0);
    m_01 = compute_simple_moments(image, 0, 1);

    x_center = m_10 / m_00;
    y_center = m_01 / m_00;

    moment = 0;
    [rows, cols] = size(image);

    for x = 1:rows
        for y = 1: cols
            moment = moment + (((x - x_center)^p) * ((y - y_center)^q) * image(x, y));
        end
    end

    out = moment;
end