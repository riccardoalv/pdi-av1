function r = bordas_laplaciano(imagem, vizinhanca, varargin)
    if nargin < 2
        vizinhanca = 4;
    end

    if vizinhanca == 8
        r.mascara = [1 1 1; 1 -8 1; 1 1 1];
    else
        r.mascara = [0 1 0; 1 -4 1; 0 1 0];
    end

    r.resposta = convolucao(imagem, r.mascara, varargin{:});
    r.final = ajustar_intervalo(r.resposta, 'modulo');
end
