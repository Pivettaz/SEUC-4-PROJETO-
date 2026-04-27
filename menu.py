from funcao_ajuste import ajuste_pressao
from metricas_parciais import exibir_metricas

def menu_um():
    print("\n1 - Inserir Pressões")
    print("2 - Mostrar Métricas do Turno")
    print("3 - Mostrar Métrica Total")
    print("4 - Sair")

def validacao_opcao():
    executando_entrada = 1
    while (executando_entrada == 1):
        try:
            escolha = int(input("Digite sua escolha: "))
            if 1 <= escolha <= 4:
                executando_entrada = 1
                return escolha
            else:
                print(f"Opção inválida. Por favor, escolha uma opção entre 1 e 3.")
                menu_um()
        except ValueError:
            print("Entrada inválida. Por favor, digite um número inteiro.")
            menu_um()

def menu():
    executando_menu_um = 1
    menor_pressao = None
    media = None
    porcentagem_verde = None
    percentual_leituras = None
    houve_travamento = None

    while(executando_menu_um == 1):
        menu_um()

        escolha = validacao_opcao()

        match escolha:
            case 1:
                menor_pressao, media, porcentagem_verde, percentual_leituras, houve_travamento, quantidade = ajuste_pressao()
            case 2:
                if menor_pressao is not None:
                    exibir_metricas(menor_pressao, media, porcentagem_verde, percentual_leituras, houve_travamento, quantidade)
                else:
                    print("\nPor favor, insira as pressões primeiro (Opção 1) para ver as métricas.")
            case 4:
                executando_menu_um = 0
                print("\nFinalizando o programa...")

menu()