def classificacao_estabilidade(ajustada):
    if (120 <= ajustada <= 180):
        return "Verde"
    elif ajustada <= 250:
        return "Amarela"
    else:
        return "Vermelha"