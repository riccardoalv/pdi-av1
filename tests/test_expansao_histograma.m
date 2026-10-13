%!test
%! assert(expansao_histograma(uint8([50 100 150])), uint8([0 128 255]));

%!test
%! assert(expansao_histograma(uint8([100 125 200])), uint8([0 64 255]));

%!test
%! f = uint8([0 30 128 255]);
%! assert(expansao_histograma(f), f);

%!test
%! f = uint8(70 * ones(2, 3));
%! assert(expansao_histograma(f), f);

%!test
%! g = expansao_histograma(uint8([90 100; 110 120]));
%! assert(min(g(:)), uint8(0));
%! assert(max(g(:)), uint8(255));
%! assert(class(g), 'uint8');

%!test
%! g = double(expansao_histograma(uint8(60:5:180)));
%! assert(all(diff(g) > 0));
