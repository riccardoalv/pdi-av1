%!test
%! assert(ajustar_intervalo([-50 0 100 255 300], 'saturar'), uint8([0 0 100 255 255]));

%!test
%! r = [0 1 127 128 254 255];
%! assert(ajustar_intervalo(r, 'saturar'), uint8(r));

%!test
%! assert(ajustar_intervalo([100.4 100.5 100.6], 'saturar'), uint8([100 101 101]));

%!test
%! r = [-10 50 400];
%! assert(ajustar_intervalo(r), ajustar_intervalo(r, 'saturar'));

%!test
%! assert(ajustar_intervalo([-50 100 300], 'normalizar'), uint8([0 109 255]));

%!test
%! assert(ajustar_intervalo([50 100 150], 'normalizar'), uint8([0 128 255]));

%!test
%! assert(ajustar_intervalo(70 * ones(2), 'normalizar'), uint8(70 * ones(2)));
%! assert(ajustar_intervalo(-5 * ones(2), 'normalizar'), uint8(zeros(2)));

%!test
%! assert(ajustar_intervalo([-255 -50 0 50 300], 'modulo'), uint8([255 50 0 50 255]));

%!test
%! r = rand(3, 4) * 600 - 300;
%! for modo = {'saturar', 'normalizar', 'modulo'}
%!   g = ajustar_intervalo(r, modo{1});
%!   assert(class(g), 'uint8');
%!   assert(size(g), [3 4]);
%! end

%!test
%! g = convolucao([0 255 0], [-1 3 -1]);
%! assert(ajustar_intervalo(g, 'saturar'), uint8([0 255 0]));
%! assert(ajustar_intervalo(g, 'normalizar'), uint8([0 255 0]));
%! assert(ajustar_intervalo(g, 'modulo'), uint8([255 255 255]));

%!test
%! r = [-50 100.6 300];
%! assert(ajustar_intervalo(r, 'desconhecido'), ajustar_intervalo(r, 'saturar'));
