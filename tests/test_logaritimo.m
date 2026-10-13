%!shared c
%! c = 255 / log(256);

%!test
%! assert(logaritimo(uint8([0 15 255]), c), uint8([0 128 255]));

%!test
%! assert(logaritimo(uint8(1), c), uint8(32));

%!test
%! assert(logaritimo(uint8([0 255]), 1), uint8([0 6]));

%!test
%! g = logaritimo(uint8([0 15; 255 0]), c);
%! assert(g, uint8([0 128; 255 0]));

%!test
%! g = logaritimo(uint8(0:255), c);
%! assert(g(128) > 200);

%!test
%! g = double(logaritimo(uint8(0:255), c));
%! assert(all(diff(g) >= 0));

%!test
%! assert(class(logaritimo(uint8([1 2 3]), c)), 'uint8');
