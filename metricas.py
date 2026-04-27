def diagnostico_turno(houve_travamento, zona_vermelha, mudancas_zona):
    if houve_travamento == 1:
        return "TURNO INTERROMPIDO POR SEGURANÇA"
    elif zona_vermelha > 0:
        return "TURNO INSTÁVEL"
    elif mudancas_zona > 0:
        return "TURNO EM OBSERVAÇÃO"
    else:
        return "TURNO ESTÁVEL"

def exibir_metricas_parciais(cont, media, menor_pressao, maior_pressao, zona_verde, zona_amarela, zona_vermelha, mudancas_zona):
    porcentagem_verde = zona_verde * 100 / cont
    porcentagem_amarela = zona_amarela * 100 / cont
    porcentagem_vermelha = zona_vermelha * 100 / cont
    diagnostico = diagnostico_turno(0, zona_vermelha, mudancas_zona)

    print("\n=======================================================")
    print("               MÉTRICAS PARCIAIS DO TURNO")
    print("=======================================================")
    print(f"  Quantidade de pressões lidas : {cont}")
    print(f"  Média das pressões ajustadas : {media:.2f} UPCs")
    print(f"  Menor pressão ajustada       : {menor_pressao:.2f} UPCs")
    print(f"  Maior pressão ajustada       : {maior_pressao:.2f} UPCs")
    print("-------------------------------------------------------")
    print(f"  Zona Verde    : {zona_verde} leituras ({porcentagem_verde:.2f}%)")
    print(f"  Zona Amarela  : {zona_amarela} leituras ({porcentagem_amarela:.2f}%)")
    print(f"  Zona Vermelha : {zona_vermelha} leituras ({porcentagem_vermelha:.2f}%)")
    print("-------------------------------------------------------")
    print(f"  Diagnóstico   : {diagnostico}")
    print("=======================================================")

def exibir_metricas_turno(menor_pressao, maior_pressao, media, percentual_leituras, houve_travamento, zona_verde, zona_amarela, zona_vermelha, mudancas_zona):
    total_leituras_turno = zona_verde + zona_amarela + zona_vermelha
    porcentagem_verde = zona_verde * 100 / total_leituras_turno
    porcentagem_amarela = zona_amarela * 100 / total_leituras_turno
    porcentagem_vermelha = zona_vermelha * 100 / total_leituras_turno
    diagnostico = diagnostico_turno(houve_travamento, zona_vermelha, mudancas_zona)

    print("\n=======================================================")
    print("                  MÉTRICAS DO TURNO")
    print("=======================================================")
    print(f"  Quantidade de pressões lidas : {total_leituras_turno}")
    print(f"  Média das pressões ajustadas : {media:.2f} UPCs")
    print(f"  Menor pressão ajustada       : {menor_pressao:.2f} UPCs")
    print(f"  Maior pressão ajustada       : {maior_pressao:.2f} UPCs")
    print("-------------------------------------------------------")
    print(f"  Zona Verde    : {zona_verde} leituras ({porcentagem_verde:.2f}%)")
    print(f"  Zona Amarela  : {zona_amarela} leituras ({porcentagem_amarela:.2f}%)")
    print(f"  Zona Vermelha : {zona_vermelha} leituras ({porcentagem_vermelha:.2f}%)")
    print("-------------------------------------------------------")
    if houve_travamento == 1:
        print(f"  Leituras realizadas : {percentual_leituras:.2f}% do turno")
    else:
        print("  Sistema encerrado sem travamento")
    print(f"  Diagnóstico         : {diagnostico}")
    print("=======================================================")

def exibir_metricas_totais(total_turnos, total_leituras, menor_pressao_global, maior_pressao_global, soma_medias, total_travamentos, total_zona_verde, total_zona_amarela, total_zona_vermelha, total_mudancas_zona):
    media_geral = soma_medias / total_turnos
    porcentagem_verde_geral = total_zona_verde * 100 / total_leituras
    porcentagem_amarela_geral = total_zona_amarela * 100 / total_leituras
    porcentagem_vermelha_geral = total_zona_vermelha * 100 / total_leituras

    if total_travamentos > 0:
        diagnostico = "OPERAÇÃO COM INTERRUPÇÕES DE SEGURANÇA"
    elif total_zona_vermelha > 0:
        diagnostico = "OPERAÇÃO INSTÁVEL"
    elif total_mudancas_zona > 0:
        diagnostico = "OPERAÇÃO EM OBSERVAÇÃO"
    else:
        diagnostico = "OPERAÇÃO ESTÁVEL"

    print("\n=======================================================")
    print("                   MÉTRICAS TOTAIS")
    print("=======================================================")
    print(f"  Total de turnos realizados   : {total_turnos}")
    print(f"  Total de leituras realizadas : {total_leituras}")
    print(f"  Média geral das pressões     : {media_geral:.2f} UPCs")
    print(f"  Menor pressão global         : {menor_pressao_global:.2f} UPCs")
    print(f"  Maior pressão global         : {maior_pressao_global:.2f} UPCs")
    print("-------------------------------------------------------")
    print(f"  Zona Verde    : {total_zona_verde} leituras ({porcentagem_verde_geral:.2f}%)")
    print(f"  Zona Amarela  : {total_zona_amarela} leituras ({porcentagem_amarela_geral:.2f}%)")
    print(f"  Zona Vermelha : {total_zona_vermelha} leituras ({porcentagem_vermelha_geral:.2f}%)")
    print("-------------------------------------------------------")
    print(f"  Turnos com travamento : {total_travamentos}")
    print(f"  Diagnóstico geral     : {diagnostico}")
    print("=======================================================")
