%!test
%! assert(limiarizacao(uint8([10 127 128 250]), 128), uint8([0 0 255 255]));

%!test
%! f = uint8([0 50; 100 200]);
%! assert(limiarizacao(f, 100), uint8([0 0; 255 255]));

%!test
%! assert(limiarizacao(uint8([0 1 255]), 0), uint8([255 255 255]));

%!test
%! assert(limiarizacao(uint8([0 1 255]), 256), uint8([0 0 0]));

%!test
%! g = limiarizacao(uint8(0:255), 77);
%! assert(all(g == 0 | g == 255));
%! assert(sum(g == 255), 255 - 77 + 1);

%!test
%! assert(class(limiarizacao(uint8([1 2 3]), 2)), 'uint8');
