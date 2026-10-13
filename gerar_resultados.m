function gerar_resultados()
    addpath('src');
    rand('seed', 42);
    randn('seed', 42);

    intensidade();
    algebrica();
    histogramas();
    filtragem();
    contraste();
    bordas();
    agucamento();
    convolucao_obrigatoria();
end

function intensidade()
    pasta = criar_pasta('intensidade');

    f = ler('mamografia.png');
    salvar(f, pasta, 'mamografia');
    salvar(negativo(f), pasta, 'mamografia_negativo');

    f = ler('fingerprint.tif');
    salvar(f, pasta, 'digital');
    salvar(limiarizacao(f, 128), pasta, 'digital_limiar_128');

    f = ler('fratura.png');
    salvar(f, pasta, 'fratura');
    for y = [0.3 0.5 2]
        salvar(potencia_gamma(f, 1, y), pasta, sprintf('fratura_gamma_%s', rotulo(y)));
    end

    f = ler('hubble-original.tif');
    salvar(f, pasta, 'hubble');
    salvar(logaritimo(f, 255 / log(256)), pasta, 'hubble_log');

    f = ler('polymersomes.tif');
    salvar(f, pasta, 'polimeros');
    salvar(alargamento_contraste(f, 140, 30, 200, 225), pasta, 'polimeros_alargamento');
    salvar(desenhar_curva_alargamento(140, 30, 200, 225), pasta, 'curva_alargamento');
end

function algebrica()
    pasta = criar_pasta('algebrica');

    f1 = ler('cameraman.tif');
    f2 = ler('lena_gray_256.tif');
    salvar(f1, pasta, 'f1');
    salvar(f2, pasta, 'f2');

    for t = [0.25 0.5 0.75]
        salvar(dissolve_uniforme(f1, f2, t), pasta, sprintf('uniforme_t_%s', rotulo(t)));
    end

    [m, n] = size(f1);
    rampa = repmat(linspace(0, 1, n), m, 1);
    [x, y] = meshgrid(1:n, 1:m);
    circulo = double((x - n / 2).^2 + (y - m / 2).^2 < (0.35 * n)^2);

    salvar(uint8(255 * rampa), pasta, 'pesos_rampa');
    salvar(uint8(255 * circulo), pasta, 'pesos_circulo');
    salvar(dissolve_nao_uniforme(f1, f2, rampa), pasta, 'nao_uniforme_rampa');
    salvar(dissolve_nao_uniforme(f1, f2, circulo), pasta, 'nao_uniforme_circulo');
end

function histogramas()
    pasta = criar_pasta('histograma');

    imagens = {'back1.jpg', 'fundo_escuro'; 'polymersomes.tif', 'polimeros'};
    for i = 1:size(imagens, 1)
        f = ler(imagens{i, 1});
        nome = imagens{i, 2};
        resultados = {f, expansao_histograma(f), equalizacao_histograma(f)};
        sufixos = {'original', 'expansao', 'equalizacao'};
        for k = 1:3
            salvar(resultados{k}, pasta, sprintf('%s_%s', nome, sufixos{k}));
            salvar(desenhar_histograma(resultados{k}), pasta, ...
                   sprintf('%s_%s_hist', nome, sufixos{k}));
        end
    end
end

function filtragem()
    pasta = criar_pasta('filtragem');

    f = ler('cameraman.tif');
    salvar(f, pasta, 'original');

    sal_pimenta = f;
    p = rand(size(f));
    sal_pimenta(p < 0.05) = 0;
    sal_pimenta(p > 0.95) = 255;

    gaussiano = uint8(double(f) + 20 * randn(size(f)));

    ruidos = {sal_pimenta, 'sal_pimenta'; gaussiano, 'gaussiano'};
    for i = 1:2
        g = ruidos{i, 1};
        nome = ruidos{i, 2};
        salvar(g, pasta, nome);
        for n = [3 5]
            salvar(filtro_media(g, n, 'repetir'), pasta, sprintf('%s_media_%d', nome, n));
            salvar(filtro_mediana(g, n, 'repetir'), pasta, sprintf('%s_mediana_%d', nome, n));
        end
    end
end

function contraste()
    pasta = criar_pasta('contraste');

    f = ler('fisico.tif');
    salvar(f, pasta, 'original');
    for c = [20 40]
        for n = [7 15]
            salvar(contraste_adaptativo(f, c, n, 'repetir'), pasta, ...
                   sprintf('c_%d_n_%d', c, n));
        end
    end
end

function bordas()
    pasta = criar_pasta('bordas');

    f = ler('cameraman.tif');
    salvar(f, pasta, 'original');

    r = bordas_roberts(f, 'repetir');
    salvar_gradiente(r, pasta, 'roberts');

    r = bordas_sobel(f, 'repetir');
    salvar_gradiente(r, pasta, 'sobel');

    r = bordas_kirsch(f, 'repetir');
    for k = 1:8
        salvar(ajustar_intervalo(r.respostas(:, :, k)), pasta, ['kirsch_' r.nomes{k}]);
    end
    salvar(r.final, pasta, 'kirsch_final');

    for v = [4 8]
        r = bordas_laplaciano(f, v, 'repetir');
        salvar(ajustar_intervalo(r.resposta, 'normalizar'), pasta, ...
               sprintf('laplaciano_%d_resposta', v));
        salvar(r.final, pasta, sprintf('laplaciano_%d_final', v));
    end
end

function agucamento()
    pasta = criar_pasta('agucamento');

    f = ler('lua.jpg');
    salvar(f, pasta, 'original');

    for v = [4 8]
        r = agucamento_laplaciano(f, v, 'repetir');
        salvar(r.laplaciano_visual, pasta, sprintf('laplaciano_%d', v));
        salvar(r.final, pasta, sprintf('agucada_%d', v));
    end

    for k = [1 2 4]
        r = high_boost(f, k, 5, 'repetir');
        if k == 1
            salvar(ajustar_intervalo(r.mascara, 'normalizar'), pasta, 'high_boost_mascara');
        end
        salvar(r.final, pasta, sprintf('high_boost_k_%d', k));
    end
end

function convolucao_obrigatoria()
    pasta = criar_pasta('convolucao');

    f = ler('cameraman.tif');
    salvar(f, pasta, 'original');

    pares = [1 1; 2 1; 1 3; 3 3];
    for i = 1:size(pares, 1)
        c = pares(i, 1);
        d = pares(i, 2);
        h = [-c -c -c; -c 8 * c + d -c; -c -c -c];
        registrar(sprintf('2.1_agucamento_c%d_d%d', c, d), f, h, 0, {'saturar'}, pasta);
    end

    h1 = [0 0 0; 0 1 0; 0 0 -1];
    h2 = [0 0 2; 0 -1 0; -1 0 0];
    registrar('2.2_relevo_h1', f, h1, 128, {'saturar'}, pasta);
    registrar('2.2_relevo_h2', f, h2, 128, {'saturar'}, pasta);
    registrar('2.2_relevo_h1_sem_offset', f, h1, 0, {'saturar'}, pasta);

    h3 = [-1 -1 0; 1 0 1; 0 1 1];
    h4 = [0 -1 0; -1 -4 -1; 0 -1 0];
    registrar('2.3_bordas_h3', f, h3, 0, {'saturar', 'modulo', 'normalizar'}, pasta);
    registrar('2.3_bordas_h4', f, h4, 0, {'saturar', 'modulo', 'normalizar'}, pasta);
end

function registrar(nome, f, h, offset, modos, pasta)
    r = convolucao(f, h, 'repetir', offset);

    printf('%-28s soma=%3d  min=%7.1f  max=%7.1f  <0: %5.1f%%  >255: %5.1f%%\n', ...
           nome, sum(h(:)), min(r(:)), max(r(:)), 100 * mean(r(:) < 0), 100 * mean(r(:) > 255));

    separador = 255 * ones(size(f, 1), 8, 'uint8');
    for k = 1:numel(modos)
        g = ajustar_intervalo(r, modos{k});
        base = fullfile(pasta, sprintf('%s_%s', nome, modos{k}));
        imwrite(g, [base '.png']);
        imwrite([f, separador, g], [base '_comparacao.png']);
    end
end

function salvar_gradiente(r, pasta, nome)
    salvar(ajustar_intervalo(r.gx, 'normalizar'), pasta, [nome '_gx']);
    salvar(ajustar_intervalo(r.gy, 'normalizar'), pasta, [nome '_gy']);
    salvar(r.final, pasta, [nome '_magnitude']);
end

function img = desenhar_histograma(f)
    h = histograma(f);
    altura = 128;
    barras = round(h / max(h) * altura);

    img = 255 * ones(altura, 256, 'uint8');
    for k = 1:256
        img(altura - barras(k) + 1:altura, k) = 0;
    end
    img = img(:, ceil((1:512) / 2));
end

function img = desenhar_curva_alargamento(r1, s1, r2, s2)
    s = double(alargamento_contraste(uint8(0:255), r1, s1, r2, s2));

    img = 255 * ones(256, 256, 'uint8');
    for r = 0:255
        linhas = max(1, 255 - s(r + 1)):min(256, 257 - s(r + 1));
        img(linhas, max(1, r):min(256, r + 2)) = 0;
    end
    img(256, :) = 128;
    img(:, 1) = 128;
end

function f = ler(nome)
    f = imread(fullfile('images', nome));
    if size(f, 3) == 3
        f = rgb2gray(f);
    end
end

function salvar(img, pasta, nome)
    imwrite(img, fullfile(pasta, [nome '.png']));
end

function pasta = criar_pasta(nome)
    pasta = fullfile('resultados', nome);
    if ~exist(pasta, 'dir')
        mkdir(pasta);
    end
end

function texto = rotulo(valor)
    texto = strrep(sprintf('%g', valor), '.', '_');
end
