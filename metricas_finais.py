from funcao_ajuste import ajuste_pressao

def metricas_finais():
    quantidade, soma, menor_pressao, zona_verde, leituras_realizadas, houve_travamento, media, porcentagem_verde, percentual_leituras = ajuste_pressao()
    print("")
    print("\n=== METRICAS FINAIS ===")
    print("Média das pressões ajustadas: {:.2f}".format(media))
    print("Menor pressão ajustada: {:.2f}". format(menor_pressao))
    print("Porcentagem de leituras que ficaram na zona verde: {:.2f}".format(porcentagem_verde))
    print("Percentual de leituras realizadas: {:.2f}".format(percentual_leituras))
    print("==========================================================")

metricas_finais()
