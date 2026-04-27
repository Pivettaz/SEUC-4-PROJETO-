from funcao_ajuste import ajuste_pressao
from metricas import exibir_metricas_totais, exibir_metricas_turno
from validacoes import validacao_opcao
from sub_menus import menu_inicial, menu_secundario

def menu():
    executando_menu_um = 1
    executando_menu_incial = 1
    menor_pressao = None
    media = None
    porcentagem_verde = None
    percentual_leituras = None
    houve_travamento = None
    quantidade = None

    total_turnos = 0
    total_leituras = 0
    menor_pressao_global = None
    soma_medias = 0
    soma_verde = 0
    total_travamentos = 0

    while(executando_menu_um == 1):
        if(executando_menu_incial == 1):

            menu_inicial()

            escolha = validacao_opcao(1, 2)

            match escolha:
                case 1:
                    menor_pressao, media, porcentagem_verde, percentual_leituras, houve_travamento, quantidade = ajuste_pressao()
                    executando_menu_incial = 0
                    total_turnos += 1
                    total_leituras += quantidade
                    if menor_pressao_global is None or menor_pressao < menor_pressao_global:
                        menor_pressao_global = menor_pressao
                    soma_medias += media
                    soma_verde += porcentagem_verde
                    if houve_travamento == 1:
                        total_travamentos += 1
                case 2:
                    executando_menu_um = 0
                    print("\nFinalizando o programa...")

        if executando_menu_um == 0:
            break

        menu_secundario()

        escolha_dois = validacao_opcao(1, 4)

        match escolha_dois:
            case 1:
                menor_pressao, media, porcentagem_verde, percentual_leituras, houve_travamento, quantidade = ajuste_pressao()
                total_turnos += 1
                total_leituras += quantidade
                if menor_pressao_global is None or menor_pressao < menor_pressao_global:
                    menor_pressao_global = menor_pressao
                soma_medias += media
                soma_verde += porcentagem_verde
                if houve_travamento == 1:
                    total_travamentos += 1
            case 2:
                if menor_pressao is not None:
                    exibir_metricas_turno(menor_pressao, media, porcentagem_verde, percentual_leituras, houve_travamento, quantidade)
                else:
                    print("\nPor favor, insira as pressões primeiro (Opção 1) para ver as métricas.")
            case 3:
                if total_turnos > 0:
                    exibir_metricas_totais(total_turnos, total_leituras, menor_pressao_global, soma_medias, soma_verde, total_travamentos)
                else:
                    print("\nNenhum turno registrado ainda.")
            case 4:
                executando_menu_um = 0
                print("\nFinalizando o programa...")

menu()
