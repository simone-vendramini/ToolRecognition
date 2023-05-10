function out = normalized_central_moments(image, p, q)
    mu_pq = central_moments(image, p, q);
    mu_00 = simple_moment(image, 0, 0);

    out = mu_pq / (mu_00^(1 + ((p + q) / 2)));
end