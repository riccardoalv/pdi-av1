function g = filtro_media(imagem, n, varargin)
    kernel = ones(n) / (n * n);

    g = ajustar_intervalo(convolucao(imagem, kernel, varargin{:}));
end
