function g = potencia_gamma(imagem, c, y)
    r = double(imagem) / 255;

    s = 255 * c * r.^y;

    g = ajustar_intervalo(s);
end
