function g = dissolve_uniforme(imagem1, imagem2, t)
    s = (1 - t) * double(imagem1) + t * double(imagem2);

    g = ajustar_intervalo(s);
end
