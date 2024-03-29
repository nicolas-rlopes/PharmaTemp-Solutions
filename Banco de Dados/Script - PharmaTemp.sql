CREATE DATABASE PharmTemp;

USE PharmTemp;

CREATE TABLE cadastro (
	idCadastro INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(50) NOT NULL,
	dtNasc DATE NOT NULL,
    cpf CHAR(11) UNIQUE NOT NULL,
    email VARCHAR(60) UNIQUE NOT NULL,
    telefone CHAR (11) NOT NULL,
    senha VARCHAR(25) NOT NULL,
    constraint chkEmail check (email like ("%@%"))
);

CREATE TABLE sensor(
	idSensor INT PRIMARY KEY AUTO_INCREMENT,
    nomeSensor VARCHAR(30),
    tipo VARCHAR(45),
	constraint chkTipo check (tipo in("Temperatura"))
);

CREATE TABLE dado_sensor (
	idDado INT PRIMARY KEY AUTO_INCREMENT,
    data_hora datetime default current_timestamp,
    temperatura DOUBLE NOT NULL,
    fkSensor INT NOT NULL,
    constraint fkSensorDadoSensor foreign key (fkSensor)
		references sensor(idSensor)
);

CREATE TABLE condicaoIdeal (
	idCondIdeal INT AUTO_INCREMENT PRIMARY KEY,
	temperaturaMinIdeal DOUBLE, 
	temperaturaMaxIdeal DOUBLE,
	fkSensor INT not null, 
	CONSTRAINT chkTemp CHECK(temperaturaMinIdeal >= 2 AND temperaturaMaxIdeal <=8),
    constraint fkSensorCondicaoIdeal foreign key (fkSensor)
		references sensor(idSensor)
);

CREATE TABLE alerta (
	idAlerta INT AUTO_INCREMENT PRIMARY KEY,
	temperaturaMinAlerta DOUBLE,
	temperaturaMaxAlerta DOUBLE,
	fkSensor INT not null,
    CONSTRAINT chkTempe CHECK(temperaturaMinAlerta < 2 AND temperaturaMaxAlerta > 8),
    constraint fkSensorAlerta foreign key (fkSensor)
		references sensor(idSensor)
);

insert into cadastro values
(default, 'João', '2000-03-01', '19516410545', 'joao@gmail.com', '11948721640', 'senha123'),
(default, 'Ana', '1998-07-23', '95830584627', 'ana@gmail.com', '11948562058', 'senha456');

select nome as Nome,
date_format (dtNasc, '%d %m %y') as 'Data de Nascimento',
cpf as CPF,
email as Email,
telefone as Telefone,
senha as Senha from cadastro;

insert into sensor values
(default, 'geladeira 1', 'Temperatura'),
(default, 'geladeira 2', 'Temperatura'),
(default, 'geladeira 3', 'Temperatura'),
(default, 'geladeira 4', 'Temperatura'),
(default, 'geladeira 5', 'Temperatura');

insert into dado_sensor values
(default, '2024-03-28 13:30:00', 6, 1),
(default, '2024-03-28 13:30:00', 10, 5),
(default, '2024-03-28 13:30:00', 1, 2);

select * from dado_sensor
join sensor on idSensor = fkSensor;




