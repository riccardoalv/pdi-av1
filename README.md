# PDI · AV1

Biblioteca em GNU Octave para processamento de imagens em escala de cinza (8 bits).
Enunciado: `docs/av1.pdf`. Relatório: `docs/relatorio.pdf`.

```sh
nix develop       # octave, miss_hit, make, latex
make test         # testes unitarios
make check        # estilo + lint + testes
make resultados   # gera as imagens de resultado em resultados/
make report       # compila docs/relatorio.pdf
```

- `src/`: a biblioteca (uma funcao por arquivo)
- `tests/`: testes unitarios e `run_tests.m`
- `gerar_resultados.m`: aplica as operacoes as imagens de `images/`
- `images/`: imagens de entrada
- `resultados/`: imagens produzidas
- `docs/`: enunciado, template e relatorio
