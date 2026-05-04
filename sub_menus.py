def menu_principal(houve_travamento):
    print("\n=======================================================")
    print("SEUC-4 | Refinaria Delta-9 | Painel Operacional do DPE")
    print("=======================================================")
    print("\n1 - Começar Novo Turno")
    print("2 - Mostrar Métricas do Turno Atual")
    print("3 - Mostrar Métricas Totais")
    if houve_travamento == 1:
        print("4 - Causa do Travamento")
        print("5 - Resetar Sessão (zerar todos os totais)")
        print("6 - Sair")
    else:
        print("4 - Resetar Sessão (zerar todos os totais)")
        print("5 - Sair")
