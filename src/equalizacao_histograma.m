function g = equalizacao_histograma(imagem)
    h = histograma(imagem);
    p = h / numel(imagem);

    cdf = cumsum(p);

    tabela = 255 * cdf;

    s = tabela(double(imagem) + 1);

    g = ajustar_intervalo(s);
end
