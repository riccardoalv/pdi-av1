function h = histograma(imagem)
    h = zeros(1, 256);

    for k = 0:255
        h(k + 1) = sum(imagem(:) == k);
    end
end
