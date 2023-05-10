% È possibile quindi utilizzare i momenti come descrittori di forma e 
% distinguere oggetti aventi forma diversa sulla base di un sotto-insieme,
% opportunamente determinato, dell%insieme dei momenti.
function out = hu_moments(image)
    eta_02 = normalized_central_moments(image, 0, 2);
    eta_03 = normalized_central_moments(image, 0, 3);
    eta_12 = normalized_central_moments(image, 1, 2);
    eta_11 = normalized_central_moments(image, 1, 1);
    eta_20 = normalized_central_moments(image, 2, 0);
    eta_21 = normalized_central_moments(image, 2, 1);    
    eta_30 = normalized_central_moments(image, 3, 0);
    
    % Hu_1 = (eta_20 + eta_02)
    out.first = (eta_20 + eta_02); 

    % Hu_2 = ((eta_20 - eta_02)^2 + 4*eta_11^2)
    out.second = (eta_20 - eta_02)^2 + (4 * eta_11^2);

    % Hu_3 = ((eta_30 - 3eta_12)^2 + (eta_03 - 3eta_21)^2)
    out.third = ((eta_30 - 3 * eta_12)^2 + (eta_03 - 3 * eta_21)^2);

    % Hu_4 = ((eta_30 + eta_12)^2 + (eta_21 + eta_03)^2)
    out.fourth = ((eta_30 + eta_12)^2 + (eta_21 + eta_03)^2);

    % Hu_5 = ((eta_30 - 3eta_12)(eta_30 + eta_12)[(eta_30 + eta_12)^2 - 3(eta_21 + eta_03)^2] + (3eta_21 - eta_03)(eta_21 + eta_03)(3(eta_30 + eta_12)^2 - (eta_21 + eta_03)^2))
    out.fifth = (eta_30 - 3 * eta_12) * (eta_30 + eta_12) * ((eta_30 + eta_12)^2 - 3 * (eta_21 + eta_03)^2) + (3 * eta_21 - eta_03) * (eta_03 + eta_21) * (3 * (eta_30 + eta_12)^2 - (eta_21 + eta_03)^2 );
    
    % Hu_6 = ((eta_20 - eta_02)[(eta_30 + eta_12)^2 - (eta_21 + eta_03)^2] + 4eta_11*(eta_30 + eta_12)*(eta_21 + eta_03))
    out.sixth = ((eta_20 - eta_02) * ((eta_30 + eta_12)^2 - ((eta_21 - eta_03)^2)) + 4 * eta_11 * (eta_30 + eta_12) * (eta_21 + eta_03));

    % Hu_7 = ((3eta_21 - eta_03)(eta_30 + eta_12)[(eta_30 + eta_12)^2 - 3(eta_21 + eta_03)^2] - (eta_30 - 3eta_12)(eta_21 + eta_03)(3(eta_30 + eta_12)^2 - (eta_21 + eta_03)^2))
    out.seventh = ((3 * eta_21 - eta_03) * (eta_30 + eta_12) * ((eta_30 + eta_12)^2 - 3 * (eta_21 + eta_03)^2) + (3 * eta_12 - eta_30) * (eta_21 + eta_03) * (3 * (eta_30 + eta_12)^2 - (eta_21 + eta_03)^2));    
end


function out = normalized_central_moments(image, p, q)
    mu_pq = central_moments(image, p, q);
    mu_00 = simple_moment(image, 0, 0);

    out = mu_pq / (mu_00^(1 + ((p + q) / 2)));
end

function out = central_moments(image, p, q)
    m_00 = simple_moment(image, 0, 0);
    m_10 = simple_moment(image, 1, 0);
    m_01 = simple_moment(image, 0, 1);

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

function out = simple_moment(image, p, q)
    [rows, cols] = size(image);

    moment = 0;
    for x = 1:rows
        for y = 1: cols
            moment = moment + ((x^p) * (y^q) * image(x, y));
        end
    end

    out = moment;
end