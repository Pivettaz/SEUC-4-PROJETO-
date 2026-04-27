from funcao_ajuste import ajuste_pressao

def metricas_finais():
    menor_pressao, media, porcentagem_verde, percentual_leituras, houve_travamento = ajuste_pressao()
    print("")
    print("\n=== METRICAS FINAIS ===")
    print("Média das pressões ajustadas: {:.2f}".format(media))
    print("Menor pressão ajustada: {:.2f}". format(menor_pressao))
    print("Porcentagem de leituras que ficaram na zona verde: {:.2f}%".format(porcentagem_verde))
    if houve_travamento == 1:
        print("Percentual de leituras realizadas: {:.2f}%".format(percentual_leituras))
    else:
        print("Sistema encerrado sem travamento")

metricas_finais()
