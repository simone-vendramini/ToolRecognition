function out = hu_moments(image)
    eta_20 = normalized_central_moments(image, 2, 0);
    eta_02 = normalized_central_moments(image, 0, 2);

    eta_30 = normalized_central_moments(image, 3, 0);
    eta_03 = normalized_central_moments(image, 0, 3);
    eta_12 = normalized_central_moments(image, 1, 2);
    eta_21 = normalized_central_moments(image, 2, 1);

    eta_11 = normalized_central_moments(image, 1, 1);

    out.first = (eta_20 + eta_02); 
    out.second = (eta_20 - eta_02)^2 + (2 * normalized_central_moments(image, 1, 1))^2;
    out.third = (eta_30 - 3 * eta_12)^2 + (eta_21 - eta_03)^2;
    out.fourth = (eta_30 + eta_12)^2 + (eta_21 + eta_03)^2;
    out.fifth = (eta_30 - 3 * eta_12)*(eta_30 + eta_12)*((eta_30 + eta_12)^2 - 3 * (eta_21 + eta_03)^2) + (3 * eta_21 - eta_03)*(3 * (eta_30 + eta_12)^2 - (eta_21 + eta_03)^2 );
    out.sixth = (eta_20 - eta_02)*((eta_30 + eta_12)^2 - (eta_21 - eta_03)^2 + 4 * eta_11 * (eta_30 + eta_12)*(eta_21 + eta_03));
    out.seventh = (3 *  eta_21 - eta_03) * (eta_30 + eta_12) * ((eta_30 + eta_12)^2 - 3 * (eta_21 + eta_03)^2) + (eta_30 - 3 * eta_12) * (eta_21 + eta_03) * (3 * (eta_30 + eta_12)^2 - (eta_21 + eta_03)^2);    
end