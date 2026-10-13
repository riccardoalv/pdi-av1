%!shared f
%! f = [10 20 30; 40 50 60; 70 80 90];

%!test
%! r = bordas_sobel(f);
%! assert(r.gx(2, 2), -80);
%! assert(r.gy(2, 2), -240);
%! assert(r.magnitude(2, 2), sqrt(64000), 1e-12);
%! assert(r.final(2, 2), uint8(253));

%!test
%! d = [0 0 100 100; 0 0 100 100; 0 0 100 100; 0 0 100 100];
%! r = bordas_sobel(d, 'repetir');
%! assert(r.gy, zeros(4));
%! assert(abs(r.gx(2, 2)), 400);
%! assert(r.gx(2, 1), 0);

%!test
%! d = [0 0 100 100; 0 0 100 100; 0 0 100 100; 0 0 100 100]';
%! r = bordas_sobel(d, 'repetir');
%! assert(r.gx, zeros(4));
%! assert(abs(r.gy(2, 2)), 400);

%!test
%! r = bordas_sobel(77 * ones(5), 'repetir');
%! assert(r.final, uint8(zeros(5)));

%!test
%! r = bordas_sobel(uint8(magic(6)), 'repetir');
%! assert(class(r.final), 'uint8');
%! assert(size(r.magnitude), [6 6]);
