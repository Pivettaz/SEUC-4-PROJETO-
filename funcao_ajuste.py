# NEXT: descomentar e ajustar o import abaixo quando o arquivo de classificação ficar pronto
# from Classificacao_Estabilidade import classificacao_estabilidade (arquivo do rafa)

def ler_quantidade():
    return int(input("Quantidade de pressões: "))

def ler_pressao():
    return int(input("Digite a pressão em UCPs: "))

## dividi em 3 funcoes para ficar mais limpo o codigo, as funcoes de ler sao chamadas na funcao ajuste (principal)
def ajuste_pressao():
    quantidade = ler_quantidade()
    soma = 0
    menor_pressao = 99999 ## se conseguir otimizar essa parte da menor pressao, nao consegui pensar a nao ser em criar uma execucao fora com menor_pressao = pressao_ajustada
    for _ in range(quantidade):
        pressao = ler_pressao()
        if pressao > 150:
            pressao_ajustada = pressao * 1.08
        else:
            pressao_ajustada = pressao * 0.96
        soma += pressao_ajustada
        if pressao_ajustada < menor_pressao:
            menor_pressao = pressao_ajustada
        print(f"Pressão ajustada: {pressao_ajustada:.2f}UCPs")

        # NEXT: chamar classificacao_estabilidade(pressao_ajustada) e guardar zona
        # NEXT: contar zona_verde_cont e detectar travamento
        # NEXT: adicionar break caso zona vermelha + de 2 vezes
        # NEXT: media das pressoes 
    return quantidade, soma, menor_pressao

# NEXT EXTRA: maior pressão ajustada, acho um extra legal para colocar

ajuste_pressao() ## remover, sera chamada pelo menu.py
