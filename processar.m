function processar(arquivo_pedido)
    addpath('src');

    pedido = jsondecode(fileread(arquivo_pedido));
    parametros = pedido.parametros;
    if isfield(parametros, 'constante') && ~isfield(parametros, 'offset')
        parametros.offset = 0;
    end
    borda = {'modo', 'offset', 'constante'};

    operacoes.negativo = {@negativo, {}};
    operacoes.limiarizacao = {@limiarizacao, {'limiar'}};
    operacoes.logaritimo = {@logaritimo, {'c'}};
    operacoes.potencia_gamma = {@potencia_gamma, {'c', 'y'}};
    operacoes.alargamento_contraste = {@alargamento_contraste, {'r1', 's1', 'r2', 's2'}};
    operacoes.dissolve_uniforme = {@dissolve_uniforme, {'imagem2', 't'}};
    operacoes.dissolve_nao_uniforme = {@dissolve_nao_uniforme, {'imagem2', 'pesos'}};
    operacoes.histograma = {@histograma, {}};
    operacoes.expansao_histograma = {@expansao_histograma, {}};
    operacoes.equalizacao_histograma = {@equalizacao_histograma, {}};
    operacoes.ajustar_intervalo = {@ajustar_intervalo, {'modo'}};
    operacoes.preencher_bordas = {@preencher_bordas, {'n', 'modo', 'constante'}};
    operacoes.convolucao = {@convolucao, {'kernel', borda{:}}};
    operacoes.filtro_media = {@filtro_media, {'n', borda{:}}};
    operacoes.filtro_mediana = {@filtro_mediana, {'n', 'modo'}};
    operacoes.contraste_adaptativo = {@contraste_adaptativo, {'c', 'n', 'modo'}};
    operacoes.bordas_roberts = {@bordas_roberts, borda};
    operacoes.bordas_sobel = {@bordas_sobel, borda};
    operacoes.bordas_kirsch = {@bordas_kirsch, borda};
    operacoes.bordas_laplaciano = {@bordas_laplaciano, {'vizinhanca', borda{:}}};
    operacoes.agucamento_laplaciano = {@agucamento_laplaciano, {'vizinhanca', borda{:}}};
    operacoes.high_boost = {@high_boost, {'k', 'n', borda{:}}};

    if ~isfield(operacoes, pedido.operacao)
        error('operacao desconhecida: %s', pedido.operacao);
    end

    operacao = operacoes.(pedido.operacao);
    funcao = operacao{1};
    nomes = operacao{2};

    argumentos = {};
    for i = 1:numel(nomes)
        nome = nomes{i};
        if strcmp(nome, 'imagem2')
            argumentos{end + 1} = ler_imagem(pedido.imagens, nome);
        elseif strcmp(nome, 'pesos')
            argumentos{end + 1} = im2double(ler_imagem(pedido.imagens, nome));
        elseif isfield(parametros, nome)
            argumentos{end + 1} = parametros.(nome);
        else
            break
        end
    end

    imagem = ler_imagem(pedido.imagens, 'imagem');
    resultado = funcao(imagem, argumentos{:});

    if strcmp(pedido.operacao, 'histograma')
        fid = fopen(fullfile(pedido.pasta, 'saida.json'), 'w');
        fputs(fid, jsonencode(resultado));
        fclose(fid);
        return
    end

    if isstruct(resultado)
        campo = 'final';
        if isfield(parametros, 'campo')
            campo = parametros.campo;
        end
        if ~isfield(resultado, campo) || ~isnumeric(resultado.(campo))
            error('campo invalido: %s', campo);
        end
        resultado = resultado.(campo);
    end

    if ndims(resultado) == 3
        indice = 1;
        if isfield(parametros, 'indice')
            indice = parametros.indice;
        end
        resultado = resultado(:, :, indice);
    end

    if ~isa(resultado, 'uint8')
        ajuste = 'saturar';
        if isfield(parametros, 'ajuste')
            ajuste = parametros.ajuste;
        end
        resultado = ajustar_intervalo(resultado, ajuste);
    end

    imwrite(resultado, fullfile(pedido.pasta, 'saida.png'));
end

function imagem = ler_imagem(imagens, nome)
    if ~isfield(imagens, nome)
        error('imagem ausente: %s', nome);
    end
    imagem = imread(imagens.(nome));
    if size(imagem, 3) == 3
        imagem = rgb2gray(imagem);
    end
end
