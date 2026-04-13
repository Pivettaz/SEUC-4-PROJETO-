def ajuste_pressao ():
    num_pressoes=int(input('qtnd pressões: '))
    cont_pressoes=0
    soma_pressoes_ajustadas=0
    for i in range (0, num_pressoes):
        pressao=int(input('digite a pressão em UCPs: '))
        cont_pressoes+=1
        if (pressao > 150):
            pressao_ajustada = pressao * 1.08
        else: 
            pressao_ajustada = pressao * 0.96
        soma_pressoes_ajustadas += pressao_ajustada
        print(f'\n qtnd de pressões: {cont_pressoes} \n pressão ajustada: {pressao_ajustada} \n soma das pressões: {soma_pressoes_ajustadas}')

