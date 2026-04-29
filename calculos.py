META_PRESSAO = 150

def ajustar_pressao(pressao):
    if pressao > META_PRESSAO:
        return pressao * 1.08
    else:
        return pressao * 0.96

def descrever_resumo_leitura(pressao_ajustada, zona, pressao_anterior):
    if pressao_anterior is None:
        return f"Última leitura: {pressao_ajustada:.2f} UPCs ({zona})"
    variacao = pressao_ajustada - pressao_anterior
    return f"Última leitura: {pressao_ajustada:.2f} UPCs ({zona}) | Variação: {variacao:+.2f} UPCs"

def descrever_desvio_meta(media):
    desvio = media - META_PRESSAO
    if desvio > 0:
        return f"Operação esteve {desvio:.2f} UPCs acima da meta em média"
    elif desvio < 0:
        return f"Operação esteve {-desvio:.2f} UPCs abaixo da meta em média"
    else:
        return "Operação esteve exatamente na meta em média"

def calcular_media(soma, n):
    return soma / n

def calcular_variancia(soma_quadrados, media, n):
    variancia = (soma_quadrados / n) - (media ** 2)
    if variancia < 0:
        variancia = 0
    return variancia

def calcular_desvio_padrao(variancia):
    return variancia ** 0.5

def calcular_amplitude(maior, menor):
    return maior - menor

def calcular_porcentagem(parte, total):
    return parte * 100 / total

def calcular_percentual_leituras(realizadas, quantidade):
    return (realizadas / quantidade) * 100

def atualizar_minimo(atual, novo):
    if atual is None or novo < atual:
        return novo
    return atual

def atualizar_maximo(atual, novo):
    if atual is None or novo > atual:
        return novo
    return atual

def diagnostico_turno(houve_travamento, zona_vermelha, mudancas_zona):
    if houve_travamento == 1:
        return "TURNO INTERROMPIDO POR SEGURANÇA"
    elif zona_vermelha > 0:
        return "TURNO INSTÁVEL"
    elif mudancas_zona > 0:
        return "TURNO EM OBSERVAÇÃO"
    else:
        return "TURNO ESTÁVEL"

def diagnostico_geral(total_travamentos, total_zona_vermelha, total_mudancas_zona):
    if total_travamentos > 0:
        return "OPERAÇÃO COM INTERRUPÇÕES DE SEGURANÇA"
    elif total_zona_vermelha > 0:
        return "OPERAÇÃO INSTÁVEL"
    elif total_mudancas_zona > 0:
        return "OPERAÇÃO EM OBSERVAÇÃO"
    else:
        return "OPERAÇÃO ESTÁVEL"
