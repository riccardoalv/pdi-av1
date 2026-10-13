%!shared q
%! q = [10 10 10; 10 50 10; 10 10 10];

%!test
%! r = bordas_laplaciano(q, 4, 'repetir');
%! assert(r.resposta(2, 2), -160);
%! assert(r.final(2, 2), uint8(160));

%!test
%! r = bordas_laplaciano(q, 8, 'repetir');
%! assert(r.resposta(2, 2), -320);
%! assert(r.final(2, 2), uint8(255));

%!test
%! r = bordas_laplaciano([10 20 30; 40 50 60; 70 80 90], 4);
%! assert(r.resposta(2, 2), 0);

%!test
%! r = bordas_laplaciano(q);
%! assert(r.mascara, [0 1 0; 1 -4 1; 0 1 0]);

%!test
%! r = bordas_laplaciano(q, 8);
%! assert(sum(r.mascara(:)), 0);

%!test
%! r = bordas_laplaciano(66 * ones(4), 8, 'repetir');
%! assert(r.resposta, zeros(4));

%!test
%! r = bordas_laplaciano(uint8(magic(5)), 4, 'repetir');
%! assert(class(r.final), 'uint8');
%! assert(size(r.resposta), [5 5]);
