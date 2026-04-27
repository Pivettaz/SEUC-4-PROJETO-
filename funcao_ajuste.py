from funcao_estabilidade import classificacao_estabilidade
from validacoes import validacao_opcao
from sub_menus import menu_pressoes
from metricas import exibir_metricas_parciais

def ler_quantidade():
    executando_leitura = 1
    while executando_leitura == 1:
        try:
            opcao = int(input("Digite quantas leituras serão realizadas neste turno: "))
            if opcao >= 1:
                executando_leitura = 0
                return opcao
            else:
                print("\nEntrada inválida. A quantidade mínima de leituras é 1.")
        except ValueError:
            print("\nEntrada inválida. Por favor, digite um número inteiro.")

def ler_pressao():
    executando_leitura = 1
    while executando_leitura == 1:
        try:
            opcao = int(input("Digite a pressão em UPCs: "))
            executando_leitura = 0
            return opcao
        except ValueError:
            print("\nEntrada inválida. Por favor, digite um número inteiro.")

def ajuste_pressao():
    quantidade = ler_quantidade()
    soma = 0
    menor_pressao = float("inf")
    maior_pressao = float("-inf")
    zona_verde = 0
    zona_amarela = 0
    zona_vermelha = 0
    mudancas_zona = 0
    leituras_realizadas = 0
    zona_anterior = ""
    houve_travamento = 0

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

        if pressao_ajustada > maior_pressao:
            maior_pressao = pressao_ajustada

        zona = classificacao_estabilidade(pressao_ajustada)
        print(f"Pressão ajustada: {pressao_ajustada:.2f} UCPs | Zona: {zona}")

        if zona == "Verde":
            zona_verde += 1
        elif zona == "Amarela":
            zona_amarela += 1
        elif zona == "Vermelha":
            zona_vermelha += 1

        if zona_anterior != "" and zona != zona_anterior:
            mudancas_zona += 1

        if zona == "Vermelha" and zona_anterior != "Vermelha" and i != quantidade - 1:
            print("\n[!] ALERTA: Primeiro pico crítico detectado. Uma nova leitura vermelha consecutiva causará travamento.")

        if (zona == "Verde" and zona_anterior == "Vermelha") or (zona == "Amarela" and zona_anterior == "Vermelha"):
            print("\n[i] INFORMATIVO: Pico crítico isolado. Sequência de risco encerrada.")

        if zona == "Vermelha" and zona_anterior == "Vermelha":
            houve_travamento = 1
            print("\n[X] PROTOCOLO DE TRAVAMENTO: Duas leituras seguidas de pressões na zona vermelha")
            break

        zona_anterior = zona

        if i == quantidade - 1:
            print("\n[OK] Leituras do turno realizadas com sucesso!")
            break

        menu_pressoes()
        opcao = validacao_opcao(1, 2)

        if opcao == 2:
            media_parcial = soma / leituras_realizadas
            exibir_metricas_parciais(leituras_realizadas, media_parcial, menor_pressao, maior_pressao, zona_verde, zona_amarela, zona_vermelha, mudancas_zona)

    media = soma / leituras_realizadas
    percentual_leituras = (leituras_realizadas / quantidade) * 100
    return menor_pressao, maior_pressao, media, percentual_leituras, houve_travamento, zona_verde, zona_amarela, zona_vermelha, mudancas_zona
