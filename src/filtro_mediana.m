function g = filtro_mediana(imagem, n, modo)
    padding = (n - 1) / 2;
    [m, k] = size(imagem);

    imagem_preenchida = double(preencher_bordas(imagem, n, modo));

    g = zeros(m, k);
    for i = 1:m
        for j = 1:k
            janela = imagem_preenchida(i:i + 2 * padding, j:j + 2 * padding);

            valores = sort(janela(:));
            g(i, j) = valores((numel(valores) + 1) / 2);
        end
    end

    g = ajustar_intervalo(g);
end
