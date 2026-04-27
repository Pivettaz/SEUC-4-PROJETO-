from funcao_estabilidade import classificacao_estabilidade
from validacoes import validacao_opcao

def ler_quantidade():
    return int(input("\nQuantidade de pressões: "))

def ler_pressao():
    return float(input("\nDigite a pressão em UCPs: "))

def ajuste_pressao():
    quantidade = ler_quantidade()
    soma = 0
    menor_pressao = float("inf")
    zona_verde = 0
    leituras_realizadas = 0
    zona_anterior = ""
    houve_travamento = 0
    cont = 0

    for i in range(quantidade):
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

        if  i == quantidade - 1:
            print("\nLeituras do turno realizadas com sucesso!")
            break

        print("\n1 - Inserir pressão")
        print("2 - Métricas Parciais do Turno")

        opcao = validacao_opcao(1, 2)

        if opcao == 1:
            cont += 1
            continue
        else:
            cont += 1
            print("")
            print("\n=== MÉTRICAS PARCIAIS ===")
            print("Quantidade de pressões lidas: {}".format(cont))
            print("Média das pressões ajustadas: {:.2f}".format(media))
            print("Menor pressão ajustada: {:.2f}".format(menor_pressao))
            print("Porcentagem de leituras que ficaram na zona verde: {:.2f}%".format(porcentagem_verde))


    media = soma / leituras_realizadas
    porcentagem_verde = zona_verde * 100 / leituras_realizadas
    percentual_leituras = (leituras_realizadas / quantidade) * 100
    return menor_pressao, media, porcentagem_verde, percentual_leituras, houve_travamento, quantidade
