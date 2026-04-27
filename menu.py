from funcao_ajuste import ajuste_pressao
from metricas import exibir_metricas_turno
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

    while(executando_menu_um == 1):
        if(executando_menu_incial == 1):

            menu_inicial()

            escolha = validacao_opcao(1, 2)

            match escolha:
                case 1:
                    menor_pressao, media, porcentagem_verde, percentual_leituras, houve_travamento, quantidade = ajuste_pressao()
                    executando_menu_incial = 0
                case 2:
                    executando_menu_um = 0
                    print("\nFinalizando o programa...")

        menu_secundario()

        escolha_dois = validacao_opcao(1, 4)

        match escolha_dois:
            case 1:
                menor_pressao, media, porcentagem_verde, percentual_leituras, houve_travamento, quantidade = ajuste_pressao()
            case 2:
                if menor_pressao is not None:
                    exibir_metricas_turno(menor_pressao, media, porcentagem_verde, percentual_leituras, houve_travamento, quantidade)
                else:
                    print("\nPor favor, insira as pressões primeiro (Opção 1) para ver as métricas.")
            case 4:
                executando_menu_um = 0
                print("\nFinalizando o programa...")

menu()