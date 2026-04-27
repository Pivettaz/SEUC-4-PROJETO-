from funcao_estabilidade import classificacao_estabilidade

def ler_quantidade():
    return int(input("Quantidade de pressões: "))

def ler_pressao():
    return float(input("Digite a pressão em UCPs: "))

def ajuste_pressao():
    quantidade = ler_quantidade()
    soma = 0
    menor_pressao = float("inf")
    zona_verde = 0
    leituras_realizadas = 0
    zona_anterior = ""
    houve_travamento = 0
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
        zona = classificacao_estabilidade(pressao_ajustada)
        print(f"Pressão ajustada: {pressao_ajustada:.2f} UCPs | Zona: {zona}")
        if zona == "Verde":
            zona_verde += 1
        if zona == "Vermelha" and zona_anterior == "Vermelha":
            houve_travamento = 1
            print("Protocolo de Travamento: duas leituras seguidas de pressões na zona vermelha")
            break
        zona_anterior = zona
    media = soma / leituras_realizadas
    porcentagem_verde = zona_verde * 100 / leituras_realizadas
    percentual_leituras = (leituras_realizadas / quantidade) * 100
    return menor_pressao, media, porcentagem_verde, percentual_leituras, houve_travamento

