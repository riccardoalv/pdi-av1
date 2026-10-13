function g = dissolve_nao_uniforme(imagem1, imagem2, pesos)
    s = (1 - pesos) .* double(imagem1) + pesos .* double(imagem2);

    g = ajustar_intervalo(s);
end
