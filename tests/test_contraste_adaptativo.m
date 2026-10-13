%!shared q
%! q = uint8([10 10 10; 10 50 10; 10 10 10]);

%!test
%! g = contraste_adaptativo(q, 10, 3, 'repetir');
%! assert(g(2, 2), uint8(43));

%!test
%! assert(contraste_adaptativo(q, 10, 3, 'repetir'), uint8([11 11 11; 11 43 11; 11 11 11]));

%!test
%! sigma = sqrt(3300 / 9 - (130 / 9) ^ 2);
%! g = contraste_adaptativo(q, sigma, 3, 'repetir');
%! assert(g(2, 2), uint8(50));

%!test
%! g1 = double(contraste_adaptativo(q, 5, 3, 'repetir'));
%! g2 = double(contraste_adaptativo(q, 20, 3, 'repetir'));
%! assert(g2(2, 2) - g2(1, 1) > g1(2, 2) - g1(1, 1));

%!test
%! c = uint8(80 * ones(5));
%! assert(contraste_adaptativo(c, 10, 3, 'repetir'), c);

%!test
%! g = contraste_adaptativo(uint8(magic(6) * 7), 20, 5, 'repetir');
%! assert(class(g), 'uint8');
%! assert(size(g), [6 6]);
