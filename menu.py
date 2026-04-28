from funcao_ajuste import ajuste_pressao
from metricas import exibir_metricas_totais, exibir_metricas_turno
from validacoes import validacao_opcao
from sub_menus import menu_inicial, menu_secundario, tela_inicializacao, tela_creditos
from calculos import atualizar_minimo, atualizar_maximo

def menu():
    executando_menu_um = 1
    executando_menu_inicial = 1
    sistema_inicializado = 0
    menor_pressao = None
    maior_pressao = None
    media = None
    amplitude = None
    desvio_padrao = None
    percentual_leituras = None
    houve_travamento = None
    zona_verde = None
    zona_amarela = None
    zona_vermelha = None
    mudancas_zona = None

    total_turnos = 0
    total_leituras = 0
    menor_pressao_global = None
    maior_pressao_global = None
    total_soma_pressoes = 0
    total_soma_quadrados = 0
    total_travamentos = 0
    total_zona_verde = 0
    total_zona_amarela = 0
    total_zona_vermelha = 0
    total_mudancas_zona = 0

    while executando_menu_um == 1:
        if executando_menu_inicial == 1:

            menu_inicial(sistema_inicializado)

            escolha = validacao_opcao(1, 3)

            match escolha:
                case 1:
                    if sistema_inicializado == 0:
                        tela_inicializacao()
                    sistema_inicializado = 1
                    executando_menu_inicial = 0
                case 2:
                    tela_creditos()
                case 3:
                    print("\nDeseja realmente encerrar o sistema?")
                    print("1 - Sim")
                    print("2 - Não")
                    confirmacao_saida = validacao_opcao(1, 2)
                    if confirmacao_saida == 1:
                        executando_menu_um = 0
                        print("\nFinalizando o sistema...")

        if executando_menu_um == 0:
            break

        if executando_menu_inicial == 1:
            continue

        menu_secundario()

        escolha_dois = validacao_opcao(1, 4)

        match escolha_dois:
            case 1:
                menor_pressao, maior_pressao, media, amplitude, desvio_padrao, soma_turno, soma_quadrados_turno, percentual_leituras, houve_travamento, zona_verde, zona_amarela, zona_vermelha, mudancas_zona = ajuste_pressao()
                total_turnos += 1
                total_leituras += zona_verde + zona_amarela + zona_vermelha
                menor_pressao_global = atualizar_minimo(menor_pressao_global, menor_pressao)
                maior_pressao_global = atualizar_maximo(maior_pressao_global, maior_pressao)
                total_soma_pressoes += soma_turno
                total_soma_quadrados += soma_quadrados_turno
                total_zona_verde += zona_verde
                total_zona_amarela += zona_amarela
                total_zona_vermelha += zona_vermelha
                total_mudancas_zona += mudancas_zona
                if houve_travamento == 1:
                    total_travamentos += 1
            case 2:
                if menor_pressao is not None:
                    exibir_metricas_turno(menor_pressao, maior_pressao, media, amplitude, desvio_padrao, percentual_leituras, houve_travamento, zona_verde, zona_amarela, zona_vermelha, mudancas_zona)
                else:
                    print("\n[ERRO] Nenhum turno iniciado. Inicie um turno pela Opção 1 antes de ver as métricas.")
            case 3:
                if total_turnos > 0:
                    exibir_metricas_totais(total_turnos, total_leituras, menor_pressao_global, maior_pressao_global, total_soma_pressoes, total_soma_quadrados, total_travamentos, total_zona_verde, total_zona_amarela, total_zona_vermelha, total_mudancas_zona)
                else:
                    print("\n[ERRO] Nenhum turno registrado. Inicie um turno pela Opção 1.")
            case 4:
                executando_menu_inicial = 1
