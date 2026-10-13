%!shared f1, f2
%! f1 = uint8([0 100]);
%! f2 = uint8([200 50]);

%!assert (dissolve_uniforme(f1, f2, 0), f1)
%!assert (dissolve_uniforme(f1, f2, 1), f2)

%!test
%! assert(dissolve_uniforme(f1, f2, 0.25), uint8([50 88]));

%!test
%! assert(dissolve_uniforme(f1, f2, 0.5), uint8([100 75]));

%!test
%! assert(dissolve_uniforme(uint8(3), uint8(3), 0.5), uint8(3));

%!test
%! a = uint8([0 0; 255 255]);
%! b = uint8([255 0; 0 255]);
%! g = dissolve_uniforme(a, b, 0.5);
%! assert(g, uint8([128 0; 128 255]));
%! assert(class(g), 'uint8');

%!error dissolve_uniforme(uint8([1 2]), uint8([1 2 3]), 0.5)
