from metricas_finais import metricas_finais
from funcao_ajuste import ajuste_pressao

def menu_principal():
    print("\n1 - Inserir Pressões")
    print("2 - Métricas")
    print("3 - Sair")

def menu_alterado():
    print("\n1 - Incluir mais pressões")
    print("2 - Métricas")
    print("3 - Sair")

def validacao_opcao(opcao):
    while (opcao > 3):
        opcao = int(input("\nEscolha uma opção válida: "))

def menu():
    menu_principal()
    escolha = int(input("\nDigite sua escolha: "))

    validacao_opcao(escolha)

    while(escolha == 1 or escolha == 2):

        if (escolha == 1):
            ajuste_pressao()
        else:
            metricas_finais()

        menu_alterado()
        escolha_dois = int(input("\nDigite sua escolha: "))

        validacao_opcao(escolha_dois)

menu()

