import os
from colorama import init, Fore, Style
init(autoreset=True)
META_PRESSAO = 150
LIMIAR_ESTABILIDADE = 5

def limpar_terminal():
    if os.name == "nt":
        os.system("cls")
    else:
        os.system("clear")

def aguardar_continuar():
    input("\nPressione ENTER para continuar...")

def calcular_media(soma, n):
    return soma/n

def calcular_variancia(soma_quadrados,media,n):
    variancia = (soma_quadrados/n) - (media**2)
    if variancia < 0:
        variancia = 0
    return variancia

def calcular_desvio_padrao(variancia):
    return variancia**0.5

def calcular_amplitude(maior,menor):
    return maior-menor

def calcular_porcentagem(parte,total):
    return (parte/total) * 100

def atualizar_minimo(atual,novo):
    if atual is None or novo<atual:
        return novo
    return atual

def atualizar_maximo(atual,novo):
    if atual is None or novo>atual:
        return novo
    return atual

def ajustar_pressao(pressao):
    if pressao > META_PRESSAO:
        return pressao * 1.08
    else:
        return pressao * 0.96

def classificacao_estabilidade(pressao):
    if 120 <= pressao <= 180:
        return "Verde"
    elif pressao <= 250:
        return "Amarela"
    else:
        return "Vermelha"

def calcular_tendencia(primeira_leitura,ultima_leitura):
    if primeira_leitura is None:
        return f"{Fore.WHITE}INDISPONÍVEL"
    diferenca = ultima_leitura - primeira_leitura
    if -LIMIAR_ESTABILIDADE < diferenca < LIMIAR_ESTABILIDADE:
        return f"{Fore.GREEN}ESTÁVEL"
    elif diferenca >= LIMIAR_ESTABILIDADE:
        return f"{Fore.YELLOW}EM ALTA"
    else:
        return f"{Fore.YELLOW}EM QUEDA"

def banner_pressao(pressao_ajustada):
    largura = 50
    pressao_minima = 0
    pressao_maxima = 300
    upc_por_igual = (pressao_maxima-pressao_minima)/largura

    limite_verde_inicio = 120
    limite_verde_fim = 180
    limite_vermelho = 250

    coluna_verde_inicio = int((limite_verde_inicio-pressao_minima) / upc_por_igual)
    coluna_verde_fim = int((limite_verde_fim-pressao_minima) / upc_por_igual)
    coluna_vermelha = int((limite_vermelho-pressao_minima) / upc_por_igual)

    posicao = int((pressao_ajustada-pressao_minima) / upc_por_igual)
    if posicao < 0:
        posicao = 0
    if posicao > largura-1:
        posicao = largura-1

    barra = ""
    i = 0
    while i < largura:
        if i < coluna_verde_inicio:
            barra += f"{Fore.YELLOW}="
        elif i < coluna_verde_fim:
            barra += f"{Fore.GREEN}="
        elif i < coluna_vermelha:
            barra += f"{Fore.YELLOW}="
        else:
            barra += f"{Fore.RED}="
        i += 1

    marcador = ""
    j = 0
    while j < largura:
        if j == posicao:
            marcador += f"{Style.BRIGHT}{Fore.WHITE}^"
        else:
            marcador += " "
        j += 1

    return f"{barra}\n{marcador}"

def descrever_resumo_leitura(pressao_ajustada,zona,pressao_anterior):
    if zona == "Verde":
        cor_zona = Fore.GREEN
    elif zona == "Amarela":
        cor_zona = Fore.YELLOW
    else:
        cor_zona = Fore.RED
    ultima_leitura = f"Última leitura: {Style.BRIGHT}{pressao_ajustada:.2f}{Style.RESET_ALL} UPCs ({cor_zona}{zona}{Style.RESET_ALL})"
    if pressao_anterior is None:
        return ultima_leitura
    variacao = pressao_ajustada - pressao_anterior
    return f"{ultima_leitura} | Variação: {variacao:+.2f} UPCs"

def descrever_desvio_meta(media):
    desvio = media-META_PRESSAO
    if desvio > 0:
        return f"Operação esteve {desvio:.2f} UPCs acima da meta em média"
    elif desvio < 0:
        return f"Operação esteve {-desvio:.2f} UPCs abaixo da meta em média"
    else:
        return "Operação esteve exatamente na meta em média"

def diagnostico_turno(houve_travamento, zona_vermelha, mudancas_zona):
    if houve_travamento == 1:
        return f"{Fore.RED}TURNO INTERROMPIDO POR SEGURANÇA"
    elif zona_vermelha > 0:
        return f"{Fore.YELLOW}TURNO INSTÁVEL"
    elif mudancas_zona > 0:
        return f"{Fore.CYAN}TURNO EM OBSERVAÇÃO"
    else:
        return f"{Fore.GREEN}TURNO ESTÁVEL"

def diagnostico_geral(total_travamentos, total_zona_vermelha, total_mudancas_zona):
    if total_travamentos > 0:
        return f"{Fore.RED}OPERAÇÃO COM INTERRUPÇÕES DE SEGURANÇA"
    elif total_zona_vermelha > 0:
        return f"{Fore.YELLOW}OPERAÇÃO INSTÁVEL"
    elif total_mudancas_zona > 0:
        return f"{Fore.CYAN}OPERAÇÃO EM OBSERVAÇÃO"
    else:
        return f"{Fore.GREEN}OPERAÇÃO ESTÁVEL"

def estado_inicial_turno():
    return None, None, None, None, None, None, None, None, None, None, None, None, None, None, None

def estado_inicial_totais():
    return 0, 0, None, None, 0, 0, 0, 0, 0, 0, 0, 0

def validacao_opcao(min_value, max_value):
    executando_entrada = 1
    while executando_entrada == 1:
        entrada = input("\nDigite sua escolha: ")
        if entrada.isdigit():
            escolha = int(entrada)
            if min_value <= escolha <= max_value:
                return escolha
            else:
                print(f"{Fore.RED}\n[X] ERRO: Opção inválida. Escolha uma opção entre {min_value} e {max_value}.")
        else:
            print(f"{Fore.RED}\n[X] ERRO: Entrada inválida. Digite um número inteiro não negativo.")

def ler_quantidade():
    executando_leitura = 1
    while executando_leitura == 1:
        entrada = input("Digite quantas leituras serão realizadas neste turno: ")
        if entrada.isdigit():
            quantidade = int(entrada)
            if quantidade >= 1:
                return quantidade
            else:
                print(f"{Fore.RED}\n[X] ERRO: Quantidade inválida. O mínimo é 1 leitura por turno.")
        else:
            print(f"{Fore.RED}\n[X] ERRO: Entrada inválida. Digite um número inteiro não negativo.")

def ler_pressao(numero_leitura, total_leituras):
    executando_leitura = 1
    while executando_leitura == 1:
        entrada = input(f"\n[{numero_leitura}/{total_leituras}] Digite a pressão em UPCs: ")
        if entrada.isdigit():
            pressao = int(entrada)
            if pressao < 1000:
                return pressao
            else:
                print(f"{Fore.YELLOW}\n[!] AVISO: {pressao} UPCs ultrapassa o limite operacional típico (1000 UPCs).")
                print("    Confirme se a digitação está correta:")
                print("    1 - Sim, manter o valor")
                print("    2 - Não, redigitar")
                confirmacao = validacao_opcao(1, 2)
                if confirmacao == 1:
                    return pressao
        else:
            print(f"{Fore.RED}\n[X] ERRO: Entrada inválida. Digite um número inteiro não negativo.")

def executar_turno():
    quantidade = ler_quantidade()
    soma = 0
    soma_quadrados = 0
    menor_pressao = None
    maior_pressao = None
    zona_verde = 0
    zona_amarela = 0
    zona_vermelha = 0
    mudancas_zona = 0
    leituras_realizadas = 0
    zona_anterior = None
    pressao_ajustada_anterior = None
    houve_travamento = 0
    picos_vermelhos_isolados = 0
    pressao_critica_anterior = None
    pressao_critica_atual = None
    primeira_leitura_ajustada = None
    ultima_leitura_ajustada = None

    for i in range(quantidade):
        leituras_realizadas += 1
        pressao = ler_pressao(i + 1, quantidade)

        pressao_ajustada = ajustar_pressao(pressao)
        soma += pressao_ajustada
        soma_quadrados += pressao_ajustada ** 2

        if primeira_leitura_ajustada is None:
            primeira_leitura_ajustada = pressao_ajustada
        ultima_leitura_ajustada = pressao_ajustada

        menor_pressao = atualizar_minimo(menor_pressao, pressao_ajustada)
        maior_pressao = atualizar_maximo(maior_pressao, pressao_ajustada)

        zona = classificacao_estabilidade(pressao_ajustada)
        print(descrever_resumo_leitura(pressao_ajustada, zona, pressao_ajustada_anterior))
        print(banner_pressao(pressao_ajustada))

        if zona == "Verde":
            zona_verde += 1
        elif zona == "Amarela":
            zona_amarela += 1
        elif zona == "Vermelha":
            zona_vermelha += 1

        if zona_anterior is not None and zona != zona_anterior:
            mudancas_zona += 1

        if zona == "Vermelha" and zona_anterior != "Vermelha" and i != quantidade - 1:
            print(f"{Fore.YELLOW}\n[!] ALERTA: Primeiro pico crítico detectado. Uma nova leitura vermelha consecutiva causará travamento.")

        if zona_anterior == "Vermelha" and zona != "Vermelha":
            picos_vermelhos_isolados += 1
            print(f"{Fore.BLUE}\n[i] INFORMATIVO: Pico crítico isolado. Sequência de risco encerrada.")

        if zona == "Vermelha" and zona_anterior == "Vermelha":
            houve_travamento = 1
            pressao_critica_anterior = pressao_ajustada_anterior
            pressao_critica_atual = pressao_ajustada
            print(f"{Fore.RED}\n[X] PROTOCOLO DE TRAVAMENTO: Duas leituras seguidas de pressões na zona vermelha")
            break

        zona_anterior = zona
        pressao_ajustada_anterior = pressao_ajustada

    if houve_travamento == 0:
        print(f"{Fore.GREEN}\n[OK] Leituras do turno realizadas com sucesso!")

    media = calcular_media(soma, leituras_realizadas)
    variancia = calcular_variancia(soma_quadrados, media, leituras_realizadas)
    desvio_padrao = calcular_desvio_padrao(variancia)
    amplitude = calcular_amplitude(maior_pressao, menor_pressao)
    percentual_leituras = calcular_porcentagem(leituras_realizadas, quantidade)
    tendencia = calcular_tendencia(primeira_leitura_ajustada, ultima_leitura_ajustada)
    return menor_pressao, maior_pressao, media, amplitude, desvio_padrao, soma, soma_quadrados, percentual_leituras, houve_travamento, zona_verde, zona_amarela, zona_vermelha, mudancas_zona, picos_vermelhos_isolados, pressao_critica_anterior, pressao_critica_atual, tendencia

def exibir_causa_travamento(pressao_critica_anterior, pressao_critica_atual):
    variacao = pressao_critica_atual-pressao_critica_anterior

    print(f"{Style.BRIGHT}{Fore.RED}\n=======================================================")
    print(f"{Style.BRIGHT}{Fore.RED}                 CAUSA DO TRAVAMENTO")
    print(f"{Style.BRIGHT}{Fore.RED}=======================================================")
    print("  O sistema detectou DUAS leituras consecutivas na")
    print("  zona vermelha (acima de 250 UPCs), acionando o")
    print("  Protocolo de Travamento por segurança.")
    print(f"{Style.DIM}-------------------------------------------------------")
    print("  Leituras críticas responsáveis pelo travamento:")
    print(f"    Penúltima leitura : {Style.BRIGHT}{Fore.RED}{pressao_critica_anterior:.2f} UPCs (Vermelha)")
    print(f"    Última leitura    : {Style.BRIGHT}{Fore.RED}{pressao_critica_atual:.2f} UPCs (Vermelha)")
    print(f"    Variação          : {Style.BRIGHT}{variacao:+.2f} UPCs")
    print(f"{Style.DIM}-------------------------------------------------------")
    print("  Conforme protocolo SEUC-4, ao identificar duas")
    print("  pressões consecutivas acima do limite crítico, o")
    print("  turno é interrompido automaticamente.")
    print(f"{Style.BRIGHT}{Fore.RED}=======================================================")

def exibir_metricas_turno(menor_pressao, maior_pressao, media, amplitude, desvio_padrao, percentual_leituras, houve_travamento, zona_verde, zona_amarela, zona_vermelha, mudancas_zona, picos_vermelhos_isolados, tendencia):
    total_leituras_turno = zona_verde + zona_amarela + zona_vermelha
    porcentagem_verde = calcular_porcentagem(zona_verde, total_leituras_turno)
    porcentagem_amarela = calcular_porcentagem(zona_amarela, total_leituras_turno)
    porcentagem_vermelha = calcular_porcentagem(zona_vermelha, total_leituras_turno)
    diagnostico = diagnostico_turno(houve_travamento, zona_vermelha, mudancas_zona)

    print(f"{Style.BRIGHT}{Fore.CYAN}\n=======================================================")
    print(f"{Style.BRIGHT}{Fore.CYAN}                  MÉTRICAS DO TURNO")
    print(f"{Style.BRIGHT}{Fore.CYAN}=======================================================")
    print(f"  Quantidade de leituras realizadas : {Style.BRIGHT}{total_leituras_turno}")
    print(f"  Média das pressões ajustadas      : {Style.BRIGHT}{media:.2f} UPCs")
    print(f"  Menor pressão ajustada            : {Style.BRIGHT}{menor_pressao:.2f} UPCs")
    print(f"  Maior pressão ajustada            : {Style.BRIGHT}{maior_pressao:.2f} UPCs")
    print(f"  Amplitude (maior - menor)         : {Style.BRIGHT}{amplitude:.2f} UPCs")
    print(f"  Desvio padrão                     : {Style.BRIGHT}{desvio_padrao:.2f} UPCs")
    print(f"  Pressão alvo (meta)               : {Style.BRIGHT}{META_PRESSAO} UPCs")
    print(f"  {descrever_desvio_meta(media)}")
    print(f"  Tendência operacional             : {Style.BRIGHT}{tendencia}")
    print(f"{Style.DIM}-------------------------------------------------------")
    print(f"  {Fore.GREEN}Zona Verde    {Style.RESET_ALL}: {zona_verde} leituras ({porcentagem_verde:.2f}%)")
    print(f"  {Fore.YELLOW}Zona Amarela  {Style.RESET_ALL}: {zona_amarela} leituras ({porcentagem_amarela:.2f}%)")
    print(f"  {Fore.RED}Zona Vermelha {Style.RESET_ALL}: {zona_vermelha} leituras ({porcentagem_vermelha:.2f}%)")
    print(f"  {Fore.RED}Picos vermelhos isolados {Style.RESET_ALL}: {Style.BRIGHT}{picos_vermelhos_isolados}")
    print(f"{Style.DIM}-------------------------------------------------------")
    if houve_travamento == 1:
        print(f"  Leituras realizadas : {Style.BRIGHT}{percentual_leituras:.2f}%{Style.RESET_ALL} do turno {Style.BRIGHT}{Fore.RED}(TRAVAMENTO)")
    else:
        print(f"{Fore.GREEN}  Turno encerrado sem travamento")
    print(f"  Diagnóstico         : {Style.BRIGHT}{diagnostico}")
    print(f"{Style.BRIGHT}{Fore.CYAN}=======================================================")

def exibir_metricas_totais(total_turnos, total_leituras, menor_pressao_global, maior_pressao_global, total_soma_pressoes, total_soma_quadrados, total_travamentos, total_zona_verde, total_zona_amarela, total_zona_vermelha, total_mudancas_zona, total_picos_isolados):
    media_geral = calcular_media(total_soma_pressoes, total_leituras)
    variancia_geral = calcular_variancia(total_soma_quadrados, media_geral, total_leituras)
    desvio_geral = calcular_desvio_padrao(variancia_geral)
    amplitude_geral = calcular_amplitude(maior_pressao_global, menor_pressao_global)
    porcentagem_verde_geral = calcular_porcentagem(total_zona_verde, total_leituras)
    porcentagem_amarela_geral = calcular_porcentagem(total_zona_amarela, total_leituras)
    porcentagem_vermelha_geral = calcular_porcentagem(total_zona_vermelha, total_leituras)
    diagnostico = diagnostico_geral(total_travamentos, total_zona_vermelha, total_mudancas_zona)

    print(f"{Style.BRIGHT}{Fore.CYAN}\n=======================================================")
    print(f"{Style.BRIGHT}{Fore.CYAN}                   MÉTRICAS TOTAIS")
    print(f"{Style.BRIGHT}{Fore.CYAN}=======================================================")
    print(f"  Total de turnos realizados   : {Style.BRIGHT}{total_turnos}")
    print(f"  Total de leituras realizadas : {Style.BRIGHT}{total_leituras}")
    print(f"  Média geral das pressões     : {Style.BRIGHT}{media_geral:.2f} UPCs")
    print(f"  Menor pressão global         : {Style.BRIGHT}{menor_pressao_global:.2f} UPCs")
    print(f"  Maior pressão global         : {Style.BRIGHT}{maior_pressao_global:.2f} UPCs")
    print(f"  Amplitude global             : {Style.BRIGHT}{amplitude_geral:.2f} UPCs")
    print(f"  Desvio padrão global         : {Style.BRIGHT}{desvio_geral:.2f} UPCs")
    print(f"  Pressão alvo (meta)          : {Style.BRIGHT}{META_PRESSAO} UPCs")
    print(f"  {descrever_desvio_meta(media_geral)}")
    print(f"{Style.DIM}-------------------------------------------------------")
    print(f"  {Fore.GREEN}Zona Verde    {Style.RESET_ALL}: {total_zona_verde} leituras ({porcentagem_verde_geral:.2f}%)")
    print(f"  {Fore.YELLOW}Zona Amarela  {Style.RESET_ALL}: {total_zona_amarela} leituras ({porcentagem_amarela_geral:.2f}%)")
    print(f"  {Fore.RED}Zona Vermelha {Style.RESET_ALL}: {total_zona_vermelha} leituras ({porcentagem_vermelha_geral:.2f}%)")
    print(f"  {Fore.RED}Picos vermelhos isolados {Style.RESET_ALL}: {Style.BRIGHT}{total_picos_isolados}")
    print(f"{Style.DIM}-------------------------------------------------------")
    print(f"  Turnos com travamento        : {Style.BRIGHT}{total_travamentos}")
    print(f"  Diagnóstico geral            : {Style.BRIGHT}{diagnostico}")
    print(f"{Style.BRIGHT}{Fore.CYAN}=======================================================")

def menu_principal(houve_travamento, total_turnos):
    if total_turnos == 0:
        estado = f"{Fore.WHITE}AGUARDANDO TURNO"
    elif houve_travamento == 1:
        estado = f"{Fore.RED}ÚLTIMO TURNO: TRAVAMENTO"
    else:
        estado = f"{Fore.GREEN}ÚLTIMO TURNO: CONCLUÍDO"

    print(f"{Style.BRIGHT}{Fore.CYAN}\n=======================================================")
    print(f"{Style.BRIGHT}{Fore.CYAN} SEUC-4 | Refinaria Delta-9 | Painel Operacional do DPE")
    print(f"{Style.BRIGHT}{Fore.CYAN}=======================================================")
    texto_turnos = "turno" if total_turnos == 1 else "turnos"
    print(f" Sessão: {Style.BRIGHT}{total_turnos}{Style.RESET_ALL} {texto_turnos} | {estado}")
    print(f"{Style.DIM}-------------------------------------------------------")
    print(f"{Style.BRIGHT} [1]{Style.RESET_ALL} Começar Novo Turno")
    print(f"{Style.BRIGHT} [2]{Style.RESET_ALL} Mostrar Métricas do Turno Atual")
    print(f"{Style.BRIGHT} [3]{Style.RESET_ALL} Mostrar Métricas Totais")
    if houve_travamento == 1:
        print(f"{Style.BRIGHT}{Fore.YELLOW} [4]{Style.RESET_ALL} Causa do Travamento")
        print(f"{Style.BRIGHT} [5]{Style.RESET_ALL} Resetar Sessão (zerar todos os totais)")
        print(f"{Style.BRIGHT}{Fore.RED} [6]{Style.RESET_ALL} Sair")
    else:
        print(f"{Style.BRIGHT} [4]{Style.RESET_ALL} Resetar Sessão (zerar todos os totais)")
        print(f"{Style.BRIGHT}{Fore.RED} [5]{Style.RESET_ALL} Sair")

def menu():
    menor_pressao, maior_pressao, media, amplitude, desvio_padrao, percentual_leituras, houve_travamento, zona_verde, zona_amarela, zona_vermelha, mudancas_zona, picos_vermelhos_isolados, pressao_critica_anterior, pressao_critica_atual, tendencia = estado_inicial_turno()
    total_turnos, total_leituras, menor_pressao_global, maior_pressao_global, total_soma_pressoes, total_soma_quadrados, total_travamentos, total_zona_verde, total_zona_amarela, total_zona_vermelha, total_mudancas_zona, total_picos_isolados = estado_inicial_totais()

    executando = 1
    while executando == 1:
        limpar_terminal()
        menu_principal(houve_travamento, total_turnos)

        if houve_travamento == 1:
            escolha = validacao_opcao(1, 6)
        else:
            escolha = validacao_opcao(1, 5)
            if escolha == 4:
                escolha = 5
            elif escolha == 5:
                escolha = 6

        limpar_terminal()

        match escolha:
            case 1:
                menor_pressao, maior_pressao, media, amplitude, desvio_padrao, soma_turno, soma_quadrados_turno, percentual_leituras, houve_travamento, zona_verde, zona_amarela, zona_vermelha, mudancas_zona, picos_vermelhos_isolados, pressao_critica_anterior, pressao_critica_atual, tendencia = executar_turno()
                total_turnos += 1
                total_leituras += zona_verde + zona_amarela + zona_vermelha
                menor_pressao_global = atualizar_minimo(menor_pressao_global, menor_pressao)
                maior_pressao_global = atualizar_maximo(maior_pressao_global, maior_pressao)
                total_soma_pressoes += soma_turno
                total_soma_quadrados += soma_quadrados_turno
                total_zona_verde += zona_verde
                total_zona_amarela += zona_amarela
                total_zona_vermelha += zona_vermelha
                total_mudancas_zona += mudancas_zona
                total_picos_isolados += picos_vermelhos_isolados
                if houve_travamento == 1:
                    total_travamentos += 1
                aguardar_continuar()
            case 2:
                if menor_pressao is not None:
                    exibir_metricas_turno(menor_pressao, maior_pressao, media, amplitude, desvio_padrao, percentual_leituras, houve_travamento, zona_verde, zona_amarela, zona_vermelha, mudancas_zona, picos_vermelhos_isolados, tendencia)
                else:
                    print(f"{Fore.RED}\n[X] ERRO: Nenhum turno iniciado. Inicie um turno pela Opção 1 antes de ver as métricas.")
                aguardar_continuar()
            case 3:
                if total_turnos > 0:
                    exibir_metricas_totais(total_turnos, total_leituras, menor_pressao_global, maior_pressao_global, total_soma_pressoes, total_soma_quadrados, total_travamentos, total_zona_verde, total_zona_amarela, total_zona_vermelha, total_mudancas_zona, total_picos_isolados)
                else:
                    print(f"{Fore.RED}\n[X] ERRO: Nenhum turno registrado. Inicie um turno pela Opção 1.")
                aguardar_continuar()
            case 4:
                exibir_causa_travamento(pressao_critica_anterior, pressao_critica_atual)
                aguardar_continuar()
            case 5:
                if total_turnos == 0:
                    print(f"{Fore.RED}\n[X] ERRO: Não há sessão para resetar. Nenhum turno foi registrado ainda.")
                else:
                    menor_pressao, maior_pressao, media, amplitude, desvio_padrao, percentual_leituras, houve_travamento, zona_verde, zona_amarela, zona_vermelha, mudancas_zona, picos_vermelhos_isolados, pressao_critica_anterior, pressao_critica_atual, tendencia = estado_inicial_turno()
                    total_turnos, total_leituras, menor_pressao_global, maior_pressao_global, total_soma_pressoes, total_soma_quadrados, total_travamentos, total_zona_verde, total_zona_amarela, total_zona_vermelha, total_mudancas_zona, total_picos_isolados = estado_inicial_totais()
                    print(f"{Fore.GREEN}\n[OK] Sessão resetada. Todos os totais foram zerados.")
                aguardar_continuar()
            case 6:
                print(f"{Style.BRIGHT}{Fore.CYAN}\nFinalizando o sistema...")
                executando = 0

menu()