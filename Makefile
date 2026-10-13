OCTAVE ?= octave --no-gui --no-window-system --quiet --norc
TEX := docs/relatorio.tex

.PHONY: help test lint fmt fmt-check check resultados report clean

help: ## Lista os alvos disponiveis
	@grep -E '^[a-zA-Z_-]+:.*?## ' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "  %-10s %s\n", $$1, $$2}'

test: ## Roda os testes unitarios
	$(OCTAVE) --eval "addpath('tests'); run_tests;"

lint: ## Analise estatica (mh_lint)
	mh_lint src tests gerar_resultados.m

fmt: ## Formata o codigo (mh_style --fix)
	mh_style --fix src tests gerar_resultados.m || mh_style src tests gerar_resultados.m

fmt-check: ## Verifica formatacao sem alterar arquivos
	mh_style src tests gerar_resultados.m

check: fmt-check lint test ## Formatacao + lint + testes

resultados: ## Gera as imagens de resultado de todas as operacoes
	$(OCTAVE) --eval "gerar_resultados"

report: ## Compila o relatorio em PDF
	latexmk -cd -pdf -jobname=relatorio -interaction=nonstopmode -halt-on-error $(TEX)

clean: ## Remove artefatos do LaTeX
	latexmk -cd -c -jobname=relatorio $(TEX)
