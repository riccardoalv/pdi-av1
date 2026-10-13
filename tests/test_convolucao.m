%!shared f, h1
%! f = [10 20 30
%!      40 50 60
%!      70 80 90];
%! h1 = [0 0 0
%!       0 1 0
%!       0 0 -1];

%!test
%! assert(convolucao(f, [0 0 0; 0 1 0; 0 0 0]), f);

%!test
%! esperado = [10 20 30
%!             40 40 40
%!             70 40 40];
%! assert(convolucao(f, h1, 'zero', 0), esperado);

%!test
%! esperado = [ 0 10 10
%!             30 40 40
%!             30 40 40];
%! assert(convolucao(f, h1, 'repetir', 0), esperado);

%!test
%! assert(convolucao(f, h1, 'zero', 128), convolucao(f, h1, 'zero', 0) + 128);

%!test
%! g = convolucao(f, h1);
%! assert(g(2, 2), 40);

%!test
%! assert(convolucao(f, h1), convolucao(f, h1, 'zero', 0));

%!test
%! assert(convolucao([1 2 3], [1 0 0]), [2 3 0]);

%!test
%! assert(convolucao([1; 2; 3], [1; 0; 0]), [2; 3; 0]);

%!test
%! assert(size(convolucao(rand(6, 8), ones(5, 3))), [6 8]);

%!test
%! g = convolucao(uint8([200 200 200]), [1 1 1]);
%! assert(class(g), 'double');
%! assert(g, [400 600 400]);

%!test
%! assert(convolucao(5 * ones(4), ones(3) / 9, 'repetir', 0), 5 * ones(4), 1e-12);

%!test
%! assert(convolucao([1 2 3], [1 1 1], 'constante', 0, 10), [13 6 15]);

%!test
%! c = 1;
%! d = 1;
%! h = [-c -c -c; -c 8 * c + d -c; -c -c -c];
%! assert(convolucao(50 * ones(4), h, 'repetir', 0), 50 * ones(4));

%!test
%! c = 2;
%! d = 3;
%! h = [-c -c -c; -c 8 * c + d -c; -c -c -c];
%! assert(convolucao(50 * ones(4), h, 'repetir', 0), 150 * ones(4));

%!test
%! h2 = [0 0 2; 0 -1 0; -1 0 0];
%! assert(convolucao(50 * ones(4), h2, 'repetir', 128), 128 * ones(4));

%!test
%! h4 = [0 -1 0; -1 -4 -1; 0 -1 0];
%! assert(convolucao(10 * ones(3), h4, 'repetir', 0), -80 * ones(3));

%!test
%! h = [-1 -1 -1; -1 9 -1; -1 -1 -1];
%! g = convolucao(f, h);
%! assert(g(2, 2), 50);

%!test
%! a = magic(4);
%! b = rand(4);
%! h = [1 2 0; -1 0 3; 0 1 -2];
%! assert(convolucao(a + b, h), convolucao(a, h) + convolucao(b, h), 1e-10);

%!test
%! h = [0 1 0; 1 -4 1; 0 1 0];
%! assert(convolucao(f, 3 * h), 3 * convolucao(f, h));

%!test
%! h = [1 2 1; 2 4 2; 1 2 1];
%! assert(convolucao(f, h), convolucao(f, h(end:-1:1, end:-1:1)));

%!test
%! g = convolucao([0 255 0], [-1 3 -1]);
%! assert(g, [-255 765 -255]);

%!test
%! assert(convolucao([1 2 3], [1 1]), [3 5 3]);

%!test
%! assert(convolucao([1 2 3], [1 0]), [2 3 0]);

%!test
%! assert(convolucao([1 2 3], [0 1]), [1 2 3]);

%!test
%! f = [10 20 30; 40 50 60; 70 80 90];
%! g = convolucao(f, [1 0; 0 -1]);
%! assert(g(2, 2), 90 - 50);
%! assert(g(1, 1), 50 - 10);

%!test
%! assert(size(convolucao(rand(5, 6), ones(2, 4))), [5 6]);
