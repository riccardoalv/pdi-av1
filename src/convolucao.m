function g = convolucao(imagem, kernel, modo, offset, constante)
    if nargin < 3
        modo = 'zero';
    end
    if nargin < 4
        offset = 0;
    end
    if nargin < 5
        constante = 128;
    end

    [kernel_linhas, kernel_colunas] = size(kernel);

    kernel = kernel(end:-1:1, end:-1:1);

    [m, n] = size(imagem);

    imagem_preenchida = double(preencher_bordas(imagem, [kernel_linhas, kernel_colunas], ...
                                                modo, constante));

    g = zeros(m, n);
    for i = 1:m
        for j = 1:n
            janela = imagem_preenchida(i:i + kernel_linhas - 1, j:j + kernel_colunas - 1);

            g(i, j) = sum(sum(janela .* kernel)) + offset;
        end
    end
end
