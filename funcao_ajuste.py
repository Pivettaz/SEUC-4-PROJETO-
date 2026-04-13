def ajuste_pressao ():
    num_pressoes=int(input('Quantidade de pressões: '))
    cont_pressoes=0
    soma_pressoes_ajustadas=0
    for i in range (0, num_pressoes):
        pressao=int(input('Digite a pressão em UCPs: '))
        cont_pressoes+=1
        if (pressao > 150):
            pressao_ajustada = pressao * 1.08
        else: 
            pressao_ajustada = pressao * 0.96
        soma_pressoes_ajustadas += pressao_ajustada
        print(f"Pressão ajustada: {pressao_ajustada}")

    print(f"Quantidade de pressões: {cont_pressoes}")
    print(f"Soma das pressões: {soma_pressoes_ajustadas}")

# Adicionar a menor pressão registrada
