function r = preencher_bordas(matriz, kernel_size, modo, constante)
    if isscalar(kernel_size)
        kernel_size = [kernel_size, kernel_size];
    end
    antes_linhas = ceil(kernel_size(1) / 2) - 1;
    depois_linhas = floor(kernel_size(1) / 2);
    antes_colunas = ceil(kernel_size(2) / 2) - 1;
    depois_colunas = floor(kernel_size(2) / 2);
    [m, n] = size(matriz);

    total_linhas = antes_linhas + m + depois_linhas;
    total_colunas = antes_colunas + n + depois_colunas;

    miolo_linhas = antes_linhas + 1:antes_linhas + m;
    miolo_colunas = antes_colunas + 1:antes_colunas + n;

    switch modo
        case 'repetir'
            linhas_idx  = [ones(1, antes_linhas), 1:m, ones(1, depois_linhas) * m];
            colunas_idx = [ones(1, antes_colunas), 1:n, ones(1, depois_colunas) * n];

            r = matriz(linhas_idx, colunas_idx);

        case 'constante'
            r = ones(total_linhas, total_colunas, class(matriz)) * constante;
            r(miolo_linhas, miolo_colunas) = matriz;

        otherwise
            r = zeros(total_linhas, total_colunas, class(matriz));

            r(miolo_linhas, miolo_colunas) = matriz;
    end
end
