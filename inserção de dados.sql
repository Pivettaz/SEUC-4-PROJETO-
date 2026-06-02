#1) INSERÇÃO DOS FUNCIONÁRIOS

#INSERT INTO funcionarios
#(nome_funcionario, sobrenome_funcionario, nome_social_funcionario, data_admissao_funcionario, email, celular_funcionario, cargo, ativo, salario)
#VALUES ('nome', 'sobrenome', 'nome social ou NULL', 'aaaa-mm-dd hh:mm:ss', 'email', '11122233344', 'cargo', TRUE/FALSE, 0.00);

#RECEPCIONISTA
INSERT INTO funcionarios (nome_funcionario, sobrenome_funcionario, nome_social_funcionario, data_admissao_funcionario, email, celular_funcionario, cargo, ativo, salario)
VALUES ('Letícia', 'Romão', NULL, '2023-03-15 08:00:00', 'leticiar.del@gmail.com', '19996863809', 'Recepcionista', TRUE, 2500.00);

INSERT INTO funcionarios (nome_funcionario, sobrenome_funcionario, nome_social_funcionario, data_admissao_funcionario, email, celular_funcionario, cargo, ativo, salario)
VALUES ('Luis Gustavo', 'Costa', 'Luís', '2024-01-10 08:00:00', 'luis.costa@gmail.com', '19987091378', 'Recepcionista', TRUE, 2300.00);

#FAXINEIRO
INSERT INTO funcionarios (nome_funcionario, sobrenome_funcionario, nome_social_funcionario, data_admissao_funcionario, email, celular_funcionario, cargo, ativo, salario)
VALUES ('Cleber', 'Machado', NULL, '2022-06-01 08:00:00', 'clebinho.max@gmail.com', '19976891303', 'Faxineiro', TRUE, 1800.00);

INSERT INTO funcionarios (nome_funcionario, sobrenome_funcionario, nome_social_funcionario, data_admissao_funcionario, email, celular_funcionario, cargo, ativo, salario)
VALUES ('Fabiana', 'Melo', 'Fabi', '2023-09-05 08:00:00', 'fabi.contato@gmail.com', '19990075430', 'Faxineiro', TRUE, 1700.00);

#DENTISTA
INSERT INTO funcionarios (nome_funcionario, sobrenome_funcionario, nome_social_funcionario, data_admissao_funcionario, email, celular_funcionario, cargo, ativo, salario)
VALUES ('Pedro', 'Gomes', NULL, '2021-02-15 08:00:00', 'pedro.gomes@gmail.com', '19993467443', 'Dentista', TRUE, 6500.00);

INSERT INTO funcionarios (nome_funcionario, sobrenome_funcionario, nome_social_funcionario, data_admissao_funcionario, email, celular_funcionario, cargo, ativo, salario)
VALUES ('Joyce', 'Professora Incrivel', 'Profa. Joyce', '2020-07-01 08:00:00', 'joyce.contato@gmail.com', '19909873709', 'Dentista', TRUE, 8000.00);

INSERT INTO funcionarios (nome_funcionario, sobrenome_funcionario, nome_social_funcionario, data_admissao_funcionario, email, celular_funcionario, cargo, ativo, salario)
VALUES ('Neymar', 'Junior', 'Ney', '2022-11-20 08:00:00', 'neymar.jr@gmail.com', '19995407809', 'Dentista', TRUE, 9500.00);


#2) INSERÇÃO DOS CONVÊNIOS

#INSERT INTO convenios (nome_convenio) VALUES ('nome do convênio');

INSERT INTO convenios (nome_convenio) VALUES ('Sem Convênio'); -- id 1
INSERT INTO convenios (nome_convenio) VALUES ('Unimed');       -- id 2
INSERT INTO convenios (nome_convenio) VALUES ('Amil');         -- id 3


#3) INSERÇÃO DOS SERVIÇOS

#INSERT INTO servicos (nome_servico, valor_base) VALUES ('nome do serviço', 0.00);

INSERT INTO servicos (nome_servico, valor_base) VALUES ('Limpeza', 150.00);      -- id 1
INSERT INTO servicos (nome_servico, valor_base) VALUES ('Extração', 200.00);     -- id 2
INSERT INTO servicos (nome_servico, valor_base) VALUES ('Restauração', 180.00);  -- id 3
INSERT INTO servicos (nome_servico, valor_base) VALUES ('Canal', 800.00);        -- id 4
INSERT INTO servicos (nome_servico, valor_base) VALUES ('Clareamento', 500.00);  -- id 5
INSERT INTO servicos (nome_servico, valor_base) VALUES ('Avaliação', 100.00);    -- id 6


#4) INSERÇÃO DAS ESPECIALIDADES DOS DENTISTAS

#INSERT INTO especialidade (id_funcionario, id_servico) VALUES (id_dentista, id_servico);

-- Pedro (id 5)
INSERT INTO especialidade (id_funcionario, id_servico) VALUES (5, 1); -- Limpeza
INSERT INTO especialidade (id_funcionario, id_servico) VALUES (5, 2); -- Extração
INSERT INTO especialidade (id_funcionario, id_servico) VALUES (5, 4); -- Canal

-- Joyce (id 6)
INSERT INTO especialidade (id_funcionario, id_servico) VALUES (6, 1); -- Limpeza
INSERT INTO especialidade (id_funcionario, id_servico) VALUES (6, 3); -- Restauração
INSERT INTO especialidade (id_funcionario, id_servico) VALUES (6, 5); -- Clareamento

-- Neymar (id 7)
INSERT INTO especialidade (id_funcionario, id_servico) VALUES (7, 1); -- Limpeza
INSERT INTO especialidade (id_funcionario, id_servico) VALUES (7, 2); -- Extração
INSERT INTO especialidade (id_funcionario, id_servico) VALUES (7, 6); -- Avaliação


#5) INSERÇÃO DOS CLIENTES

#INSERT INTO clientes
#(nome_cliente, sobrenome_cliente, nome_social_cliente, data_nascimento, celular_cliente, cpf, id_convenio)
#VALUES ('nome', 'sobrenome', 'nome social ou NULL', 'aaaa-mm-dd', '11122233344', '00000000000', id_convenio);

INSERT INTO clientes (nome_cliente, sobrenome_cliente, nome_social_cliente, data_nascimento, celular_cliente, cpf, id_convenio)
VALUES ('Ana', 'Silva', 'Aninha', '2001-05-25', '19987654321', '12345678901', 2); -- id 1 (Unimed)

INSERT INTO clientes (nome_cliente, sobrenome_cliente, nome_social_cliente, data_nascimento, celular_cliente, cpf, id_convenio)
VALUES ('Carlos', 'Eduardo', 'Carleto', '1992-05-25', '19976543210', '23456789012', 1); -- id 2 (Sem Convênio)

INSERT INTO clientes (nome_cliente, sobrenome_cliente, nome_social_cliente, data_nascimento, celular_cliente, cpf, id_convenio)
VALUES ('Mariana', 'Costa', NULL, '1998-05-25', '19965432109', '34567890123', 1); -- id 3 (Sem Convênio)

INSERT INTO clientes (nome_cliente, sobrenome_cliente, nome_social_cliente, data_nascimento, celular_cliente, cpf, id_convenio)
VALUES ('João', 'Pedro', NULL, '1981-05-25', '19954321098', '45678901234', 1); -- id 4 (Sem Convênio)

INSERT INTO clientes (nome_cliente, sobrenome_cliente, nome_social_cliente, data_nascimento, celular_cliente, cpf, id_convenio)
VALUES ('Fernanda', 'Lima', NULL, '2007-05-25', '19943210987', '56789012345', 3); -- id 5 (Amil)

INSERT INTO clientes (nome_cliente, sobrenome_cliente, nome_social_cliente, data_nascimento, celular_cliente, cpf, id_convenio)
VALUES ('Ricardo', 'Mendes', 'Mendão', '1974-05-25', '19932109876', '67890123456', 1); -- id 6 (Sem Convênio)


#6) INSERÇÃO DE AGENDAMENTOS

#INSERT INTO agendamentos (id_funcionario, id_cliente, id_servico, data_consulta, valor, pago)
#VALUES (id_func, id_cli, id_serv, 'aaaa-mm-dd hh:mm:ss', valor_consulta, TRUE/FALSE);

-- id_agendamento: 1
INSERT INTO agendamentos (id_funcionario, id_cliente, id_servico, data_consulta, valor, pago)
VALUES (5, 1, 1, '2026-05-20 09:00:00', 0.00, TRUE); -- Ana, Limpeza, Unimed

-- id_agendamento: 2
INSERT INTO agendamentos (id_funcionario, id_cliente, id_servico, data_consulta, valor, pago)
VALUES (5, 1, 4, '2026-12-20 09:00:00', 0.00, TRUE); -- Ana, Canal, Unimed

-- id_agendamento: 3
INSERT INTO agendamentos (id_funcionario, id_cliente, id_servico, data_consulta, valor, pago)
VALUES (7, 5, 1, '2026-05-21 08:00:00', 0.00, TRUE); -- Fernanda, Limpeza, Amil

-- id_agendamento: 4
INSERT INTO agendamentos (id_funcionario, id_cliente, id_servico, data_consulta, valor, pago)
VALUES (6, 2, 1, '2026-05-20 10:30:00', 150.00, FALSE); -- Carlos, Limpeza

-- id_agendamento: 5
INSERT INTO agendamentos (id_funcionario, id_cliente, id_servico, data_consulta, valor, pago)
VALUES (5, 3, 2, '2026-05-21 11:00:00', 200.00, FALSE); -- Mariana, Extração

-- id_agendamento: 6
INSERT INTO agendamentos (id_funcionario, id_cliente, id_servico, data_consulta, valor, pago)
VALUES (6, 4, 3, '2026-09-22 09:30:00', 180.00, FALSE); -- João, Restauração

-- id_agendamento: 7
INSERT INTO agendamentos (id_funcionario, id_cliente, id_servico, data_consulta, valor, pago)
VALUES (6, 5, 3, '2026-09-22 09:30:00', 180.00, FALSE); -- Fernanda, Restauração (Particular)

-- id_agendamento: 8
INSERT INTO agendamentos (id_funcionario, id_cliente, id_servico, data_consulta, valor, pago)
VALUES (7, 6, 1, '2026-05-26 14:00:00', 150.00, FALSE); -- Ricardo, Limpeza

-- id_agendamento: 9
INSERT INTO agendamentos (id_funcionario, id_cliente, id_servico, data_consulta, valor, pago)
VALUES (7, 6, 2, '2026-02-26 14:00:00', 200.00, TRUE); -- Ricardo, Extração


#7) INSERÇÃO DOS TERMOS DE PRIVACIDADE

#INSERT INTO termos_privacidade (id_cliente, aceitou_termo_privacidade, permite_notificacoes_whatsapp, permite_compartilhamento_convenio)
#VALUES (id_cliente, TRUE/FALSE, TRUE/FALSE, TRUE/FALSE);

INSERT INTO termos_privacidade (id_cliente, aceitou_termo_privacidade, permite_notificacoes_whatsapp, permite_compartilhamento_convenio)
VALUES (1, TRUE, TRUE, TRUE);   -- Ana aceitou tudo

INSERT INTO termos_privacidade (id_cliente, aceitou_termo_privacidade, permite_notificacoes_whatsapp, permite_compartilhamento_convenio)
VALUES (2, TRUE, FALSE, FALSE); -- Carlos não autoriza notificações nem compartilhamento

INSERT INTO termos_privacidade (id_cliente, aceitou_termo_privacidade, permite_notificacoes_whatsapp, permite_compartilhamento_convenio)
VALUES (3, TRUE, TRUE, FALSE);  -- Mariana autoriza avisos mas não compartilhamento

INSERT INTO termos_privacidade (id_cliente, aceitou_termo_privacidade, permite_notificacoes_whatsapp, permite_compartilhamento_convenio)
VALUES (4, TRUE, TRUE, FALSE); -- João não autoriza compartilhamento de convênio

INSERT INTO termos_privacidade (id_cliente, aceitou_termo_privacidade, permite_notificacoes_whatsapp, permite_compartilhamento_convenio)
VALUES (5, TRUE, TRUE, TRUE);   -- Fernanda autorizou compartilhamento (necessário para Amil)

INSERT INTO termos_privacidade (id_cliente, aceitou_termo_privacidade, permite_notificacoes_whatsapp, permite_compartilhamento_convenio)
VALUES (6, TRUE, FALSE, FALSE); -- Ricardo não autoriza notificações e compartilhamento de convênio


#8) INSERÇÃO DE PRONTUÁRIOS

#INSERT INTO prontuarios (id_cliente, id_funcionario_dentista, id_agendamento, anotacoes_clinicas)
#VALUES (id_cliente, id_dentista, id_agendamento, 'anotações');

-- Prontuário da Limpeza da Ana (id_agendamento 1, dentista Pedro id 5)
INSERT INTO prontuarios (id_cliente, id_funcionario_dentista, id_agendamento, anotacoes_clinicas)
VALUES (1, 5, 1, 'Realizada profilaxia e aplicação de flúor. Paciente apresenta boa higiene bucal, sem sinais de lesões cariosas ativas.');

-- Prontuário da Extração do Ricardo (id_agendamento 9, dentista Neymar id 7)
INSERT INTO prontuarios (id_cliente, id_funcionario_dentista, id_agendamento, anotacoes_clinicas)
VALUES (6, 7, 9, 'Exodontia simples do elemento 38. Procedimento sem intercorrências. Prescrito analgésico e orientado repouso.');


#9) LOGS DE AUDITORIA — REGISTRO DA CRIAÇÃO DOS CLIENTES
# Logs nunca podem ser alterados ou deletados por segurança.

INSERT INTO logs_auditoria (usuario_sistema, acao_realizada, tabela_afetada, id_registro_afetado)
VALUES ('recepcao_puc', 'INSERT', 'clientes', 1); -- Ana Silva

INSERT INTO logs_auditoria (usuario_sistema, acao_realizada, tabela_afetada, id_registro_afetado)
VALUES ('recepcao_puc', 'INSERT', 'clientes', 2); -- Carlos Eduardo

INSERT INTO logs_auditoria (usuario_sistema, acao_realizada, tabela_afetada, id_registro_afetado)
VALUES ('recepcao_puc', 'INSERT', 'clientes', 3); -- Mariana Costa

INSERT INTO logs_auditoria (usuario_sistema, acao_realizada, tabela_afetada, id_registro_afetado)
VALUES ('recepcao_puc', 'INSERT', 'clientes', 4); -- João Pedro

INSERT INTO logs_auditoria (usuario_sistema, acao_realizada, tabela_afetada, id_registro_afetado)
VALUES ('recepcao_puc', 'INSERT', 'clientes', 5); -- Fernanda Lima

INSERT INTO logs_auditoria (usuario_sistema, acao_realizada, tabela_afetada, id_registro_afetado)
VALUES ('recepcao_puc', 'INSERT', 'clientes', 6); -- Ricardo Mendes
