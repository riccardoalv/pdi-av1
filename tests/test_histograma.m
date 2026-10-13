%!test
%! h = histograma(uint8([0 0 3 255]));
%! assert(h(1), 2);
%! assert(h(4), 1);
%! assert(h(256), 1);
%! assert(sum(h), 4);

%!test
%! assert(size(histograma(uint8(magic(4)))), [1 256]);

%!test
%! assert(histograma(uint8(0:255)), ones(1, 256));

%!test
%! f = uint8([0 0 1 1; 0 0 1 1; 2 2 3 3; 3 3 3 3]);
%! h = histograma(f);
%! assert(h(1:4), [4 4 2 6]);
%! assert(sum(h), 16);

%!test
%! h = histograma(uint8(70 * ones(3, 5)));
%! assert(h(71), 15);
%! assert(sum(h), 15);
