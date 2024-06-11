CREATE DATABASE pharmatemp;
USE pharmatemp;

-- Tabela empresa
CREATE TABLE empresa (
    idEmpresa INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(45) NOT NULL,
    cnpj CHAR(18) UNIQUE NOT NULL,
    telCelular CHAR(13) NOT NULL,
    email VARCHAR(60) UNIQUE NOT NULL
);

-- Inserção de dados na tabela empresa
INSERT INTO empresa (nome, cnpj, telCelular, email) VALUES
    ('Remédio Certo', '19.411.789/0001-00', '11 91234-5678', 'remedio.certo@gmail.com'),
    ('Vida+', '94.480.526/0001-60', '11 92265-5622', 'vida.mais@gmail.com'),
    ('Bem Estar', '76.852.242/0001-75', '11 96421-8989', 'bem.estar@gmail.com');

-- Tabela usuario
CREATE TABLE usuario (
    idCadastro INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(45) NOT NULL,
    dtNasc DATE NOT NULL,
    cpf CHAR(14) UNIQUE NOT NULL,
    email VARCHAR(60) UNIQUE NOT NULL,
    telCelular CHAR(13) NOT NULL,
    senha VARCHAR(45) NOT NULL,
    fkEmpresa INT,
    CONSTRAINT fkEmpresaFunc_usuario FOREIGN KEY (fkEmpresa) REFERENCES empresa(idEmpresa)
) AUTO_INCREMENT = 100;

SELECT * FROM usuario;

-- Tabela endereco
CREATE TABLE endereco (
    idEndereco INT PRIMARY KEY AUTO_INCREMENT,
    cep CHAR(9) NOT NULL
);

-- Tabela EmpresaEndereco
CREATE TABLE EmpresaEndereco (
    fkEmpresa INT,
    fkEndereco INT,
    logradouro VARCHAR(80),
    numEnd VARCHAR(45),
    PRIMARY KEY (fkEmpresa, fkEndereco),
    CONSTRAINT fkempresa_EmpresaEndereco FOREIGN KEY (fkEmpresa) REFERENCES empresa(idEmpresa),
    CONSTRAINT fkendereco_EmpresaEndereco FOREIGN KEY (fkEndereco) REFERENCES endereco(idEndereco)
);

-- Tabela parametro
CREATE TABLE parametro (
    idParametro INT PRIMARY KEY AUTO_INCREMENT,
    tempMinima DOUBLE NOT NULL,
    tempMaxima DOUBLE NOT NULL
);

-- Inserção de dados na tabela parametro
INSERT INTO parametro (tempMinima, tempMaxima) VALUES
    (2, 8);

-- Tabela geladeira
CREATE TABLE geladeira (
    idGeladeira INT PRIMARY KEY AUTO_INCREMENT,
    modelo VARCHAR(45),
    marca VARCHAR(45),
    numeroSerial INT,
    fkEmpresa INT,
    CONSTRAINT fkEmpresa_geladeira FOREIGN KEY (fkEmpresa) REFERENCES empresa(idEmpresa),
    fkParametro INT,
    CONSTRAINT fkParametro_geladeira FOREIGN KEY (fkParametro) REFERENCES parametro(idParametro)
);

-- Inserção de dados na tabela geladeira
INSERT INTO geladeira (modelo, marca, numeroSerial, fkEmpresa, fkParametro) VALUES
    ('Freezer 3349/FV', 'Fanem', 1234, 1, 1),
    ('Câmara de Conservação', 'Thermotemp', 44, 2, 1),
    ('MC-4L316', 'Midea', 100, 3, 1);

-- Tabela sensor
CREATE TABLE sensor (
    idSensor INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(30),
    fator FLOAT,
    fkGeladeira INT,
    CONSTRAINT fkGeladeira_sensor FOREIGN KEY (fkGeladeira) REFERENCES geladeira(idGeladeira)
);

-- Inserção de dados na tabela sensor
INSERT INTO sensor (nome, fator, fkGeladeira) VALUES 
    ('Sensor1', 1, 1),
    ('Sensor2', 1.3, 2),
    ('Sensor3', 0.5, 3);


CREATE VIEW tempDif AS (SELECT (m.temperatura * s.fator) AS 'Temperatura', s.nome FROM sensor AS s, medida AS m);
SELECT  * FROM tempDif;


-- Tabela medida
CREATE TABLE medida (
    idMedida INT AUTO_INCREMENT,
    dtHora TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    temperatura DOUBLE,
    fkSensor INT,
    CONSTRAINT fkSensor_medida FOREIGN KEY (fkSensor) REFERENCES sensor(idSensor),
    PRIMARY KEY (idMedida, fkSensor)
);

-- Inserção de dados na tabela medida
INSERT INTO medida (temperatura, fkSensor) VALUES
    (5, 2),
    (3, 2),
    (4, 2);

-- Tabela alerta
CREATE TABLE alerta (
    idAlerta INT PRIMARY KEY AUTO_INCREMENT,
    resolvido VARCHAR(45),
    tipo VARCHAR(45),
    fkDadoSensor INT,
    CONSTRAINT fkDadoSensor_alerta FOREIGN KEY (fkDadoSensor) REFERENCES medida(idMedida)
);

-- Inserção de dados na tabela alerta
INSERT INTO alerta (resolvido, tipo, fkDadoSensor) VALUES
    ('Resolvido', 'Alerta Crítico', 1),
    ('Não Resolvido', 'Alerta Crítico', 2),
    ('Não Resolvido', 'Manutenção de Sensor', 3);

-- Consultas
SELECT * FROM empresa;
SELECT * FROM endereco;
SELECT * FROM usuario;
SELECT * FROM parametro;
SELECT * FROM sensor;
SELECT * FROM geladeira;
SELECT * FROM medida;
SELECT * FROM alerta;

-- Consulta detalhada
SELECT empresa.nome AS 'Nome da Empresa',
       EmpresaEndereco.logradouro AS 'Rua',
       EmpresaEndereco.numEnd AS 'Número',
       usuario.nome AS 'Nome do usuario',
       geladeira.modelo AS 'Modelo da Geladeira',
       geladeira.numeroSerial AS 'Numero Serial',
       parametro.tempMinima AS 'Temperatura Mínima',
       parametro.tempMaxima AS 'Temperatura Máxima',
       sensor.nome AS 'Nome do Sensor',
       medida.temperatura AS 'Temperatura Armazenada',
       medida.dtHora AS 'Dia e hora da armazenação',
       alerta.resolvido AS 'Situação',
       alerta.tipo AS 'Tipo de alerta'
FROM empresa
JOIN EmpresaEndereco ON empresa.idEmpresa = EmpresaEndereco.fkEmpresa
JOIN endereco ON EmpresaEndereco.fkEndereco = endereco.idEndereco
JOIN usuario ON usuario.fkEmpresa = empresa.idEmpresa
JOIN geladeira ON geladeira.fkEmpresa = empresa.idEmpresa
JOIN parametro ON geladeira.fkParametro = parametro.idParametro
JOIN sensor ON sensor.fkGeladeira = geladeira.idGeladeira
JOIN medida ON medida.fkSensor = sensor.idSensor
JOIN alerta ON alerta.fkDadoSensor = medida.idMedida
WHERE empresa.nome = 'Remédio Certo' AND EmpresaEndereco.numEnd = '1778' AND usuario.nome LIKE 'Jaqueline %' AND medida.temperatura = 5;

-- Outra consulta
SELECT temperatura, DATE_FORMAT(dtHora, '%H:%i:%s') AS momentoRegistro
FROM medida
WHERE temperatura >= 9 OR temperatura <= 1;
