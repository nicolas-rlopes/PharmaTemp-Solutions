CREATE DATABASE pharmtemp;

USE pharmtemp;
/* ------------------------------------------------------------------------------------------------------------------------------ */

/* --- Cadastro Cliente --- */
CREATE TABLE cadastro (
	idCadastro INT PRIMARY KEY AUTO_INCREMENT,
    cpfUsuario CHAR(11) UNIQUE NOT NULL,
    nomeUsuario VARCHAR(50) NOT NULL,
    emailUsuario VARCHAR(60) UNIQUE NOT NULL,
    senhaUsuario VARCHAR(25) NOT NULL,
    telefone CHAR (13) NOT NULL,
    dtNasc DATE NOT NULL
);
/* ------------------------------------------------------------------------------------------------------------------------------ */

/* --- Cadastro Dispositivo Arduino --- */
CREATE TABLE sensor(
	idSensor INT PRIMARY KEY AUTO_INCREMENT,
    nomeSensor VARCHAR(45),
    tipo VARCHAR(45)
);

/* --- Dados de Temperatura e Umidade --- */
CREATE TABLE dado_sensor (
	idDado INT PRIMARY KEY AUTO_INCREMENT,
    sensor_id INT NOT NULL,  -- FOREIGN KEY
    temperatura DOUBLE NOT NULL,
    data_hora DATETIME NOT NULL
);
/* ------------------------------------------------------------------------------------------------------------------------------ */

/* --- Condições Ideais de Temperatura --- */
CREATE TABLE condicaoIdeal
(
idCondIdeal INT AUTO_INCREMENT PRIMARY KEY,
dispositivo_id INT, -- FOREIGN KEY(idDispositivo) -- Dispositivo com condições ideais para o armazenamento.
temperaturaMinIdeal DOUBLE, -- >= 2°C
temperaturaMaxIdeal DOUBLE -- <= 8°C
);



/* --- Emissão de Alerta para Condições não Ideais --- */
CREATE TABLE alerta
(
idAlerta INT AUTO_INCREMENT PRIMARY KEY,
dispositivo_id INT, -- FOREIGN KEY(idDispositivo) -- Dispositivo que emitirá o alerta.
temperaturaMinAlerta DOUBLE, -- < 2°C
temperaturaMaxAlerta DOUBLE -- > 8°C 
);s
