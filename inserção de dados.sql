#1) INSERÇÃO DOS FUNCIONÁRIOS
#INSERT INTO funcionarios
#(nome_funcionario, email, celular_funcionario, cargo, salario)
#VALUES
#('nome do funciónario', 'email do funcionário', 11122233344, 'cargo do funcionário', 0);

#RECEPCIONISTA
INSERT INTO funcionarios
(nome_funcionario, email, celular_funcionario, cargo, salario)
VALUES
('Letícia Romão', 'leticiar.del@gmail.com', 19996863809, 'Recepcionista', 2500);

INSERT INTO funcionarios
(nome_funcionario, email, celular_funcionario, cargo, salario)
VALUES
('Luis Gustavo Costa', 'luis.costa@gmail.com', 19987091378, 'Recepcionista', 2300);

#FAXINEIRO
INSERT INTO funcionarios
(nome_funcionario, email, celular_funcionario, cargo, salario)
VALUES
('Cleber Machado', 'clebinho.max@gmail.com', 19976891303, 'Faxineiro', 1800);

INSERT INTO funcionarios
(nome_funcionario, email, celular_funcionario, cargo, salario)
VALUES
('Fabiana Melo', 'fabi.contato@gmail.com', 19990075430, 'Faxineiro', 1700);

#DENTISTA

INSERT INTO funcionarios
(nome_funcionario, email, celular_funcionario, cargo, salario)
VALUES
('Pedro Gomes', 'pedro.gomes@gmail.com', 19993467443, 'Dentista', 6500);

INSERT INTO funcionarios
(nome_funcionario, email, celular_funcionario, cargo, salario)
VALUES
('Joyce Professora Incrivel', 'joyce.contato@gmail.com', 19909873709, 'Dentista', 8000);

INSERT INTO funcionarios
(nome_funcionario, email, celular_funcionario, cargo, salario)
VALUES
('Neymar Junior', 'neymar.jr@gmail.com', 19995407809, 'Dentista', 9500);

#2) INSERÇÃO DOS CLIENTES 
#INSERT INTO clientes
#(nome_cliente, idade, celular_cliente, convenio, cpf)
#VALUES
#('nome do cliente', 'idade do cliente, 'celular do cliente, TRUE or FALSE para convenio, 'cpf do cliente')

INSERT INTO clientes 
(nome_cliente, idade, celular_cliente, convenio, cpf) 
VALUES 
('Ana Silva', '25', '19987654321', TRUE, '12345678901');

INSERT INTO clientes
(nome_cliente, idade, celular_cliente, convenio, cpf)
VALUES
('Carlos Eduardo', '34', '19976543210', FALSE, '23456789012');

INSERT INTO clientes
(nome_cliente, idade, celular_cliente, convenio, cpf)
VALUES
('Mariana Costa', '28', '19965432109', FALSE, '34567890123');

INSERT INTO clientes
(nome_cliente, idade, celular_cliente, convenio, cpf)
VALUES
('João Pedro', '45', '19954321098', FALSE, '45678901234');

INSERT INTO clientes
(nome_cliente, idade, celular_cliente, convenio, cpf)
VALUES
('Fernanda Lima', '19', '19943210987', TRUE, '56789012345');

INSERT INTO clientes
(nome_cliente, idade, celular_cliente, convenio, cpf)
VALUES
('Ricardo Mendes', '52', '19932109876', FALSE, '67890123456');

# INSERÇÃO DE AGENDAMENTOS 
#INSERT INTO agendamentos
#(id_funcionario, id_cliente, data_consulta, valor)
#VALUES
#(id do funcionario na tabela funcionario, id do cliente na tabela cliente, 'ano-mes-dia hora-minuto-segundo', valor se o cliente não possuir convenio)

INSERT INTO agendamentos
(id_funcionario, id_cliente, data_consulta, valor)
VALUES
(5, 1, '2026-05-20 09:00:00', DEFAULT);

INSERT INTO agendamentos
(id_funcionario, id_cliente, data_consulta, valor)
VALUES
(7, 5, '2026-05-21 08:00:00', DEFAULT);

INSERT INTO agendamentos
(id_funcionario, id_cliente, data_consulta, valor)
VALUES
(6, 2, '2026-05-20 10:30:00', 150);

INSERT INTO agendamentos
(id_funcionario, id_cliente, data_consulta, valor)
VALUES
(5, 3, '2026-05-21 11:00:00', 200);

INSERT INTO agendamentos
(id_funcionario, id_cliente, data_consulta, valor)
VALUES
(6, 4, '2026-05-22 09:30:00', 180);

INSERT INTO agendamentos
(id_funcionario, id_cliente, data_consulta, valor)
VALUES
(7, 6, '2026-05-22 14:00:00', 150);

#2) COMANDOS PRONTOS

# REMARCAR AGENDAMENTO
#UPDATE agendamentos SET data_consulta = '2026-01-01 00:00:00' WHERE id_cliente = (SELECT id_cliente FROM clientes WHERE nome_cliente = 'EXEMPLO_NOME')
UPDATE agendamentos SET data_consulta = '2026-05-22 16:30:00' WHERE id_cliente = (SELECT id_cliente FROM clientes WHERE nome_cliente = 'Mariana Costa');

# REMOVER AGENDAMENTO 
#DELETE FROM agendamentos WHERE id_cliente = (SELECT id_cliente FROM clientes WHERE nome_cliente = 'EXEMPLO')
DELETE FROM agendamentos WHERE id_cliente = (SELECT id_cliente FROM clientes WHERE nome_cliente = 'Carlos Eduardo');

# ALTERAR DENTISTA DO AGENDAMENTO 
UPDATE agendamentos SET id_funcionario = (SELECT id_funcionario FROM funcionarios WHERE nome_funcionario = 'Joyce Professora Incrivel') 
WHERE id_funcionario = (SELECT id_funcionario FROM funcionarios WHERE nome_funcionario = 'Neymar Junior' AND cargo = 'Dentista') 
AND data_consulta = '2026-05-22 14:00:00');