%!test
%! f = uint8([0 0 1 1; 0 0 1 1; 2 2 3 3; 3 3 3 3]);
%! esperado = uint8([ 64  64 128 128
%!                    64  64 128 128
%!                   159 159 255 255
%!                   255 255 255 255]);
%! assert(equalizacao_histograma(f), esperado);

%!test
%! g = equalizacao_histograma(uint8([10 20 30 40]));
%! assert(max(g(:)), uint8(255));

%!test
%! assert(equalizacao_histograma(uint8([10 20 30 40])), uint8([64 128 191 255]));

%!test
%! g = double(equalizacao_histograma(uint8([5 5 9 9 9 200])));
%! assert(g(1), g(2));
%! assert(g(3), g(5));
%! assert(g(1) < g(3) && g(3) < g(6));

%!test
%! assert(equalizacao_histograma(uint8(70 * ones(2))), uint8(255 * ones(2)));

%!test
%! f = uint8(0:255);
%! g = equalizacao_histograma(f);
%! assert(max(abs(double(g) - double(f))) <= 1);

%!test
%! g = equalizacao_histograma(uint8(magic(5)));
%! assert(class(g), 'uint8');
%! assert(size(g), [5 5]);
