def exibir_metricas_parciais(cont, media, menor_pressao, porcentagem_verde):
    print("")
    print("\n=== MÉTRICAS PARCIAIS ===")
    print(f"Quantidade de pressões lidas: {cont}")
    print(f"Média das pressões ajustadas: {media:.2f}")
    print(f"Menor pressão ajustada: {menor_pressao:.2f}")
    print(f"Porcentagem de leituras que ficaram na zona verde: {porcentagem_verde:.2f}%")

def exibir_metricas_turno(menor_pressao, media, porcentagem_verde, percentual_leituras, houve_travamento, quantidade):
    print("")
    print("\n=== MÉTRICAS DO TURNO ===")
    print("Quantidade de pressões lidas: {}".format(quantidade))
    print("Média das pressões ajustadas: {:.2f}".format(media))
    print("Menor pressão ajustada: {:.2f}". format(menor_pressao))
    print("Porcentagem de leituras que ficaram na zona verde: {:.2f}%".format(porcentagem_verde))
    if houve_travamento == 1:
        print("Percentual de leituras realizadas: {:.2f}%".format(percentual_leituras))
    else:
        print("Sistema encerrado sem travamento")

def exibir_metricas_totais(total_turnos, total_leituras, menor_pressao_global, soma_medias, soma_verde, total_travamentos):
    media_geral = soma_medias / total_turnos
    porcentagem_verde_geral = soma_verde / total_turnos

    print("")
    print("\n=== MÉTRICAS TOTAIS ===")
    print("Total de turnos realizados: {}".format(total_turnos))
    print("Total de leituras realizadas: {}".format(total_leituras))
    print("Menor pressão global: {:.2f}".format(menor_pressao_global))
    print("Média geral das pressões ajustadas: {:.2f}".format(media_geral))
    print("Porcentagem geral de leituras na zona verde: {:.2f}%".format(porcentagem_verde_geral))
    print("Turnos com travamento: {}".format(total_travamentos))
