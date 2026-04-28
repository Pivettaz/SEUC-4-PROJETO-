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
                print("\n[ERRO] Quantidade inválida. O mínimo é 1 leitura por turno.")
        except ValueError:
            print("\n[ERRO] Entrada inválida. Digite um número inteiro.")

def ler_pressao(pressao):
    executando_leitura = 1
    while executando_leitura == 1:
        try:
            opcao = int(input(f"{pressao} - Digite a pressão em UPCs: "))
            if opcao >= 0:
                if opcao < 1000:
                    executando_leitura = 0
                    return opcao
                else:
                    print(f"\n[!] AVISO: {opcao} UPCs ultrapassa o limite operacional típico (999 UPCs).")
                    print("    Confirme se a digitação está correta:")
                    print("    1 - Sim, manter o valor")
                    print("    2 - Não, redigitar")
                    confirmacao = validacao_opcao(1, 2)
                    if confirmacao == 1:
                        executando_leitura = 0
                        return opcao
            else:
                print("\n[ERRO] Não é possivel processar uma pressão negativa. Digite um número positivo.")
        except ValueError:
            print("\n[ERRO] Entrada inválida. Digite um número inteiro.")

def ajuste_pressao():
    quantidade = ler_quantidade()
    soma = 0
    soma_quadrados = 0
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
        pressao = ler_pressao(i + 1)

        if pressao > 150:
            pressao_ajustada = pressao * 1.08
        else:
            pressao_ajustada = pressao * 0.96
        soma += pressao_ajustada
        soma_quadrados += pressao_ajustada ** 2

        if pressao_ajustada < menor_pressao:
            menor_pressao = pressao_ajustada

        if pressao_ajustada > maior_pressao:
            maior_pressao = pressao_ajustada

        zona = classificacao_estabilidade(pressao_ajustada)
        print(f"Pressão ajustada: {pressao_ajustada:.2f} UPCs | Zona: {zona}")

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
            variancia_parcial = (soma_quadrados/leituras_realizadas) - (media_parcial ** 2)
            if variancia_parcial < 0:
                variancia_parcial = 0
            desvio_parcial = variancia_parcial ** 0.5
            amplitude_parcial = maior_pressao - menor_pressao
            exibir_metricas_parciais(leituras_realizadas, media_parcial, menor_pressao, maior_pressao, amplitude_parcial, desvio_parcial, zona_verde, zona_amarela, zona_vermelha, mudancas_zona)

    media = soma / leituras_realizadas
    variancia = (soma_quadrados / leituras_realizadas) - (media ** 2)
    if variancia < 0:
        variancia = 0
    desvio_padrao = variancia ** 0.5
    amplitude = maior_pressao - menor_pressao
    percentual_leituras = (leituras_realizadas / quantidade) * 100
    return menor_pressao, maior_pressao, media, amplitude, desvio_padrao, soma, soma_quadrados, percentual_leituras, houve_travamento, zona_verde, zona_amarela, zona_vermelha, mudancas_zona
