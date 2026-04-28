def ajustar_pressao(pressao):
    if pressao > 150:
        return pressao * 1.08
    return pressao * 0.96

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
