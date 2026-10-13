%!test
%! assert(potencia_gamma(uint8([0 64 128 255]), 1, 0.5), uint8([0 128 181 255]));

%!test
%! assert(potencia_gamma(uint8([0 64 128 255]), 1, 2), uint8([0 16 64 255]));

%!test
%! f = uint8([0 10 100 255]);
%! assert(potencia_gamma(f, 1, 1), f);

%!test
%! f = uint8([0 64 128; 255 64 0]);
%! assert(potencia_gamma(f, 1, 2), uint8([0 16 64; 255 16 0]));

%!test
%! f = uint8([64 128; 0 255]);
%! assert(potencia_gamma(f, 1, 2), uint8([16 64; 0 255]));

%!test
%! assert(potencia_gamma(uint8([0 64 128 255]), 2, 1), uint8([0 128 255 255]));

%!test
%! assert(class(potencia_gamma(uint8([1 2 3]), 1, 0.5)), 'uint8');

%!test
%! assert(factorial(4), 24);
