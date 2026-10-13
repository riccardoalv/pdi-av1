function r = bordas_sobel(imagem, varargin)
    mascara_x = [-1 0 1; -2 0 2; -1 0 1];
    mascara_y = [-1 -2 -1; 0 0 0; 1 2 1];

    r.gx = convolucao(imagem, mascara_x, varargin{:});
    r.gy = convolucao(imagem, mascara_y, varargin{:});
    r.magnitude = sqrt(r.gx.^2 + r.gy.^2);
    r.final = ajustar_intervalo(r.magnitude);
end
