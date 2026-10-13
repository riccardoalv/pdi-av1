%!shared q
%! q = [10 10 10; 10 50 10; 10 10 10];

%!test
%! r = high_boost(q, 1, 3, 'repetir');
%! assert(r.suavizada(2, 2), 14);
%! assert(r.mascara(2, 2), 36);
%! assert(r.final(2, 2), uint8(86));

%!test
%! r = high_boost(q, 2, 3, 'repetir');
%! assert(r.final(2, 2), uint8(122));

%!test
%! r = high_boost(uint8(q), 0, 3, 'repetir');
%! assert(r.final, uint8(q));

%!test
%! c = uint8(120 * ones(5));
%! r = high_boost(c, 3, 3, 'repetir');
%! assert(r.final, c);

%!test
%! r1 = double(high_boost(q, 1, 3, 'repetir').final);
%! r3 = double(high_boost(q, 3, 3, 'repetir').final);
%! assert(r3(2, 2) > r1(2, 2));

%!test
%! r = high_boost(q, 1);
%! assert(r.final, high_boost(q, 1, 3, 'zero').final);

%!test
%! r = high_boost(uint8(magic(6)), 1.5, 5, 'repetir');
%! assert(class(r.final), 'uint8');
%! assert(size(r.final), [6 6]);
