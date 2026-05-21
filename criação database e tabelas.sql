CREATE DATABASE odonpuc;
USE odonpuc;

CREATE TABLE funcionarios (
id_funcionario INT PRIMARY KEY AUTO_INCREMENT,
nome_funcionario VARCHAR(100) NOT NULL,
email VARCHAR(100) UNIQUE, 
celular_funcionario CHAR(11) UNIQUE NOT NULL,
cargo VARCHAR(50) NOT NULL,
salario INT NOT NULL);

CREATE TABLE clientes (
id_cliente INT PRIMARY KEY AUTO_INCREMENT,
nome_cliente VARCHAR(100) NOT NULL,
idade CHAR(3) NOT NULL,
celular_cliente CHAR(11) UNIQUE NOT NULL,
convenio BOOLEAN,
cpf CHAR(11) UNIQUE NOT NULL);

CREATE TABLE agendamentos (
id_agendamento INT PRIMARY KEY AUTO_INCREMENT,
id_funcionario INT,
id_cliente INT,
data_consulta DATETIME,
valor INT DEFAULT 00,
FOREIGN KEY (id_funcionario) REFERENCES funcionarios(id_funcionario),
FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente));





