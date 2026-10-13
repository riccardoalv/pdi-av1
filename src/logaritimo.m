function g = logaritimo(imagem, c)
    r = imagem;

    s = c * log(1 + r);
    g = ajustar_intervalo(s);
end
