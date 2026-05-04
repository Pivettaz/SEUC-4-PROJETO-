def exibir_causa_travamento(pressao_critica_anterior, pressao_critica_atual):
    variacao = pressao_critica_atual - pressao_critica_anterior

    print("\n=======================================================")
    print("              CAUSA DO TRAVAMENTO")
    print("=======================================================")
    print("  O sistema detectou DUAS leituras consecutivas na")
    print("  zona vermelha (acima de 250 UPCs), acionando o")
    print("  Protocolo de Travamento por segurança.")
    print("-------------------------------------------------------")
    print("  Leituras críticas responsáveis pelo travamento:")
    print(f"    Penúltima leitura : {pressao_critica_anterior:.2f} UPCs (Vermelha)")
    print(f"    Última leitura    : {pressao_critica_atual:.2f} UPCs (Vermelha)")
    print(f"    Variação          : {variacao:+.2f} UPCs")
    print("-------------------------------------------------------")
    print("  Conforme protocolo SEUC-4, ao identificar duas")
    print("  pressões consecutivas acima do limite crítico, o")
    print("  turno é interrompido automaticamente.")
    print("=======================================================")
