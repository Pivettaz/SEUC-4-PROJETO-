# CONSULTA GERAL DAS TABELAS
SELECT * FROM agendamentos;
SELECT * FROM clientes;
SELECT * FROM funcionarios;
SELECT * FROM servicos;
SELECT * FROM especialidade;
SELECT * FROM prontuarios;
SELECT * FROM termos_privacidade;
SELECT * FROM logs_auditoria;


#1) AGENDAMENTOS

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

#1-7) AGENDAMENTOS DO MÊS
SELECT f.nome_funcionario AS dentista, c.nome_cliente, s.nome_servico, a.data_consulta, a.valor, a.pago
FROM agendamentos a
JOIN funcionarios f ON f.id_funcionario = a.id_funcionario
JOIN clientes c ON c.id_cliente = a.id_cliente
JOIN servicos s ON s.id_servico = a.id_servico
WHERE MONTH(data_consulta) = MONTH(NOW()) AND YEAR(data_consulta) = YEAR(NOW());

#1-8) AGENDAMENTOS EM PERÍODO ESPECÍFICO (BETWEEN)
#WHERE data_consulta BETWEEN 'aaaa-mm-dd 00:00:00' AND 'aaaa-mm-dd 23:59:59';
SELECT f.nome_funcionario AS dentista, c.nome_cliente, s.nome_servico, a.data_consulta, a.valor, a.pago
FROM agendamentos a
JOIN funcionarios f ON f.id_funcionario = a.id_funcionario
JOIN clientes c ON c.id_cliente = a.id_cliente
JOIN servicos s ON s.id_servico = a.id_servico
WHERE data_consulta BETWEEN '2026-05-01 00:00:00' AND '2026-05-31 23:59:59';

#1-9) AGENDAMENTOS NÃO PAGOS
SELECT c.nome_cliente, s.nome_servico, a.data_consulta, a.valor
FROM agendamentos a
JOIN clientes c ON c.id_cliente = a.id_cliente
JOIN servicos s ON s.id_servico = a.id_servico
WHERE pago = FALSE;

#1-10) AGENDAMENTOS PAGOS DE UM CLIENTE
#WHERE pago = TRUE AND a.id_cliente = X;
-- Ricardo (id_cliente = 6)
SELECT c.nome_cliente, s.nome_servico, a.data_consulta, a.valor
FROM agendamentos a
JOIN clientes c ON c.id_cliente = a.id_cliente
JOIN servicos s ON s.id_servico = a.id_servico
WHERE pago = TRUE AND a.id_cliente = 6;


# VISUALIZAÇÃO - DENTISTA

#1-11) AGENDAMENTOS DO DIA DO DENTISTA
#WHERE DATE(data_consulta) = CURRENT_DATE() AND a.id_funcionario = X AND f.cargo = 'Dentista';
-- Joyce (id_funcionario = 6)
SELECT f.nome_funcionario AS dentista, c.nome_cliente, s.nome_servico, a.data_consulta, a.valor, a.pago
FROM agendamentos a
JOIN funcionarios f ON f.id_funcionario = a.id_funcionario
JOIN clientes c ON c.id_cliente = a.id_cliente
JOIN servicos s ON s.id_servico = a.id_servico
WHERE DATE(data_consulta) = CURRENT_DATE() AND a.id_funcionario = 6 AND f.cargo = 'Dentista';


# VISUALIZAÇÃO - CLIENTE

#1-12) CONSULTAS ANTERIORES DO PACIENTE
#WHERE DATE(data_consulta) < CURRENT_DATE() AND a.id_cliente = X;
-- Ana (id_cliente = 1)
SELECT f.nome_funcionario AS dentista, c.nome_cliente, s.nome_servico, a.data_consulta, a.valor, a.pago
FROM agendamentos a
JOIN funcionarios f ON f.id_funcionario = a.id_funcionario
JOIN clientes c ON c.id_cliente = a.id_cliente
JOIN servicos s ON s.id_servico = a.id_servico
WHERE DATE(data_consulta) < CURRENT_DATE() AND a.id_cliente = 1;

#1-13) PRÓXIMOS AGENDAMENTOS DO PACIENTE
#WHERE DATE(data_consulta) >= CURRENT_DATE() AND a.id_cliente = X;
-- Ana (id_cliente = 1)
SELECT f.nome_funcionario AS dentista, c.nome_cliente, s.nome_servico, a.data_consulta, a.valor, a.pago
FROM agendamentos a
JOIN funcionarios f ON f.id_funcionario = a.id_funcionario
JOIN clientes c ON c.id_cliente = a.id_cliente
JOIN servicos s ON s.id_servico = a.id_servico
WHERE DATE(data_consulta) >= CURRENT_DATE() AND a.id_cliente = 1;


# DIAGNÓSTICOS

#1-14) CONVÊNIO MAIS UTILIZADO
SELECT cv.nome_convenio, COUNT(cl.id_cliente) AS total_clientes
FROM convenios cv
LEFT JOIN clientes cl ON cv.id_convenio = cl.id_convenio
GROUP BY cv.id_convenio
ORDER BY total_clientes DESC;

#1-15) DETECTAR CONFLITO DE HORÁRIOS
SELECT a.id_funcionario, f.nome_funcionario, a.data_consulta, COUNT(*) AS consultas_no_mesmo_horario
FROM agendamentos a
JOIN funcionarios f ON a.id_funcionario = f.id_funcionario
WHERE DATE(data_consulta) >= CURRENT_DATE()
GROUP BY id_funcionario, data_consulta
HAVING COUNT(*) > 1;

#1-15.1) LISTAR OS AGENDAMENTOS EM CONFLITO
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

#1-16) ALERTA: AGENDAMENTOS FUTUROS DE DENTISTA INATIVO
SELECT a.id_agendamento, f.nome_funcionario AS dentista,
       c.nome_cliente, s.nome_servico, a.data_consulta
FROM agendamentos a
JOIN funcionarios f ON a.id_funcionario = f.id_funcionario
JOIN clientes c ON a.id_cliente = c.id_cliente
JOIN servicos s ON a.id_servico = s.id_servico
WHERE f.ativo = FALSE AND DATE(a.data_consulta) >= CURRENT_DATE();


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
#UPDATE clientes SET nome_social_cliente = 'Nome Social' WHERE id_cliente = X;
-- Ana (id_cliente = 1)
UPDATE clientes SET nome_social_cliente = 'Aninha'
WHERE id_cliente = 1;

#2-4) REMOVER NOME SOCIAL
#UPDATE clientes SET nome_social_cliente = NULL WHERE id_cliente = X;
-- Ana (id_cliente = 1)
UPDATE clientes SET nome_social_cliente = NULL
WHERE id_cliente = 1;

#2-5) EXCLUIR CLIENTE COM CONSULTAS
# Ordem obrigatória: prontuarios → agendamentos → clientes (termos_privacidade deletado automaticamente)
#DELETE FROM prontuarios WHERE id_cliente = X;
#DELETE FROM agendamentos WHERE id_cliente = X;
#DELETE FROM clientes WHERE id_cliente = X;
-- João (id_cliente = 4)
DELETE FROM prontuarios WHERE id_cliente = 4;
DELETE FROM agendamentos WHERE id_cliente = 4;
DELETE FROM clientes WHERE id_cliente = 4;


# VISUALIZAÇÃO

#2-6) CONVÊNIO DE TODOS OS CLIENTES
SELECT cv.nome_convenio, c.nome_cliente
FROM convenios cv
INNER JOIN clientes c ON cv.id_convenio = c.id_convenio;

#2-7) TOTAL DE CLIENTES
SELECT COUNT(id_cliente) AS total_clientes FROM clientes;

#2-8) BUSCAR CLIENTE POR NOME (LIKE)
#SELECT * FROM clientes WHERE nome_cliente LIKE 'X%';
SELECT * FROM clientes WHERE nome_cliente LIKE 'An%';

#2-9) CLIENTES DE CONVÊNIOS ESPECÍFICOS (IN / NOT IN)
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

#2-10) CLIENTES SEM AGENDAMENTO FUTURO (INATIVOS)
SELECT c.nome_cliente, c.celular_cliente
FROM clientes c
LEFT JOIN agendamentos a ON c.id_cliente = a.id_cliente AND DATE(a.data_consulta) >= CURRENT_DATE()
WHERE a.id_agendamento IS NULL;


#3) FUNCIONÁRIOS E ESPECIALIDADES

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

#3-3) ALTERAR NOME SOCIAL DO FUNCIONÁRIO
#UPDATE funcionarios SET nome_social_funcionario = 'Nome Social' WHERE id_funcionario = X;
-- Pedro (id_funcionario = 5)
UPDATE funcionarios SET nome_social_funcionario = 'Pedrão'
WHERE id_funcionario = 5;

#3-4) DESATIVAR FUNCIONÁRIO
#UPDATE funcionarios SET ativo = FALSE WHERE id_funcionario = X;
UPDATE funcionarios SET ativo = FALSE
WHERE id_funcionario = 3; -- Cleber

#3-5) REATIVAR FUNCIONÁRIO
#UPDATE funcionarios SET ativo = TRUE WHERE id_funcionario = X;
UPDATE funcionarios SET ativo = TRUE
WHERE id_funcionario = 3;


# VISUALIZAÇÃO

#3-6) TOTAL DE FUNCIONÁRIOS
SELECT COUNT(id_funcionario) AS total_funcionarios FROM funcionarios;

#3-7) FUNCIONÁRIOS POR CARGO (IN / NOT IN)
-- Dentistas e recepcionistas
SELECT * FROM funcionarios WHERE cargo IN ('Dentista', 'Recepcionista') ORDER BY cargo;

-- Todos exceto dentistas
SELECT * FROM funcionarios WHERE cargo NOT IN ('Dentista') ORDER BY cargo;

#3-8) APENAS FUNCIONÁRIOS ATIVOS
SELECT * FROM funcionarios WHERE ativo = TRUE ORDER BY cargo;

#3-9) RANKING DE DENTISTAS POR CONSULTAS
SELECT f.nome_funcionario AS dentista, COUNT(a.id_agendamento) AS total_consultas
FROM funcionarios f
LEFT JOIN agendamentos a ON f.id_funcionario = a.id_funcionario
WHERE f.cargo = 'Dentista'
GROUP BY f.id_funcionario
ORDER BY total_consultas DESC;

#3-10) SALÁRIO MÉDIO, MÁXIMO E MÍNIMO POR CARGO
SELECT cargo, AVG(salario) AS media_salarial, MAX(salario) AS maior_salario, MIN(salario) AS menor_salario
FROM funcionarios
GROUP BY cargo
ORDER BY media_salarial DESC;


# ESPECIALIDADES

#3-11) ADICIONAR ESPECIALIDADE A UM DENTISTA
#INSERT INTO especialidade (id_funcionario, id_servico) VALUES (id_dentista, id_servico);
INSERT INTO especialidade (id_funcionario, id_servico) VALUES (6, 4); -- Joyce passa a fazer Canal

#3-12) REMOVER ESPECIALIDADE DE UM DENTISTA
#DELETE FROM especialidade WHERE id_funcionario = X AND id_servico = Y;
DELETE FROM especialidade WHERE id_funcionario = 6 AND id_servico = 4;

#3-13) SERVIÇOS QUE UM DENTISTA REALIZA
#WHERE e.id_funcionario = X;
-- Joyce (id_funcionario = 6)
SELECT f.nome_funcionario AS dentista, s.nome_servico, s.valor_base
FROM especialidade e
JOIN funcionarios f ON e.id_funcionario = f.id_funcionario
JOIN servicos s ON e.id_servico = s.id_servico
WHERE e.id_funcionario = 6;

#3-14) DENTISTAS HABILITADOS PARA UM SERVIÇO
#WHERE e.id_servico = X;
-- Extração (id_servico = 2)
SELECT f.nome_funcionario AS dentista, f.cargo
FROM especialidade e
JOIN funcionarios f ON e.id_funcionario = f.id_funcionario
WHERE e.id_servico = 2;

#3-15) TODOS OS DENTISTAS COM SUAS ESPECIALIDADES
SELECT f.nome_funcionario AS dentista, s.nome_servico
FROM especialidade e
JOIN funcionarios f ON e.id_funcionario = f.id_funcionario
JOIN servicos s ON e.id_servico = s.id_servico
ORDER BY f.nome_funcionario, s.nome_servico;


#4) SERVIÇOS

# MODIFICAÇÕES

#4-1) ALTERAR NOME DO SERVIÇO
#UPDATE servicos SET nome_servico = 'Novo Nome' WHERE id_servico = X;
UPDATE servicos SET nome_servico = 'Profilaxia' WHERE id_servico = 1;

#4-2) ALTERAR VALOR BASE
#UPDATE servicos SET valor_base = 0.00 WHERE id_servico = X;
UPDATE servicos SET valor_base = 160.00 WHERE id_servico = 1;


# VISUALIZAÇÃO

#4-3) TODOS OS SERVIÇOS
SELECT * FROM servicos ORDER BY valor_base ASC;

#4-4) SERVIÇO MAIS REALIZADO
SELECT s.nome_servico, COUNT(a.id_agendamento) AS total_realizacoes
FROM servicos s
LEFT JOIN agendamentos a ON s.id_servico = a.id_servico
GROUP BY s.id_servico
ORDER BY total_realizacoes DESC;

#4-5) FATURAMENTO POR TIPO DE SERVIÇO
SELECT s.nome_servico, COUNT(a.id_agendamento) AS total_consultas, SUM(a.valor) AS faturamento_total
FROM servicos s
LEFT JOIN agendamentos a ON s.id_servico = a.id_servico
GROUP BY s.id_servico
ORDER BY faturamento_total DESC;

#4-6) VALOR MÉDIO COBRADO POR SERVIÇO VS VALOR DE TABELA
SELECT s.nome_servico, s.valor_base AS valor_tabela, AVG(a.valor) AS media_cobrada
FROM servicos s
LEFT JOIN agendamentos a ON s.id_servico = a.id_servico
GROUP BY s.id_servico
ORDER BY s.valor_base DESC;

#4-7) SERVIÇOS QUE NUNCA FORAM AGENDADOS
SELECT s.nome_servico, s.valor_base
FROM servicos s
LEFT JOIN agendamentos a ON s.id_servico = a.id_servico
WHERE a.id_agendamento IS NULL;


#5) PRONTUÁRIOS

#5-1) REGISTRAR PRONTUÁRIO APÓS CONSULTA
#INSERT INTO prontuarios (id_cliente, id_funcionario_dentista, id_agendamento, anotacoes_clinicas)
#VALUES (id_cliente, id_dentista, id_agendamento, 'anotações clínicas');
INSERT INTO prontuarios (id_cliente, id_funcionario_dentista, id_agendamento, anotacoes_clinicas)
VALUES (3, 5, 5, 'Extração realizada sem intercorrências. Paciente orientada sobre cuidados pós-operatórios.');

#5-2) HISTÓRICO CLÍNICO DE UM PACIENTE
#WHERE p.id_cliente = X;
-- Ana (id_cliente = 1)
SELECT c.nome_cliente, f.nome_funcionario AS dentista, s.nome_servico,
       p.anotacoes_clinicas, p.data_registro
FROM prontuarios p
JOIN clientes c ON p.id_cliente = c.id_cliente
JOIN funcionarios f ON p.id_funcionario_dentista = f.id_funcionario
JOIN agendamentos a ON p.id_agendamento = a.id_agendamento
JOIN servicos s ON a.id_servico = s.id_servico
WHERE p.id_cliente = 1;

#5-3) PRONTUÁRIOS REGISTRADOS POR UM DENTISTA
#WHERE p.id_funcionario_dentista = X;
-- Pedro (id_funcionario = 5)
SELECT c.nome_cliente, s.nome_servico, p.anotacoes_clinicas, p.data_registro
FROM prontuarios p
JOIN clientes c ON p.id_cliente = c.id_cliente
JOIN agendamentos a ON p.id_agendamento = a.id_agendamento
JOIN servicos s ON a.id_servico = s.id_servico
WHERE p.id_funcionario_dentista = 5;

#5-4) AGENDAMENTOS SEM PRONTUÁRIO (CONSULTAS SEM REGISTRO CLÍNICO)
SELECT a.id_agendamento, c.nome_cliente, s.nome_servico, a.data_consulta
FROM agendamentos a
JOIN clientes c ON a.id_cliente = c.id_cliente
JOIN servicos s ON a.id_servico = s.id_servico
LEFT JOIN prontuarios p ON a.id_agendamento = p.id_agendamento
WHERE p.id_prontuario IS NULL
AND DATE(a.data_consulta) < CURRENT_DATE();


#6) TERMOS DE PRIVACIDADE (LGPD)

#6-1) ATUALIZAR PREFERÊNCIAS DO CLIENTE
#UPDATE termos_privacidade SET permite_notificacoes_whatsapp = TRUE WHERE id_cliente = X;
-- Ricardo (id_cliente = 6) passa a aceitar notificações
UPDATE termos_privacidade SET permite_notificacoes_whatsapp = TRUE
WHERE id_cliente = 6;

#6-2) CLIENTES QUE AUTORIZAM NOTIFICAÇÕES POR WHATSAPP
SELECT c.nome_cliente, c.celular_cliente, t.permite_notificacoes_whatsapp
FROM clientes c
JOIN termos_privacidade t ON c.id_cliente = t.id_cliente
WHERE t.permite_notificacoes_whatsapp = TRUE;

#6-3) CLIENTES COM AMIL QUE NÃO AUTORIZARAM COMPARTILHAMENTO
SELECT c.nome_cliente, cv.nome_convenio, t.permite_compartilhamento_convenio
FROM clientes c
JOIN convenios cv ON c.id_convenio = cv.id_convenio
JOIN termos_privacidade t ON c.id_cliente = t.id_cliente
WHERE cv.nome_convenio = 'Amil' AND t.permite_compartilhamento_convenio = FALSE;

#6-4) CLIENTES QUE EXECUTARAM PROCEDIMENTOS SEM ACEITAR OS TERMOS
SELECT c.id_cliente, c.nome_cliente, a.id_agendamento, a.data_consulta
FROM clientes c
JOIN agendamentos a ON c.id_cliente = a.id_cliente
JOIN termos_privacidade t ON c.id_cliente = t.id_cliente
WHERE t.aceitou_termo_privacidade = FALSE;


#7) LOGS DE AUDITORIA
# Logs são somente leitura — nunca devem ser alterados ou deletados.

#7-1) TODAS AS AÇÕES REGISTRADAS
SELECT * FROM logs_auditoria ORDER BY data_acao DESC;

#7-2) AÇÕES EM UMA TABELA ESPECÍFICA
#WHERE tabela_afetada = 'nome_tabela';
SELECT * FROM logs_auditoria
WHERE tabela_afetada = 'clientes'
ORDER BY data_acao DESC;

#7-3) TOTAL DE AÇÕES POR USUÁRIO
SELECT usuario_sistema, COUNT(*) AS total_acoes
FROM logs_auditoria
GROUP BY usuario_sistema
ORDER BY total_acoes DESC;


#8) ADMINISTRATIVO

#8-1) FATURAMENTO BRUTO
SELECT SUM(valor) AS faturamento_realizado FROM agendamentos WHERE pago = TRUE;

#8-2) FOLHA SALARIAL
SELECT SUM(salario) AS folha_salarial FROM funcionarios WHERE ativo = TRUE;

#8-3) LUCRO LÍQUIDO ESTIMADO
SELECT
    (SELECT SUM(valor) FROM agendamentos WHERE pago = TRUE) -
    (SELECT SUM(salario) FROM funcionarios WHERE ativo = TRUE) AS lucro_liquido_estimado;

#8-4) TICKET MÉDIO DAS CONSULTAS PAGAS
SELECT AVG(valor) AS ticket_medio FROM agendamentos WHERE valor > 0 AND pago = TRUE;

#8-5) FATURAMENTO POR DENTISTA
SELECT f.nome_funcionario AS dentista, COUNT(a.id_agendamento) AS total_consultas, SUM(a.valor) AS faturamento_gerado
FROM agendamentos a
JOIN funcionarios f ON a.id_funcionario = f.id_funcionario
WHERE f.cargo = 'Dentista'
GROUP BY f.id_funcionario
ORDER BY faturamento_gerado DESC;

#8-6) AGENDAMENTOS E FATURAMENTO POR MÊS
SELECT YEAR(data_consulta) AS ano, MONTH(data_consulta) AS mes,
       COUNT(*) AS total_agendamentos, SUM(valor) AS faturamento_previsto
FROM agendamentos
GROUP BY ano, mes
ORDER BY ano, mes;


#9) DDL — ALTER TABLE

#9-1) ADICIONAR COLUNA
ALTER TABLE agendamentos ADD COLUMN observacoes TEXT DEFAULT NULL;

#9-2) MODIFICAR TIPO DE UMA COLUNA
-- ALTER TABLE funcionarios MODIFY COLUMN salario DECIMAL(10,2) NOT NULL;

#9-3) RENOMEAR COLUNA
-- ALTER TABLE clientes RENAME COLUMN nome_social_cliente TO nome_preferido;

#9-4) REMOVER COLUNA
-- ALTER TABLE agendamentos DROP COLUMN observacoes;


# TABELAS APÓS EDIÇÃO
SELECT * FROM agendamentos;
SELECT * FROM funcionarios;
SELECT * FROM clientes;
SELECT * FROM servicos;
SELECT * FROM especialidade;
SELECT * FROM prontuarios;
SELECT * FROM termos_privacidade;
SELECT * FROM logs_auditoria;
