from sub_menus import menu_review_travamento
from validacoes import validacao_opcao
from metricas import exibir_metricas_turno

def review_travamento(pressao_critica_anterior, pressao_critica_atual, menor_pressao, maior_pressao, media, amplitude, desvio_padrao, percentual_leituras, houve_travamento, encerramento_antecipado, zona_verde, zona_amarela, zona_vermelha, mudancas_zona, picos_vermelhos_isolados):
    executando_review = 1
    while executando_review == 1:
        menu_review_travamento()
        opcao = validacao_opcao(1, 3)
        match opcao:
            case 1:
                exibir_causa_travamento(pressao_critica_anterior, pressao_critica_atual)
            case 2:
                exibir_metricas_turno(menor_pressao, maior_pressao, media, amplitude, desvio_padrao, percentual_leituras, houve_travamento, encerramento_antecipado, zona_verde, zona_amarela, zona_vermelha, mudancas_zona, picos_vermelhos_isolados)
            case 3:
                executando_review = 0

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
