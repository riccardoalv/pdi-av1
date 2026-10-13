%!shared f
%! f = [10 20 30; 40 50 60; 70 80 90];

%!test
%! r = bordas_roberts(f);
%! assert(r.gx(2, 2), 40);
%! assert(r.gy(2, 2), 20);
%! assert(r.magnitude(2, 2), sqrt(40 ^ 2 + 20 ^ 2), 1e-12);
%! assert(r.final(2, 2), uint8(45));

%!test
%! r = bordas_roberts(77 * ones(4), 'repetir');
%! assert(r.gx, zeros(4));
%! assert(r.gy, zeros(4));
%! assert(r.final, uint8(zeros(4)));

%!test
%! r = bordas_roberts(uint8(magic(5)), 'repetir');
%! assert(size(r.gx), [5 5]);
%! assert(size(r.final), [5 5]);
%! assert(class(r.final), 'uint8');

%!test
%! r = bordas_roberts(f);
%! assert(r.magnitude, sqrt(r.gx .^ 2 + r.gy .^ 2));
