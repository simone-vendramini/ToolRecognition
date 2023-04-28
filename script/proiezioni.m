function out = proiezioni(element)
    columns = sum(element);
    rows = sum(element.');

    out.columns = columns;
    out.rows = rows;
end