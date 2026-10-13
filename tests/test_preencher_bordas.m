%!test
%! f = [1 2; 3 4];
%! esperado = [1 1 2 2
%!             1 1 2 2
%!             3 3 4 4
%!             3 3 4 4];
%! assert(preencher_bordas(f, 3, 'repetir'), esperado);

%!test
%! f = [1 2 3; 4 5 6];
%! esperado = [1 1 1 2 3 3 3
%!             1 1 1 2 3 3 3
%!             1 1 1 2 3 3 3
%!             4 4 4 5 6 6 6
%!             4 4 4 5 6 6 6
%!             4 4 4 5 6 6 6];
%! assert(preencher_bordas(f, 5, 'repetir'), esperado);

%!test
%! assert(preencher_bordas(7, 3, 'repetir'), 7 * ones(3));

%!test
%! f = [1 2; 3 4];
%! esperado = [9 9 9 9
%!             9 1 2 9
%!             9 3 4 9
%!             9 9 9 9];
%! assert(preencher_bordas(f, 3, 'constante', 9), esperado);

%!test
%! f = [1 2 3];
%! esperado = [5 5 5 5 5 5 5
%!             5 5 5 5 5 5 5
%!             5 5 1 2 3 5 5
%!             5 5 5 5 5 5 5
%!             5 5 5 5 5 5 5];
%! assert(preencher_bordas(f, 5, 'constante', 5), esperado);

%!test
%! f = [1 2; 3 4];
%! esperado = [0 0 0 0
%!             0 1 2 0
%!             0 3 4 0
%!             0 0 0 0];
%! assert(preencher_bordas(f, 3, 'zero'), esperado);

%!test
%! f = magic(4);
%! assert(preencher_bordas(f, 5, 'constante', 0), preencher_bordas(f, 5, 'zero'));

%!test
%! f = rand(3, 4);
%! for k = [1 3 5 7]
%!   assert(size(preencher_bordas(f, k, 'repetir')), [3 + k - 1, 4 + k - 1]);
%!   assert(size(preencher_bordas(f, k, 'constante', 0)), [3 + k - 1, 4 + k - 1]);
%!   assert(size(preencher_bordas(f, k, 'zero')), [3 + k - 1, 4 + k - 1]);
%! end

%!test
%! f = magic(5);
%! k = 7;
%! p = (k - 1) / 2;
%! for modo = {'repetir', 'zero'}
%!   R = preencher_bordas(f, k, modo{1});
%!   assert(R(p + 1:end - p, p + 1:end - p), f);
%! end
%! R = preencher_bordas(f, k, 'constante', 42);
%! assert(R(p + 1:end - p, p + 1:end - p), f);

%!test
%! f = magic(3);
%! assert(preencher_bordas(f, 1, 'repetir'), f);
%! assert(preencher_bordas(f, 1, 'constante', 9), f);
%! assert(preencher_bordas(f, 1, 'zero'), f);

%!test
%! f = uint8([0 128; 200 255]);
%! assert(double(preencher_bordas(f, 3, 'repetir')), ...
%!        double(preencher_bordas(double(f), 3, 'repetir')));
%! assert(double(preencher_bordas(f, 3, 'zero')), ...
%!        double(preencher_bordas(double(f), 3, 'zero')));

%!test
%! f = [1 2; 3 4];
%! esperado = [0 0 0 0 0 0
%!             0 0 1 2 0 0
%!             0 0 3 4 0 0
%!             0 0 0 0 0 0];
%! assert(preencher_bordas(f, [3 5], 'zero'), esperado);

%!test
%! f = [1 2 3];
%! esperado = [1 2 3
%!             1 2 3
%!             1 2 3
%!             1 2 3
%!             1 2 3];
%! assert(preencher_bordas(f, [5 1], 'repetir'), esperado);

%!test
%! f = [1 2; 3 4];
%! esperado = [7 1 2 7
%!             7 3 4 7];
%! assert(preencher_bordas(f, [1 3], 'constante', 7), esperado);

%!test
%! f = magic(4);
%! assert(preencher_bordas(f, [5 5], 'repetir'), preencher_bordas(f, 5, 'repetir'));
%! assert(preencher_bordas(f, [3 3], 'zero'), preencher_bordas(f, 3, 'zero'));

%!test
%! f = rand(4, 6);
%! assert(size(preencher_bordas(f, [3 7], 'repetir')), [6 12]);
%! assert(size(preencher_bordas(f, [7 3], 'constante', 0)), [10 8]);
%! assert(size(preencher_bordas(f, [1 5], 'zero')), [4 10]);

%!test
%! f = magic(4);
%! assert(preencher_bordas(f, 3, 'espelhar'), preencher_bordas(f, 3, 'zero'));

%!test
%! f = [1 2; 3 4];
%! assert(preencher_bordas(f, 2, 'zero'), [1 2 0; 3 4 0; 0 0 0]);

%!test
%! f = [1 2; 3 4];
%! assert(preencher_bordas(f, 2, 'repetir'), [1 2 2; 3 4 4; 3 4 4]);

%!test
%! f = [1 2; 3 4];
%! assert(preencher_bordas(f, [2 3], 'constante', 9), [9 1 2 9; 9 3 4 9; 9 9 9 9]);

%!test
%! f = [1 2 3];
%! assert(preencher_bordas(f, [1 4], 'zero'), [0 1 2 3 0 0]);

%!test
%! f = rand(3, 5);
%! for k = {[2 2], [4 4], [2 3], [3 4], [1 2]}
%!   assert(size(preencher_bordas(f, k{1}, 'repetir')), [3 + k{1}(1) - 1, 5 + k{1}(2) - 1]);
%! end

%!test
%! f = uint8([1 2; 3 4]);
%! assert(class(preencher_bordas(f, 3, 'repetir')), 'uint8');
%! assert(class(preencher_bordas(f, 3, 'zero')), 'uint8');
%! assert(class(preencher_bordas(f, 3, 'constante', 9)), 'uint8');

%!test
%! f = [0.5 1.5; 2.5 3.5];
%! assert(class(preencher_bordas(f, 3, 'zero')), 'double');
%! assert(preencher_bordas(f, 3, 'constante', 0.25)(1, 1), 0.25);
