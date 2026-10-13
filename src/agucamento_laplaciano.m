function r = agucamento_laplaciano(imagem, vizinhanca, varargin)
    if nargin < 2
        vizinhanca = 4;
    end

    bordas = bordas_laplaciano(imagem, vizinhanca, varargin{:});

    r.laplaciano = bordas.resposta;
    r.laplaciano_visual = ajustar_intervalo(r.laplaciano, 'normalizar');
    r.final = ajustar_intervalo(double(imagem) - r.laplaciano);
end
