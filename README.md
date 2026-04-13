## SEUC-4
## Sistema de Escoamento de Unidades de Carga - Refinaria Delta-9

Projeto desenvolvido para a disciplina de Algoritmos de Programacao, Projetos e Computacao (APPC - Pratica).

## Descricao do projeto
O SEUC-4 foi criado para monitorar o Duto Principal de Escoamento (DPE) da Refinaria Delta-9. Durante um turno, o sistema recebe leituras de pressao hidrodinamica em UPC, processa cada valor imediatamente, aplica o ajuste termico, classifica a estabilidade do duto e verifica se existe risco de travamento por duas leituras consecutivas na Zona Vermelha.

A proposta do sistema segue a ideia do enunciado: trabalhar de forma leve, sem depender do armazenamento de todo o historico de leituras, atualizando apenas os indicadores essenciais de seguranca e desempenho.

## Objetivo
Desenvolver um programa em Python capaz de:
- receber a quantidade total de leituras do turno;
- processar cada leitura imediatamente;
- aplicar ajuste termico;
- classificar cada leitura em Zona Verde, Amarela ou Vermelha;
- interromper o escoamento ao detectar duas leituras consecutivas na Zona Vermelha;
- exibir metricas finais do turno.

## Regras de negocio
### Ajuste termico
- Leituras acima de 150 UPC recebem acrescimo de 8%.
- Leituras menores ou iguais a 150 UPC recebem reducao de 4%.

### Classificacao
- Zona Verde: entre 120 e 180 UPC, apos o ajuste.
- Zona Amarela: fora da Zona Verde, mas abaixo da faixa critica.
- Zona Vermelha: faixa critica.

## Funcionalidades obrigatorias implementadas
- leitura do total de medicoes do turno;
- leitura individual de cada pressao;
- ajuste automatico da pressao;
- classificacao por zona;
- deteccao de duas leituras consecutivas na Zona Vermelha;
- calculo da media das pressões ajustadas;
- identificacao da menor pressao registrada;
- calculo do percentual de leituras na Zona Verde;
- exibicao do percentual de leituras realizadas em caso de travamento.

## Como executar
1. Abrir o arquivo `.py` no IDLE do Python.org ou no VS Code.
2. Executar o programa.
3. Informar a quantidade total de leituras do turno.
4. Digitar cada leitura solicitada pelo sistema.
5. Ao final, analisar o resumo operacional exibido na tela.

## Compatibilidade
Projeto compativel com:
- Python 3
- IDLE do Python.org
- Visual Studio Code
