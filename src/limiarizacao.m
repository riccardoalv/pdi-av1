function g = limiarizacao(imagem, limiar)

    imagem(imagem < limiar) = 0;
    imagem(imagem >= limiar) = 255;
    g = imagem;
end
