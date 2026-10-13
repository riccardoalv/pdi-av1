function g = contraste_adaptativo(imagem, c, n, modo)
    f = double(imagem);
    kernel = ones(n) / (n * n);

    media = convolucao(f, kernel, modo);
    media_quadrados = convolucao(f.^2, kernel, modo);

    variancia = media_quadrados - media.^2;
    variancia(variancia < 0) = 0;
    desvio = sqrt(variancia);

    s = f;
    tem_variacao = desvio > 0;
    s(tem_variacao) = media(tem_variacao) + ...
        c ./ desvio(tem_variacao) .* (f(tem_variacao) - media(tem_variacao));

    g = ajustar_intervalo(s);
end
