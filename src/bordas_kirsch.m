function r = bordas_kirsch(imagem, varargin)
    r.nomes = {'N', 'NE', 'E', 'SE', 'S', 'SO', 'O', 'NO'};
    r.mascaras = {[5 5 5; -3 0 -3; -3 -3 -3]
                  [-3 5 5; -3 0 5; -3 -3 -3]
                  [-3 -3 5; -3 0 5; -3 -3 5]
                  [-3 -3 -3; -3 0 5; -3 5 5]
                  [-3 -3 -3; -3 0 -3; 5 5 5]
                  [-3 -3 -3; 5 0 -3; 5 5 -3]
                  [5 -3 -3; 5 0 -3; 5 -3 -3]
                  [5 5 -3; 5 0 -3; -3 -3 -3]};

    [m, n] = size(imagem);
    r.respostas = zeros(m, n, 8);
    for k = 1:8
        r.respostas(:, :, k) = convolucao(imagem, r.mascaras{k}, varargin{:});
    end

    [r.maximo, r.direcao] = max(r.respostas, [], 3);
    r.final = ajustar_intervalo(r.maximo);
end
