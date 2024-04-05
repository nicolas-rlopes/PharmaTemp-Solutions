CREATE DATABASE PharmTemp;

USE PharmTemp;

CREATE TABLE empresa (
	idEmpresa INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(45) NOT NULL,
    cnpj CHAR(14) UNIQUE NOT NULL,
    telefone CHAR (11) NOT NULL,
    email VARCHAR(60) UNIQUE NOT NULL,
    endereco varchar(55),
    cep CHAR(8) NOT NULL,
    constraint chkEmail check (email like ("%@%"))
);

CREATE TABLE cadastro (
	idCadastro INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(50) NOT NULL,
	dtNasc DATE NOT NULL,
    cpf CHAR(11) UNIQUE NOT NULL,
    email VARCHAR(60) UNIQUE NOT NULL,
    telefone CHAR (11) NOT NULL,
    senha VARCHAR(25) NOT NULL,
    fkEmpresa int not null, 
    CONSTRAINT chkEmail2 CHECK (email like ("%@%")),
    constraint fkEmpresaCadastro foreign key (fkEmpresa)
		references empresa(idEmpresa) 
);

CREATE TABLE sensor(
	idSensor INT PRIMARY KEY AUTO_INCREMENT,
    nomeSensor VARCHAR(30),
    tipo VARCHAR(45),
	fkEmpresa int not null,
    constraint chkTipo check (tipo in("Temperatura")),
    constraint fkEmpresaSensor foreign key (fkEmpresa)
		references empresa(idEmpresa)
);

CREATE TABLE dado_sensor (
	idDado INT PRIMARY KEY AUTO_INCREMENT,
    data_hora datetime default current_timestamp,
    temperatura DOUBLE NOT NULL,
    fkSensor INT NOT NULL,
    constraint fkSensorDadoSensor foreign key (fkSensor)
		references sensor(idSensor)
);

CREATE TABLE alerta (
	idAlerta INT AUTO_INCREMENT PRIMARY KEY,
	temperatura DOUBLE,
	fkDado_Sensor INT not null,
    CONSTRAINT chkTempe CHECK(temperatura < 2 AND temperatura > 8),
    constraint fkDado_SensorAlerta foreign key (fkDado_Sensor)
		references dado_sensor(idDado)
);

insert into empresa values
(default, 'Johnson & Johnson', '54516661000101', '08007036363', 'j&j@gmail.com', 'rua holanda 2020', '02349598'),
(default, 'Pfizer', '46070868001998', '11518585000', 'pfizer@gmail.com', 'avenida ribeira 5609', '23049873');

insert into cadastro values
(default, 'João', '2000-03-01', '19516410545', 'joao@gmail.com', '11948721640', 'senha123', 1),
(default, 'Ana', '1998-07-23', '95830584627', 'ana@gmail.com', '11948562058', 'senha456', 2);

select nome as Nome,
date_format (dtNasc, '%d %m %y') as 'Data de Nascimento',
cpf as CPF,
email as Email,
telefone as Telefone,
senha as Senha from cadastro;

insert into sensor values
(default, 'geladeira 1', 'Temperatura', 1),
(default, 'geladeira 2', 'Temperatura', 2),
(default, 'geladeira 3', 'Temperatura', 2),
(default, 'geladeira 4', 'Temperatura', 2),
(default, 'geladeira 5', 'Temperatura', 1);

insert into dado_sensor values
(default, '2024-03-28 13:30:00', 6, 1),
(default, '2024-03-28 13:30:00', 10, 5),
(default, '2024-03-28 13:30:00', 1, 2);

select * from dado_sensor
join sensor on idSensor = fkSensor;




