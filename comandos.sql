# ÍNDICE:
#   1) Agendamentos
#   2) Clientes e Convênios
#   3) Funcionários
#   4) Serviços
#   5) Administrativo
#   6) DDL — ALTER TABLE

# CONSULTA GERAL DAS TABELAS

SELECT * FROM agendamentos;
SELECT * FROM clientes;
SELECT * FROM funcionarios;
SELECT * FROM servicos;


#1) AGENDAMENTOS

# MODIFICAÇÕES

#1-1) REMARCAR AGENDAMENTO

#UPDATE agendamentos SET data_consulta = 'aaaa-mm-dd hh:mm:ss' WHERE id_cliente = X;

-- Mariana (id_cliente = 3)

UPDATE agendamentos SET data_consulta = '2026-05-22 16:30:00'
WHERE id_cliente = 3;

#1-2) REMOVER AGENDAMENTO

#DELETE FROM agendamentos WHERE id_agendamento = X;

-- Carlos Eduardo (id_cliente = 2, id_agendamento = 4)

DELETE FROM agendamentos
WHERE id_agendamento = 4;

#1-3) TROCAR DENTISTA DO AGENDAMENTO

#UPDATE agendamentos SET id_funcionario = id_novo_dentista
#WHERE id_funcionario = id_antigo_dentista AND data_consulta = '...';

-- Joyce (id 6) assume o lugar de Neymar (id 7) na consulta de Ricardo em 26/05

UPDATE agendamentos SET id_funcionario = 6
WHERE id_funcionario = 7 AND data_consulta = '2026-05-26 14:00:00';

#1-4) ALTERAR VALOR MANUALMENTE

#UPDATE agendamentos SET valor = 0.00 WHERE id_cliente = X AND data_consulta = '...';

-- Mariana (id_cliente = 3)

UPDATE agendamentos SET valor = 150.00
WHERE id_cliente = 3 AND data_consulta = '2026-05-22 16:30:00';

#1-5) REGISTRAR PAGAMENTO

#UPDATE agendamentos SET pago = TRUE WHERE id_cliente = X AND data_consulta = '...';

-- Mariana (id_cliente = 3)

UPDATE agendamentos SET pago = TRUE
WHERE id_cliente = 3 AND data_consulta = '2026-05-22 16:30:00';

# VISUALIZAÇÃO - RECEPCIONISTA

#1-6) AGENDAMENTOS DO DIA

SELECT f.nome_funcionario AS dentista, c.nome_cliente, s.nome_servico, a.data_consulta, a.valor, a.pago
FROM agendamentos a
JOIN funcionarios f ON f.id_funcionario = a.id_funcionario
JOIN clientes c ON c.id_cliente = a.id_cliente
JOIN servicos s ON s.id_servico = a.id_servico
WHERE DATE(data_consulta) = CURRENT_DATE();

#1-7) AGENDAMENTOS DA SEMANA

SELECT f.nome_funcionario AS dentista, c.nome_cliente, s.nome_servico, a.data_consulta, a.valor, a.pago
FROM agendamentos a
JOIN funcionarios f ON f.id_funcionario = a.id_funcionario
JOIN clientes c ON c.id_cliente = a.id_cliente
JOIN servicos s ON s.id_servico = a.id_servico
WHERE WEEK(data_consulta, 3) = WEEK(NOW(), 3) AND YEAR(data_consulta) = YEAR(NOW());

#1-8) AGENDAMENTOS DO MÊS

SELECT f.nome_funcionario AS dentista, c.nome_cliente, s.nome_servico, a.data_consulta, a.valor, a.pago
FROM agendamentos a
JOIN funcionarios f ON f.id_funcionario = a.id_funcionario
JOIN clientes c ON c.id_cliente = a.id_cliente
JOIN servicos s ON s.id_servico = a.id_servico
WHERE MONTH(data_consulta) = MONTH(NOW()) AND YEAR(data_consulta) = YEAR(NOW());

#1-9) AGENDAMENTOS EM PERÍODO ESPECÍFICO (BETWEEN)

#WHERE data_consulta BETWEEN 'aaaa-mm-dd 00:00:00' AND 'aaaa-mm-dd 23:59:59';

SELECT f.nome_funcionario AS dentista, c.nome_cliente, s.nome_servico, a.data_consulta, a.valor, a.pago
FROM agendamentos a
JOIN funcionarios f ON f.id_funcionario = a.id_funcionario
JOIN clientes c ON c.id_cliente = a.id_cliente
JOIN servicos s ON s.id_servico = a.id_servico
WHERE data_consulta BETWEEN '2026-05-01 00:00:00' AND '2026-05-31 23:59:59';

#1-10.1) AGENDAMENTOS NÃO PAGOS

SELECT c.nome_cliente, s.nome_servico, a.data_consulta, a.valor
FROM agendamentos a
JOIN clientes c ON c.id_cliente = a.id_cliente
JOIN servicos s ON s.id_servico = a.id_servico
WHERE pago = FALSE;

#1-10.2) AGENDAMENTOS NÃO PAGOS DE UM CLIENTE

#WHERE pago = FALSE AND a.id_cliente = X;

-- Ricardo (id_cliente = 6)

SELECT c.nome_cliente, s.nome_servico, a.data_consulta, a.valor
FROM agendamentos a
JOIN clientes c ON c.id_cliente = a.id_cliente
JOIN servicos s ON s.id_servico = a.id_servico
WHERE pago = FALSE AND a.id_cliente = 6;

#1-11.1) AGENDAMENTOS PAGOS

SELECT c.nome_cliente, s.nome_servico, a.data_consulta, a.valor
FROM agendamentos a
JOIN clientes c ON c.id_cliente = a.id_cliente
JOIN servicos s ON s.id_servico = a.id_servico
WHERE pago = TRUE;

#1-11.2) AGENDAMENTOS PAGOS DE UM CLIENTE

#WHERE pago = TRUE AND a.id_cliente = X;

-- Ricardo (id_cliente = 6)

SELECT c.nome_cliente, s.nome_servico, a.data_consulta, a.valor
FROM agendamentos a
JOIN clientes c ON c.id_cliente = a.id_cliente
JOIN servicos s ON s.id_servico = a.id_servico
WHERE pago = TRUE AND a.id_cliente = 6;

#1-12) HISTÓRICO COMPLETO DE UM CLIENTE — PAGOS E NÃO PAGOS (UNION)

#SELECT ... WHERE pago = TRUE AND a.id_cliente = X
#UNION
#SELECT ... WHERE pago = FALSE AND a.id_cliente = X;

-- Ricardo (id_cliente = 6)

SELECT c.nome_cliente, s.nome_servico, a.data_consulta, a.valor, 'Pago' AS situacao
FROM agendamentos a
JOIN clientes c ON a.id_cliente = c.id_cliente
JOIN servicos s ON a.id_servico = s.id_servico
WHERE a.pago = TRUE AND a.id_cliente = 6

UNION

SELECT c.nome_cliente, s.nome_servico, a.data_consulta, a.valor, 'Não Pago' AS situacao
FROM agendamentos a
JOIN clientes c ON a.id_cliente = c.id_cliente
JOIN servicos s ON a.id_servico = s.id_servico
WHERE a.pago = FALSE AND a.id_cliente = 6
ORDER BY data_consulta;

# VISUALIZAÇÃO - DENTISTA

#1-13) AGENDAMENTOS DO DIA

#WHERE DATE(data_consulta) = CURRENT_DATE() AND a.id_funcionario = X AND f.cargo = 'Dentista';

-- Joyce (id_funcionario = 6)

SELECT f.nome_funcionario AS dentista, c.nome_cliente, s.nome_servico, a.data_consulta, a.valor, a.pago
FROM agendamentos a
JOIN funcionarios f ON f.id_funcionario = a.id_funcionario
JOIN clientes c ON c.id_cliente = a.id_cliente
JOIN servicos s ON s.id_servico = a.id_servico
WHERE DATE(data_consulta) = CURRENT_DATE() AND a.id_funcionario = 6 AND f.cargo = 'Dentista';

#1-14) AGENDAMENTOS DA SEMANA

#WHERE WEEK(data_consulta, 3) = WEEK(NOW(), 3) AND YEAR(data_consulta) = YEAR(NOW())
#AND a.id_funcionario = X AND f.cargo = 'Dentista';

-- Joyce (id_funcionario = 6)

SELECT f.nome_funcionario AS dentista, c.nome_cliente, s.nome_servico, a.data_consulta, a.valor, a.pago
FROM agendamentos a
JOIN funcionarios f ON f.id_funcionario = a.id_funcionario
JOIN clientes c ON c.id_cliente = a.id_cliente
JOIN servicos s ON s.id_servico = a.id_servico
WHERE WEEK(data_consulta, 3) = WEEK(NOW(), 3) AND YEAR(data_consulta) = YEAR(NOW())
AND a.id_funcionario = 6 AND f.cargo = 'Dentista';

#1-15) AGENDAMENTOS DO MÊS

#WHERE MONTH(data_consulta) = MONTH(NOW()) AND YEAR(data_consulta) = YEAR(NOW())
#AND a.id_funcionario = X AND f.cargo = 'Dentista';

-- Joyce (id_funcionario = 6)

SELECT f.nome_funcionario AS dentista, c.nome_cliente, s.nome_servico, a.data_consulta, a.valor, a.pago
FROM agendamentos a
JOIN funcionarios f ON f.id_funcionario = a.id_funcionario
JOIN clientes c ON c.id_cliente = a.id_cliente
JOIN servicos s ON s.id_servico = a.id_servico
WHERE MONTH(data_consulta) = MONTH(NOW()) AND YEAR(data_consulta) = YEAR(NOW())
AND a.id_funcionario = 6 AND f.cargo = 'Dentista';

# VISUALIZAÇÃO - CLIENTE

#1-16) CONSULTAS ANTERIORES

#WHERE DATE(data_consulta) < CURRENT_DATE() AND a.id_cliente = X;

-- Ana (id_cliente = 1)

SELECT f.nome_funcionario AS dentista, c.nome_cliente, s.nome_servico, a.data_consulta, a.valor, a.pago
FROM agendamentos a
JOIN funcionarios f ON f.id_funcionario = a.id_funcionario
JOIN clientes c ON c.id_cliente = a.id_cliente
JOIN servicos s ON s.id_servico = a.id_servico
WHERE DATE(data_consulta) < CURRENT_DATE() AND a.id_cliente = 1;

#1-17) PRÓXIMOS AGENDAMENTOS

#WHERE DATE(data_consulta) >= CURRENT_DATE() AND a.id_cliente = X;

-- Ana (id_cliente = 1)

SELECT f.nome_funcionario AS dentista, c.nome_cliente, s.nome_servico, a.data_consulta, a.valor, a.pago
FROM agendamentos a
JOIN funcionarios f ON f.id_funcionario = a.id_funcionario
JOIN clientes c ON c.id_cliente = a.id_cliente
JOIN servicos s ON s.id_servico = a.id_servico
WHERE DATE(data_consulta) >= CURRENT_DATE() AND a.id_cliente = 1;

# DIAGNÓSTICOS

#1-18) CONVÊNIO MAIS UTILIZADO

SELECT cv.nome_convenio, COUNT(cl.id_cliente) AS total_clientes
FROM convenios cv
LEFT JOIN clientes cl ON cv.id_convenio = cl.id_convenio
GROUP BY cv.id_convenio
ORDER BY total_clientes DESC;

#1-19) DETECTAR CONFLITO DE HORÁRIOS

SELECT a.id_funcionario, f.nome_funcionario, a.data_consulta, COUNT(*) AS consultas_no_mesmo_horario
FROM agendamentos a
JOIN funcionarios f ON a.id_funcionario = f.id_funcionario
WHERE DATE(data_consulta) >= CURRENT_DATE()
GROUP BY id_funcionario, data_consulta
HAVING COUNT(*) > 1;

#1-19.1) LISTAR OS AGENDAMENTOS EM CONFLITO

SELECT a.id_agendamento, f.nome_funcionario AS dentista, c.nome_cliente, s.nome_servico, a.data_consulta
FROM agendamentos a
JOIN funcionarios f ON a.id_funcionario = f.id_funcionario
JOIN clientes c ON a.id_cliente = c.id_cliente
JOIN servicos s ON a.id_servico = s.id_servico
WHERE DATE(a.data_consulta) >= CURRENT_DATE()
AND (a.id_funcionario, a.data_consulta) IN (
    SELECT id_funcionario, data_consulta
    FROM agendamentos
    GROUP BY id_funcionario, data_consulta
    HAVING COUNT(*) > 1
)
ORDER BY a.data_consulta, a.id_funcionario;


#2) CLIENTES E CONVÊNIOS

# MODIFICAÇÕES

#2-1) ALTERAR CELULAR

#UPDATE clientes SET celular_cliente = '11999999999' WHERE id_cliente = X;

-- Ana (id_cliente = 1)

UPDATE clientes SET celular_cliente = '19996863888'
WHERE id_cliente = 1;

#2-2) ALTERAR CONVÊNIO

#UPDATE clientes SET id_convenio = id_do_convenio WHERE id_cliente = X;

-- João (id_cliente = 4) mudando para Unimed (id_convenio = 2)

UPDATE clientes SET id_convenio = 2
WHERE id_cliente = 4;

#2-3) ALTERAR NOME SOCIAL

#UPDATE clientes SET nome_social = 'Nome Social' WHERE id_cliente = X;

-- Ana (id_cliente = 1)

UPDATE clientes SET nome_social = 'Exemplo Nome Social'
WHERE id_cliente = 1;

#2-4) REMOVER NOME SOCIAL

#UPDATE clientes SET nome_social = NULL WHERE id_cliente = X;

-- Ana (id_cliente = 1)

UPDATE clientes SET nome_social = NULL
WHERE id_cliente = 1;

#2-5) EXCLUIR CLIENTE COM CONSULTAS

#DELETE FROM agendamentos WHERE id_cliente = X;
#DELETE FROM clientes WHERE id_cliente = X;

-- João (id_cliente = 4)

DELETE FROM agendamentos WHERE id_cliente = 4;
DELETE FROM clientes WHERE id_cliente = 4;

# VISUALIZAÇÃO

#2-6) CONVÊNIO DE UM CLIENTE

#WHERE c.id_cliente = X;

SELECT cv.nome_convenio, c.nome_cliente
FROM convenios cv
INNER JOIN clientes c ON cv.id_convenio = c.id_convenio
WHERE c.id_cliente = 1;

#2-7) CONVÊNIO DE TODOS OS CLIENTES

SELECT cv.nome_convenio, c.nome_cliente
FROM convenios cv
INNER JOIN clientes c ON cv.id_convenio = c.id_convenio;

#2-8) TOTAL DE CLIENTES

SELECT COUNT(id_cliente) AS total_clientes FROM clientes;

#2-9) BUSCAR CLIENTE POR NOME (LIKE)

#SELECT * FROM clientes WHERE nome_cliente LIKE 'X%';

SELECT * FROM clientes WHERE nome_cliente LIKE 'An%';

#2-10) NOME COMPLETO DOS CLIENTES (CONCAT)

SELECT CONCAT(nome_cliente, ' ', sobrenome_cliente) AS nome_completo, celular_cliente, cpf
FROM clientes;

#2-11) COMO CHAMAR O CLIENTE (IFNULL)

SELECT IFNULL(nome_social, nome_cliente) AS como_chamar, celular_cliente
FROM clientes;

#2-12) CLIENTES DE CONVÊNIOS ESPECÍFICOS (IN / NOT IN)

-- Clientes com Unimed ou Amil
SELECT c.nome_cliente, cv.nome_convenio
FROM clientes c
JOIN convenios cv ON c.id_convenio = cv.id_convenio
WHERE c.id_convenio IN (2, 3);

-- Clientes sem convênio
SELECT c.nome_cliente, cv.nome_convenio
FROM clientes c
JOIN convenios cv ON c.id_convenio = cv.id_convenio
WHERE c.id_convenio NOT IN (2, 3);

#2-13) CLIENTES SEM AGENDAMENTO FUTURO

SELECT c.nome_cliente, c.celular_cliente
FROM clientesc
LEFT JOIN agendamentos a ON c.id_cliente = a.id_cliente
AND DATE(a.data_consulta) >= CURRENT_DATE()
WHERE a.id_agendamento IS NULL;


#3) FUNCIONÁRIOS

# MODIFICAÇÕES

#3-1) ALTERAR CELULAR

#UPDATE funcionarios SET celular_funcionario = '11999999999' WHERE id_funcionario = X;

-- Fabiana (id_funcionario = 4)

UPDATE funcionarios SET celular_funcionario = '19996864069'
WHERE id_funcionario = 4;

#3-2) ALTERAR SALÁRIO

#UPDATE funcionarios SET salario = 0.00 WHERE id_funcionario = X;

-- Luis Gustavo (id_funcionario = 2)

UPDATE funcionarios SET salario = 2600.00
WHERE id_funcionario = 2;

# VISUALIZAÇÃO

#3-3) TOTAL DE FUNCIONÁRIOS

SELECT COUNT(id_funcionario) AS total_funcionarios FROM funcionarios;

#3-4) CARGOS EXISTENTES (DISTINCT)

SELECT DISTINCT cargo FROM funcionarios ORDER BY cargo;

#3-5) FUNCIONÁRIOS POR CARGO (IN / NOT IN)

-- Dentistas e recepcionistas
SELECT * FROM funcionarios WHERE cargo IN ('Dentista', 'Recepcionista') ORDER BY cargo;

-- Todos exceto dentistas
SELECT * FROM funcionarios WHERE cargo NOT IN ('Dentista') ORDER BY cargo;

#3-6) RANKING DE DENTISTAS POR CONSULTAS

SELECT f.nome_funcionario AS dentista, COUNT(a.id_agendamento) AS total_consultas
FROM funcionarios f
LEFT JOIN agendamentos a ON f.id_funcionario = a.id_funcionario
WHERE f.cargo = 'Dentista'
GROUP BY f.id_funcionario
ORDER BY total_consultas DESC;

#3-7) SALÁRIO MÉDIO, MÁXIMO E MÍNIMO POR CARGO

SELECT cargo, AVG(salario) AS media_salarial, MAX(salario) AS maior_salario, MIN(salario) AS menor_salario
FROM funcionarios
GROUP BY cargo
ORDER BY media_salarial DESC;


#4) SERVIÇOS

# MODIFICAÇÕES

#4-1) ALTERAR NOME DO SERVIÇO

#UPDATE servicos SET nome_servico = 'Novo Nome' WHERE id_servico = X;

UPDATE servicos SET nome_servico = 'Profilaxia'
WHERE id_servico = 1;

#4-2) ALTERAR VALOR BASE

#UPDATE servicos SET valor_base = 0.00 WHERE id_servico = X;

UPDATE servicos SET valor_base = 160.00
WHERE id_servico = 1;

# VISUALIZAÇÃO

#4-3) TODOS OS SERVIÇOS

SELECT * FROM servicos ORDER BY valor_base ASC;

#4-4) SERVIÇO DE CADA AGENDAMENTO

SELECT c.nome_cliente, s.nome_servico, a.data_consulta, a.valor
FROM agendamentos a
JOIN clientes c ON a.id_cliente = c.id_cliente
JOIN servicos s ON a.id_servico = s.id_servico
ORDER BY a.data_consulta;

#4-5) SERVIÇO MAIS REALIZADO

SELECT s.nome_servico, COUNT(a.id_agendamento) AS total_realizacoes
FROM servicos s
LEFT JOIN agendamentos a ON s.id_servico = a.id_servico
GROUP BY s.id_servico
ORDER BY total_realizacoes DESC;

#4-6) FATURAMENTO POR TIPO DE SERVIÇO

SELECT s.nome_servico, COUNT(a.id_agendamento) AS total_consultas, SUM(a.valor) AS faturamento_total
FROM servicos s
LEFT JOIN agendamentos a ON s.id_servico = a.id_servico
GROUP BY s.id_servico
ORDER BY faturamento_total DESC;

#4-7) VALOR MÉDIO COBRADO POR SERVIÇO

SELECT s.nome_servico, s.valor_base AS valor_tabela, AVG(a.valor) AS media_cobrada
FROM servicos s
LEFT JOIN agendamentos a ON s.id_servico = a.id_servico
GROUP BY s.id_servico
ORDER BY s.valor_base DESC;

#4-8) SERVIÇO MAIS CARO E MAIS BARATO

SELECT MAX(valor_base) AS servico_mais_caro, MIN(valor_base) AS servico_mais_barato
FROM servicos;

#4-9) SERVIÇOS NUNCA REALIZADOS

SELECT s.nome_servico, s.valor_base
FROM servicos s
LEFT JOIN agendamentos a ON s.id_servico = a.id_servico
WHERE a.id_agendamento IS NULL;


#5) ADMINISTRATIVO

#5-1) FATURAMENTO BRUTO

SELECT SUM(valor) AS faturamento_realizado
FROM agendamentos
WHERE pago = TRUE;

#5-2) FOLHA SALARIAL

SELECT SUM(salario) AS folha_salarial FROM funcionarios;

#5-3) LUCRO LÍQUIDO ESTIMADO

SELECT
    (SELECT SUM(valor) FROM agendamentos WHERE pago = TRUE) -
    (SELECT SUM(salario) FROM funcionarios) AS lucro_liquido_estimado;

#5-4) TICKET MÉDIO DAS CONSULTAS PAGAS

SELECT AVG(valor) AS ticket_medio
FROM agendamentos
WHERE valor > 0 AND pago = TRUE;

#5-5) FATURAMENTO POR DENTISTA

SELECT f.nome_funcionario AS dentista, COUNT(a.id_agendamento) AS total_consultas, SUM(a.valor) AS faturamento_gerado
FROM agendamentos a
JOIN funcionarios f ON a.id_funcionario = f.id_funcionario
WHERE f.cargo = 'Dentista'
GROUP BY f.id_funcionario
ORDER BY faturamento_gerado DESC;

#5-6) AGENDAMENTOS POR MÊS

SELECT YEAR(data_consulta) AS ano, MONTH(data_consulta) AS mes,
COUNT(*) AS total_agendamentos, SUM(valor) AS faturamento_previsto
FROM agendamentos
GROUP BY ano, mes
ORDER BY ano, mes;

#5-7) DENTISTA COM MAIOR FATURAMENTO

SELECT f.nome_funcionario AS dentista, SUM(a.valor) AS faturamento_gerado
FROM agendamentos a
JOIN funcionarios f ON a.id_funcionario = f.id_funcionario
WHERE f.cargo = 'Dentista'
GROUP BY f.id_funcionario
ORDER BY faturamento_gerado DESC
LIMIT 1;


# TABELAS APÓS EDIÇÃO

SELECT * FROM agendamentos;
SELECT * FROM funcionarios;
SELECT * FROM clientes;
SELECT * FROM servicos;
