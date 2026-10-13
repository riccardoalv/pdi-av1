function g = alargamento_contraste(imagem, r1, s1, r2, s2)
    r = double(imagem);
    s = zeros(size(r));

    trecho1 = r < r1;
    s(trecho1) = s1 / r1 * r(trecho1);

    trecho2 = r >= r1 & r < r2;
    s(trecho2) = s1 + (s2 - s1) / (r2 - r1) * (r(trecho2) - r1);

    trecho3 = r >= r2;
    if r2 == 255
        s(trecho3) = s2;
    else
        s(trecho3) = s2 + (255 - s2) / (255 - r2) * (r(trecho3) - r2);
    end

    g = ajustar_intervalo(s);
end
