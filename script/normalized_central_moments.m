function out = normalized_central_moments(image, p, q)
    mu_pq = central_moments(image, p, q);
    mu_00 = central_moments(image, 0, 0);

    moment = mu_pq / (mu_00^(1 + ((p + q) / 2)));

    out = moment;
end