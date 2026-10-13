function r = high_boost(imagem, k, n, varargin)
    if nargin < 3
        n = 3;
    end

    f = double(imagem);

    r.suavizada = double(filtro_media(f, n, varargin{:}));
    r.mascara = f - r.suavizada;
    r.final = ajustar_intervalo(f + k * r.mascara);
end
