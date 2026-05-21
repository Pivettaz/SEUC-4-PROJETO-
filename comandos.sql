#0) TABELAS ANTES EDIÇÃO
SELECT * FROM funcionarios;
SELECT * FROM clientes;
SELECT * FROM agendamentos;

#1) COMANDOS TABELA AGENDAMENTOS

#1-1) REMARCAR AGENDAMENTO
#UPDATE agendamentos SET data_consulta = '2026-01-01 00:00:00' 
#WHERE id_cliente = (SELECT id_cliente FROM clientes WHERE nome_cliente = 'EXEMPLO_NOME')

UPDATE agendamentos SET data_consulta = '2026-05-22 16:30:00' 
WHERE id_cliente = (SELECT id_cliente FROM clientes WHERE nome_cliente = 'Mariana Costa');

#1-2) REMOVER AGENDAMENTO 
#DELETE FROM agendamentos WHERE id_cliente = (SELECT id_cliente FROM clientes WHERE nome_cliente = 'EXEMPLO')

DELETE FROM agendamentos WHERE id_cliente = (SELECT id_cliente FROM clientes WHERE nome_cliente = 'Carlos Eduardo');

#1-3) ALTERAR DENTISTA DO AGENDAMENTO 
#UPDATE agendamentos SET id_funcionario = (SELECT id_funcionario FROM funcionarios WHERE nome_funcionario = 'Nome do Novo Dentista')
#WHERE id_funcionario = (SELECT id_funcionario FROM funcionarios WHERE nome_funcionario = 'Nome do Antigo Dentista')
#AND data_consulta = '2026-01-01 00:00:00';

UPDATE agendamentos SET id_funcionario = (SELECT id_funcionario FROM funcionarios WHERE nome_funcionario = 'Joyce Professora Incrivel') 
WHERE id_funcionario = (SELECT id_funcionario FROM funcionarios WHERE nome_funcionario = 'Neymar Junior') 
AND data_consulta = '2026-05-22 14:00:00';

#1-4) ALTERAR VALOR DO AGENDAMNETO 
#UPDATE agendamentos SET valor = 999 
#WHERE id_cliente = (SELECT id_cliente FROM clientes WHERE nome_cliente = 'Nome Cliente') 
#AND data_consulta = '2026-01-01 00:00:00';

UPDATE agendamentos SET valor = 150
WHERE id_cliente = (SELECT id_cliente FROM clientes WHERE nome_cliente = 'Mariana Costa')
AND data_consulta = '2026-05-22 16:30:00';
#COLOCAR O CASO DO CONVENIO


#2) COMANDOS TABELA CLIENTES

#2-1) ALTERAR CELULAR CLIENTE
#UPDATE clientes SET celular_cliente = '11999999999' WHERE nome_cliente = 'Nome Cliente';

UPDATE clientes SET celular_cliente = '19996863809' WHERE nome_cliente = 'Ana Silva';

#2-2) ALTERAR CONVÊNIO CLIENTE
#UPDATE clientes SET convenio = 0/1 WHERE nome_cliente = 'Nome Cliente';

UPDATE clientes SET convenio = 1 WHERE nome_cliente = 'João Pedro';


#3) COMANDOS TABELA FUNCIONÁRIOS

#3-1) ALTERAR CELULAR FUNCIONÁRIO
#UPDATE funcionarios SET celular_funcionario = '11999999999' WHERE nome_funcionario = 'Nome Funcionário';

UPDATE funcionarios SET celular_funcionario = '19996864069' WHERE nome_funcionario = 'Fabiana Melo';

#3-2)
#UPDATE funcionarios SET salario = 9999 WHERE nome_funcionario = 'Nome Funcionário';

UPDATE funcionarios SET salario = 2600 WHERE nome_funcionario = 'Luis Gustavo Costa';

#4) TABELAS APÓS EDIÇÃO 

SELECT * FROM agendamentos;
SELECT * FROM funcionarios;
SELECT * FROM clientes;