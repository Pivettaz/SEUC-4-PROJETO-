def validacao_opcao(min_value, max_value):
    executando_entrada = 1
    while executando_entrada == 1:
        entrada = input("\nDigite sua escolha: ")
        if entrada.isdigit():
            escolha = int(entrada)
            if min_value <= escolha <= max_value:
                executando_entrada = 0
                return escolha
            else:
                print(f"\n[ERRO] Opção inválida. Escolha uma opção entre {min_value} e {max_value}.")
        else:
            print("\n[ERRO] Entrada inválida. Digite um número inteiro.")

def ler_quantidade():
    executando_leitura = 1
    while executando_leitura == 1:
        entrada = input("Digite quantas leituras serão realizadas neste turno: ")
        if entrada.isdigit():
            opcao = int(entrada)
            if opcao >= 1:
                executando_leitura = 0
                return opcao
            else:
                print("\n[ERRO] Quantidade inválida. O mínimo é 1 leitura por turno.")
        else:
            print("\n[ERRO] Entrada inválida. Digite um número inteiro.")

def ler_pressao(pressao):
    executando_leitura = 1
    while executando_leitura == 1:
        entrada = input(f"{pressao} - Digite a pressão em UPCs: ")
        if entrada.isdigit():
            opcao = int(entrada)
            if opcao < 1000:
                executando_leitura = 0
                return opcao
            else:
                print(f"\n[!] AVISO: {opcao} UPCs ultrapassa o limite operacional típico (999 UPCs).")
                print("    Confirme se a digitação está correta:")
                print("    1 - Sim, manter o valor")
                print("    2 - Não, redigitar")
                confirmacao = validacao_opcao(1, 2)
                if confirmacao == 1:
                    executando_leitura = 0
                    return opcao
        else:
            print("\n[ERRO] Entrada inválida. Digite um número inteiro não-negativo.")
