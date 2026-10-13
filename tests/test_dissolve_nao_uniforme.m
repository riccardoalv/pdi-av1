%!shared f1, f2
%! f1 = uint8([0 100]);
%! f2 = uint8([200 50]);

%!test
%! assert(dissolve_nao_uniforme(f1, f2, [0 1]), uint8([0 50]));

%!test
%! assert(dissolve_nao_uniforme(f1, f2, [0.25 0.25]), dissolve_uniforme(f1, f2, 0.25));

%!test
%! a = uint8(zeros(2, 3));
%! b = uint8(255 * ones(2, 3));
%! pesos = repmat([0 0.5 1], 2, 1);
%! assert(dissolve_nao_uniforme(a, b, pesos), uint8([0 128 255; 0 128 255]));

%!test
%! a = uint8([100 100; 100 100]);
%! b = uint8([200 200; 200 200]);
%! pesos = [0 0.5; 0.25 1];
%! assert(dissolve_nao_uniforme(a, b, pesos), uint8([100 150; 125 200]));

%!test
%! assert(class(dissolve_nao_uniforme(f1, f2, [0.5 0.5])), 'uint8');

%!error dissolve_nao_uniforme(f1, f2, [0 0.5 1])
%!error dissolve_nao_uniforme(f1, uint8([1 2 3]), [0 1])
