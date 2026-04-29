from calculos import ajustar_pressao, calcular_media, calcular_variancia, calcular_desvio_padrao, calcular_amplitude, calcular_percentual_leituras, descrever_resumo_leitura
from funcao_estabilidade import classificacao_estabilidade
from validacoes import validacao_opcao, ler_quantidade, ler_pressao
from sub_menus import menu_pressoes
from metricas import exibir_metricas_parciais

def ajuste_pressao():
    quantidade = ler_quantidade()
    soma = 0
    soma_quadrados = 0
    menor_pressao = 10000
    maior_pressao = -10000
    zona_verde = 0
    zona_amarela = 0
    zona_vermelha = 0
    mudancas_zona = 0
    leituras_realizadas = 0
    zona_anterior = ""
    pressao_ajustada_anterior = None
    houve_travamento = 0
    encerramento_antecipado = 0
    picos_vermelhos_isolados = 0
    pressao_critica_anterior = None
    pressao_critica_atual = None

    for i in range(quantidade):
        leituras_realizadas += 1
        pressao = ler_pressao(i + 1)

        pressao_ajustada = ajustar_pressao(pressao)
        soma += pressao_ajustada
        soma_quadrados += pressao_ajustada ** 2

        if pressao_ajustada < menor_pressao:
            menor_pressao = pressao_ajustada
        if pressao_ajustada > maior_pressao:
            maior_pressao = pressao_ajustada

        zona = classificacao_estabilidade(pressao_ajustada)
        print(descrever_resumo_leitura(pressao_ajustada, zona, pressao_ajustada_anterior))
        pressao_ajustada_anterior = pressao_ajustada

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
            picos_vermelhos_isolados += 1
            print("\n[i] INFORMATIVO: Pico crítico isolado. Sequência de risco encerrada.")

        if zona == "Vermelha" and zona_anterior == "Vermelha":
            houve_travamento = 1
            pressao_critica_anterior = pressao_ajustada_anterior
            pressao_critica_atual = pressao_ajustada
            print("\n[X] PROTOCOLO DE TRAVAMENTO: Duas leituras seguidas de pressões na zona vermelha")
            break

        zona_anterior = zona

        if i == quantidade - 1:
            print("\n[OK] Leituras do turno realizadas com sucesso!")
            break

        menu_pressoes()
        opcao = validacao_opcao(1, 3)

        if opcao == 2:
            media_parcial = calcular_media(soma, leituras_realizadas)
            variancia_parcial = calcular_variancia(soma_quadrados, media_parcial, leituras_realizadas)
            desvio_parcial = calcular_desvio_padrao(variancia_parcial)
            amplitude_parcial = calcular_amplitude(maior_pressao, menor_pressao)
            exibir_metricas_parciais(leituras_realizadas, media_parcial, menor_pressao, maior_pressao, amplitude_parcial, desvio_parcial, zona_verde, zona_amarela, zona_vermelha, mudancas_zona, picos_vermelhos_isolados)

        if opcao == 3:
            print("\nDeseja realmente encerrar o turno antecipadamente?")
            print("1 - Sim")
            print("2 - Não")
            confirmacao_encerramento = validacao_opcao(1, 2)
            if confirmacao_encerramento == 1:
                encerramento_antecipado = 1
                print("\n[!] Turno encerrado antecipadamente pelo operador.")
                break

    media = calcular_media(soma, leituras_realizadas)
    variancia = calcular_variancia(soma_quadrados, media, leituras_realizadas)
    desvio_padrao = calcular_desvio_padrao(variancia)
    amplitude = calcular_amplitude(maior_pressao, menor_pressao)
    percentual_leituras = calcular_percentual_leituras(leituras_realizadas, quantidade)
    return menor_pressao, maior_pressao, media, amplitude, desvio_padrao, soma, soma_quadrados, percentual_leituras, houve_travamento, encerramento_antecipado, zona_verde, zona_amarela, zona_vermelha, mudancas_zona, picos_vermelhos_isolados, pressao_critica_anterior, pressao_critica_atual
