%!test
%! f = uint8([0 25 50 100 200 225 255]);
%! assert(alargamento_contraste(f, 50, 20, 200, 230), uint8([0 10 20 90 230 241 255]));

%!test
%! f = uint8(0:255);
%! assert(alargamento_contraste(f, 50, 50, 200, 200), f);

%!test
%! f = uint8(0:255);
%! assert(alargamento_contraste(f, 128, 0, 128, 255), limiarizacao(f, 128));

%!test
%! f = uint8([0 100 200 255]);
%! assert(alargamento_contraste(f, 0, 30, 200, 230), uint8([0 + 30, 130, 230, 255]));

%!test
%! f = uint8([0 50 150 255]);
%! assert(alargamento_contraste(f, 50, 20, 255, 200), uint8([0 20 108 200]));

%!test
%! g = double(alargamento_contraste(uint8([100 110]), 50, 20, 200, 230));
%! assert(g(2) - g(1) > 10);

%!test
%! g = double(alargamento_contraste(uint8(0:255), 80, 30, 160, 220));
%! assert(all(diff(g) >= 0));

%!test
%! g = alargamento_contraste(uint8([0 25; 100 225]), 50, 20, 200, 230);
%! assert(g, uint8([0 10; 90 241]));
%! assert(class(g), 'uint8');
