function out = projections(element)
    x = sum(element);
    y = sum(element.');

    if length(y) > length(x)
        temp = y;
        y = x;
        x = temp;
    end

    out.x = x;
    out.y = y;
end