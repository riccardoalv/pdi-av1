%!shared d
%! d = [0 0 100; 0 0 100; 0 0 100];

%!test
%! r = bordas_kirsch(d, 'repetir');
%! assert(squeeze(r.respostas(2, 2, :))', [-100 -900 -900 -900 -100 700 1500 700]);

%!test
%! r = bordas_kirsch(d, 'repetir');
%! assert(r.maximo(2, 2), 1500);
%! assert(r.direcao(2, 2), 7);
%! assert(r.final(2, 2), uint8(255));

%!test
%! r = bordas_kirsch(d, 'repetir');
%! assert(r.maximo, max(r.respostas, [], 3));

%!test
%! r = bordas_kirsch(50 * ones(4), 'repetir');
%! assert(r.respostas, zeros(4, 4, 8));
%! assert(r.final, uint8(zeros(4)));

%!test
%! r = bordas_kirsch(d);
%! assert(numel(r.mascaras), 8);
%! for k = 1:8
%!   assert(sum(r.mascaras{k}(:)), 0);
%!   assert(sort(r.mascaras{k}(:))', [-3 -3 -3 -3 -3 0 5 5 5]);
%! end

%!test
%! r = bordas_kirsch(uint8(magic(5)), 'repetir');
%! assert(size(r.respostas), [5 5 8]);
%! assert(class(r.final), 'uint8');
