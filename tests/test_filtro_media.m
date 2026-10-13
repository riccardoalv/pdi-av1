%!shared f
%! f = uint8([10 20 30; 40 50 60; 70 80 90]);

%!test
%! g = filtro_media(f, 3, 'zero');
%! assert(g(2, 2), uint8(50));
%! assert(g(1, 1), uint8(13));

%!test
%! g = filtro_media(f, 3, 'repetir');
%! assert(g(1, 1), uint8(23));
%! assert(g(2, 2), uint8(50));

%!test
%! assert(filtro_media(f, 3, 'zero'), uint8([13 23 18; 30 50 37; 27 43 31]));

%!test
%! assert(filtro_media(f, 3), filtro_media(f, 3, 'zero'));

%!test
%! assert(filtro_media(f, 1), f);

%!test
%! c = uint8(77 * ones(6));
%! assert(filtro_media(c, 5, 'repetir'), c);

%!test
%! p = uint8(100 * ones(3));
%! p(2, 2) = 255;
%! g = filtro_media(p, 3, 'repetir');
%! assert(g(2, 2), uint8(117));

%!test
%! g = filtro_media(uint8(magic(7)), 5);
%! assert(class(g), 'uint8');
%! assert(size(g), [7 7]);
