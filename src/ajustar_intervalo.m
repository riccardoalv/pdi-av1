function g = ajustar_intervalo(r, modo)
    if nargin < 2
        modo = 'saturar';
    end

    r = double(r);

    switch modo
        case 'saturar'
            r(r < 0) = 0;
            r(r > 255) = 255;

        case 'normalizar'
            minimo = min(r(:));
            maximo = max(r(:));

            if maximo == minimo
                r(r < 0) = 0;
                r(r > 255) = 255;
            else
                r = (r - minimo) / (maximo - minimo) * 255;
            end

        case 'modulo'
            r = abs(r);
            r(r > 255) = 255;
    end

    g = uint8(round(r));
end
