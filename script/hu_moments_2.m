function out = hu_moments_2(img_binary)
    % Calcolo dei momenti centrali dell'immagine binaria
    moments = moment(img_binary, 1:7, 7);

    % Calcolo dei momenti di Hu normalizzati
    hu_moments = zeros(1, 7);
    for i = 1:7
        hu_moments(i) = calculate_hu_moment(moments, i);
    end
    
    out = hu_moments;
end

% Funzione per il calcolo dei momenti di Hu normalizzati
function hu = calculate_hu_moment(moments, n)
    if n < 1 || n > 7
        error('Il valore di n deve essere compreso tra 1 e 7');
    end

    % Calcolo del momento centrale normalizzato
    eta = (moments(3, n) / moments(1, 1))^(1 + n / 2);

    % Calcolo del momento di Hu normalizzato
    hu = eta * (-1)^((1 + n) / 2);
end