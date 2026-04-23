from funcao_estabilidade import classificacao_estabilidade

def ler_quantidade():
    return int(input("Quantidade de pressões: "))

def ler_pressao():
    return int(input("Digite a pressão em UCPs: "))

## dividi em 3 funcoes para ficar mais limpo o codigo, as funcoes de ler sao chamadas na funcao ajuste (principal)
def ajuste_pressao():
    quantidade = ler_quantidade()
    soma = 0
    menor_pressao = 99999
    zona_verde = 0
    leituras_realizadas = 0
    zona_anterior = ""
    houve_travamento = 0 # se caso for 1, printar a qtde de leituras realizadas, oque não é pedido caso nao ocorra travamento
    for _ in range(quantidade):
        leituras_realizadas += 1
        pressao = ler_pressao()
        if pressao > 150:
            pressao_ajustada = pressao * 1.08
        else:
            pressao_ajustada = pressao * 0.96
        soma += pressao_ajustada
        if pressao_ajustada < menor_pressao:
            menor_pressao = pressao_ajustada
        print(f"Pressão ajustada: {pressao_ajustada:.2f}UCPs")
        zona = classificacao_estabilidade(pressao_ajustada)
        if zona == "Verde":
            zona_verde += 1
        if zona == "Vermelha" and zona_anterior == "Vermelha":
            houve_travamento = 1
            print("Protocolo de Travamento: duas leituras seguidas de pressões na zona vermelha")
            break
        zona_anterior = zona
    return quantidade, soma, menor_pressao, zona_verde, leituras_realizadas, houve_travamento

# NEXT EXTRA: maior pressão ajustada, acho um extra legal para colocar

ajuste_pressao() ## remover, sera chamada pelo menu.py
