%!shared f
%! f = uint8([10 20 30; 40 50 60; 70 80 90]);

%!test
%! assert(filtro_mediana(f, 3, 'zero'), uint8([0 20 0; 20 50 30; 0 50 0]));

%!test
%! assert(filtro_mediana(f, 3, 'repetir'), uint8([20 30 30; 40 50 60; 70 70 80]));

%!test
%! assert(filtro_mediana(f, 1, 'zero'), f);

%!test
%! p = uint8(100 * ones(3));
%! p(2, 2) = 255;
%! g = filtro_mediana(p, 3, 'repetir');
%! assert(g(2, 2), uint8(100));

%!test
%! p = uint8(100 * ones(5));
%! p(2, 2) = 0;
%! p(4, 3) = 255;
%! p(3, 5) = 255;
%! assert(filtro_mediana(p, 3, 'repetir'), uint8(100 * ones(5)));

%!test
%! degrau = uint8([0 0 255 255; 0 0 255 255; 0 0 255 255]);
%! assert(filtro_mediana(degrau, 3, 'repetir'), degrau);

%!test
%! a = zeros(3);
%! a([1 3 7 9]) = 90;
%! b = zeros(3);
%! b(2, 2) = 90;
%! ga = filtro_mediana(a, 3, 'zero');
%! gb = filtro_mediana(b, 3, 'zero');
%! gab = filtro_mediana(a + b, 3, 'zero');
%! assert(ga(2, 2) + gb(2, 2), uint8(0));
%! assert(gab(2, 2), uint8(90));

%!test
%! g = filtro_mediana(uint8(magic(7)), 5, 'zero');
%! assert(class(g), 'uint8');
%! assert(size(g), [7 7]);
