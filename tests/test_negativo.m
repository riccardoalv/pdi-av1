%!test
%! assert(negativo(uint8([0 100 200 255])), uint8([255 155 55 0]));

%!test
%! f = uint8([0 64; 128 255]);
%! assert(negativo(f), uint8([255 191; 127 0]));

%!test
%! assert(negativo(uint8(0:255)), uint8(255:-1:0));

%!test
%! f = uint8(magic(6) * 7);
%! assert(negativo(negativo(f)), f);

%!test
%! g = negativo(uint8(ones(3, 5) * 10));
%! assert(class(g), 'uint8');
%! assert(size(g), [3 5]);
