from funcao_estabilidade import classificacao_estabilidade
from validacoes import validacao_opcao
from sub_menus import menu_pressoes
from metricas import exibir_metricas_parciais

def ler_quantidade():
    executando_leitura = 1
    while executando_leitura == 1:
        try:
            opcao = int(input("Digite quantas leituras serão realizadas neste turno: "))
            executando_leitura = 0
        except ValueError:
            print("\nEntrada inválida. Por favor, digite um número inteiro")
    return opcao

def ler_pressao():
    executando_leitura = 1
    while executando_leitura == 1:
        try:
            opcao = int(input("Digite a pressão em UPCs: "))
            executando_leitura = 0
        except ValueError:
            print("\nEntrada inválida. Por favor, digite um número real ou inteiro")
    return opcao

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

        menu_pressoes()

        opcao = validacao_opcao(1, 2)

        if opcao == 1:
            cont += 1
            continue
        else:
            cont += 1
            exibir_metricas_parciais(cont, media, menor_pressao, porcentagem_verde)


    media = soma / leituras_realizadas
    porcentagem_verde = zona_verde * 100 / leituras_realizadas
    percentual_leituras = (leituras_realizadas / quantidade) * 100
    return menor_pressao, media, porcentagem_verde, percentual_leituras, houve_travamento, quantidade
