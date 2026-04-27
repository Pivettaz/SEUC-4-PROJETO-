from metricas_parciais import metricas

def menu_um():
    print("\n1 - Inserir Pressões")
    print("2 - Mostrar Métricas Parciais")
    print("3 - Sair")

def validacao_opcao(opcao):
    while (opcao > 3):
        opcao = int(input("\nEscolha uma opção válida: "))

def menu():
    executando_menu_um = 1

    while(executando_menu_um == 1):
        menu_um()
        escolha = int(input("\nDigite sua escolha: "))

        validacao_opcao(escolha)

        match escolha:
            case 1:
                metricas()
            case 2:
                metricas()
            case 3:
                executando_menu_um = 0

