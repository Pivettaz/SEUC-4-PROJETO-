def validacao_opcao(min_value, max_value):
    executando_entrada = 1
    while (executando_entrada == 1):
        try:
            escolha = int(input("\nDigite sua escolha: "))
            if min_value <= escolha <= max_value:
                executando_entrada = 0
                return escolha
            else:
                print(f"Opção inválida. Por favor, escolha uma opção entre 1 e 3.")
        except ValueError:
            print("Entrada inválida. Por favor, digite um número inteiro.")