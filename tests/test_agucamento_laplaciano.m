%!shared q
%! q = [10 10 10; 10 50 10; 10 10 10];

%!test
%! r = agucamento_laplaciano(q, 4, 'repetir');
%! assert(r.laplaciano(2, 2), -160);
%! assert(r.final(2, 2), uint8(210));

%!test
%! r = agucamento_laplaciano(q, 4, 'repetir');
%! assert(r.final, ajustar_intervalo(q - r.laplaciano));

%!test
%! r = agucamento_laplaciano(q, 8, 'repetir');
%! h = [-1 -1 -1; -1 9 -1; -1 -1 -1];
%! assert(r.final, ajustar_intervalo(convolucao(q, h, 'repetir')));

%!test
%! c = uint8(90 * ones(4));
%! r = agucamento_laplaciano(c, 4, 'repetir');
%! assert(r.final, c);

%!test
%! r = agucamento_laplaciano(q, 4, 'repetir');
%! assert(min(r.laplaciano_visual(:)), uint8(0));
%! assert(max(r.laplaciano_visual(:)), uint8(255));

%!test
%! r = agucamento_laplaciano(uint8(magic(5)), 8, 'repetir');
%! assert(class(r.final), 'uint8');
%! assert(class(r.laplaciano_visual), 'uint8');
%! assert(size(r.laplaciano), [5 5]);
