#1) INSERÇÃO DOS FUNCIONÁRIOS

#INSERT INTO funcionarios
#(nome_funcionario, sobrenome_funcionario, email, celular_funcionario, cargo, salario)
#VALUES ('nome', 'sobrenome', 'email', '11122233344', 'cargo', 0.00);

#RECEPCIONISTA

INSERT INTO funcionarios (nome_funcionario, sobrenome_funcionario, email, celular_funcionario, cargo, salario)
VALUES ('Letícia', 'Romão', 'leticiar.del@gmail.com', '19996863809', 'Recepcionista', 2500.00);

INSERT INTO funcionarios (nome_funcionario, sobrenome_funcionario, email, celular_funcionario, cargo, salario)
VALUES ('Luis Gustavo', 'Costa', 'luis.costa@gmail.com', '19987091378', 'Recepcionista', 2300.00);

#FAXINEIRO

INSERT INTO funcionarios (nome_funcionario, sobrenome_funcionario, email, celular_funcionario, cargo, salario)
VALUES ('Cleber', 'Machado', 'clebinho.max@gmail.com', '19976891303', 'Faxineiro', 1800.00);

INSERT INTO funcionarios (nome_funcionario, sobrenome_funcionario, email, celular_funcionario, cargo, salario)
VALUES ('Fabiana', 'Melo', 'fabi.contato@gmail.com', '19990075430', 'Faxineiro', 1700.00);

#DENTISTA

INSERT INTO funcionarios (nome_funcionario, sobrenome_funcionario, email, celular_funcionario, cargo, salario)
VALUES ('Pedro', 'Gomes', 'pedro.gomes@gmail.com', '19993467443', 'Dentista', 6500.00);

INSERT INTO funcionarios (nome_funcionario, sobrenome_funcionario, email, celular_funcionario, cargo, salario)
VALUES ('Joyce', 'Professora Incrivel', 'joyce.contato@gmail.com', '19909873709', 'Dentista', 8000.00);

INSERT INTO funcionarios (nome_funcionario, sobrenome_funcionario, email, celular_funcionario, cargo, salario)
VALUES ('Neymar', 'Junior', 'neymar.jr@gmail.com', '19995407809', 'Dentista', 9500.00);


#2) INSERÇÃO DOS CONVÊNIOS

#INSERT INTO convenios (nome_convenio) VALUES ('nome do convênio');

INSERT INTO convenios (nome_convenio) VALUES ('Sem Convênio'); -- id 1
INSERT INTO convenios (nome_convenio) VALUES ('Unimed'); -- id 2
INSERT INTO convenios (nome_convenio) VALUES ('Amil'); -- id 3


#3) INSERÇÃO DOS SERVIÇOS

#INSERT INTO servicos (nome_servico, valor_base) VALUES ('nome do serviço', 0.00);

INSERT INTO servicos (nome_servico, valor_base) VALUES ('Limpeza', 150.00); -- id 1
INSERT INTO servicos (nome_servico, valor_base) VALUES ('Extração', 200.00); -- id 2
INSERT INTO servicos (nome_servico, valor_base) VALUES ('Restauração', 180.00); -- id 3
INSERT INTO servicos (nome_servico, valor_base) VALUES ('Canal', 800.00); -- id 4
INSERT INTO servicos (nome_servico, valor_base) VALUES ('Clareamento', 500.00); -- id 5
INSERT INTO servicos (nome_servico, valor_base) VALUES ('Avaliação', 100.00); -- id 6


#4) INSERÇÃO DOS CLIENTES

#INSERT INTO clientes
#(nome_cliente, sobrenome_cliente, nome_social, data_nascimento, celular_cliente, cpf, id_convenio)
#VALUES ('nome', 'sobrenome', 'nome social ou NULL', 'aaaa-mm-dd', '11122233344', '00000000000', id_convenio);

INSERT INTO clientes (nome_cliente, sobrenome_cliente, nome_social, data_nascimento, celular_cliente, cpf, id_convenio)
VALUES ('Ana', 'Silva', 'Aninha', '2001-05-25', '19987654321', '12345678901', 2); -- 25 anos

INSERT INTO clientes (nome_cliente, sobrenome_cliente, nome_social, data_nascimento, celular_cliente, cpf, id_convenio)
VALUES ('Carlos', 'Eduardo', 'Carleto', '1992-05-25', '19976543210', '23456789012', 1); -- 34 anos

INSERT INTO clientes (nome_cliente, sobrenome_cliente, nome_social, data_nascimento, celular_cliente, cpf, id_convenio)
VALUES ('Mariana', 'Costa', NULL, '1998-05-25', '19965432109', '34567890123', 1); -- 28 anos

INSERT INTO clientes (nome_cliente, sobrenome_cliente, nome_social, data_nascimento, celular_cliente, cpf, id_convenio)
VALUES ('João', 'Pedro', NULL, '1981-05-25', '19954321098', '45678901234', 1); -- 45 anos

INSERT INTO clientes (nome_cliente, sobrenome_cliente, nome_social, data_nascimento, celular_cliente, cpf, id_convenio)
VALUES ('Fernanda', 'Lima', NULL, '2007-05-25', '19943210987', '56789012345', 3); -- 19 anos

INSERT INTO clientes (nome_cliente, sobrenome_cliente, nome_social, data_nascimento, celular_cliente, cpf, id_convenio)
VALUES ('Ricardo', 'Mendes', 'Mendão', '1974-05-25', '19932109876', '67890123456', 1);


#5) INSERÇÃO DE AGENDAMENTOS COM CONVÊNIO

#INSERT INTO agendamentos (id_funcionario, id_cliente, id_servico, data_consulta, valor, pago)
#VALUES (id_func, id_cli, id_serv, 'aaaa-mm-dd hh:mm:ss', 0, TRUE/FALSE);

INSERT INTO agendamentos (id_funcionario, id_cliente, id_servico, data_consulta, valor, pago)
VALUES (5, 1, 1, '2026-05-20 09:00:00', 0, TRUE); -- Ana, Limpeza, Unimed

INSERT INTO agendamentos (id_funcionario, id_cliente, id_servico, data_consulta, valor, pago)
VALUES (5, 1, 4, '2026-12-20 09:00:00', 0, TRUE); -- Ana, Canal, Unimed

INSERT INTO agendamentos (id_funcionario, id_cliente, id_servico, data_consulta, valor, pago)
VALUES (7, 5, 1, '2026-05-21 08:00:00', 0, TRUE); -- Fernanda, Limpeza, Amil


#6) INSERÇÃO DE AGENDAMENTOS SEM CONVÊNIO

#INSERT INTO agendamentos (id_funcionario, id_cliente, id_servico, data_consulta, valor, pago)
#VALUES (id_func, id_cli, id_serv, 'aaaa-mm-dd hh:mm:ss', valor_consulta, TRUE/FALSE);

INSERT INTO agendamentos (id_funcionario, id_cliente, id_servico, data_consulta, valor, pago)
VALUES (6, 2, 1, '2026-05-20 10:30:00', 150.00, FALSE); -- Carlos, Limpeza

INSERT INTO agendamentos (id_funcionario, id_cliente, id_servico, data_consulta, valor, pago)
VALUES (5, 3, 2, '2026-05-21 11:00:00', 200.00, FALSE); -- Mariana, Extração

INSERT INTO agendamentos (id_funcionario, id_cliente, id_servico, data_consulta, valor, pago)
VALUES (6, 4, 3, '2026-09-22 09:30:00', 180.00, FALSE); -- João, Restauração

INSERT INTO agendamentos (id_funcionario, id_cliente, id_servico, data_consulta, valor, pago)
VALUES (6, 5, 3, '2026-09-22 09:30:00', 180.00, FALSE); -- Fernanda, Restauração

INSERT INTO agendamentos (id_funcionario, id_cliente, id_servico, data_consulta, valor, pago)
VALUES (7, 6, 1, '2026-05-26 14:00:00', 150.00, FALSE); -- Ricardo, Limpeza

INSERT INTO agendamentos (id_funcionario, id_cliente, id_servico, data_consulta, valor, pago)
VALUES (7, 6, 2, '2026-02-26 14:00:00', 200.00, TRUE); -- Ricardo, Extração
