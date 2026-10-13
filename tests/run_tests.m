function ok = run_tests(alvo)
    if nargin < 1
        alvo = '';
    end

    raiz = fileparts(fileparts(mfilename('fullpath')));
    addpath(fullfile(raiz, 'src'));

    arquivos = [listar_m(fullfile(raiz, 'src')); listar_m(fullfile(raiz, 'tests'))];

    total = 0;
    passou = 0;
    xfail = 0;
    falhas = {};
    for i = 1:numel(arquivos)
        arq = arquivos{i};
        [~, nome] = fileparts(arq);
        if ~isempty(alvo) && isempty(strfind(nome, alvo))
            continue
        end
        if ~tem_testes(arq)
            continue
        end
        log = [tempname() '.log'];
        fid = fopen(log, 'w');
        [n, nmax, nxfail] = test(arq, 'quiet', fid);
        fclose(fid);
        total = total + nmax;
        passou = passou + n;
        xfail = xfail + nxfail;
        if n + nxfail < nmax
            falhas{end + 1} = arq;
            printf('%s', fileread(log));
        end
        delete(log);
        printf('  %-40s %3d/%-3d', nome, n, nmax);
        if nxfail > 0
            printf('  (%d pendente(s))', nxfail);
        end
        printf('\n');
    end

    printf('\nResumo: %d/%d testes passaram, %d pendente(s) (xtest).\n', passou, total, xfail);
    ok = isempty(falhas);
    if ~ok
        printf('Arquivos com falha:\n');
        printf('  %s\n', falhas{:});
    end

    if ~isguirunning() && ~ok
        exit(1);
    end
end

function lista = listar_m(pasta)
    lista = {};
    if ~exist(pasta, 'dir')
        return
    end
    itens = dir(pasta);
    for i = 1:numel(itens)
        it = itens(i);
        if any(strcmp(it.name, {'.', '..'}))
            continue
        end
        caminho = fullfile(pasta, it.name);
        if it.isdir
            lista = [lista; listar_m(caminho)];
        elseif numel(it.name) > 2 && strcmp(it.name(end - 1:end), '.m')
            lista{end + 1, 1} = caminho;
        end
    end
end

function sim = tem_testes(arq)
    sim = ~isempty(regexp(fileread(arq), '^%!', 'once', 'lineanchors'));
end
