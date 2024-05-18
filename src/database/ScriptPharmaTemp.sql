create database pharmatemp;
use pharmatemp;

create table empresa(
idEmpresa int primary key auto_increment,
nome varchar(45) not null,
cnpj char(18) unique not null,
telCelular char (13) not null,
email varchar(60) unique not null);

insert into empresa values
	(default, 'Remédio Certo', '19.411.789/0001-00', '11 91234-5678', 'remedio.certo@gmail.com'),
	(default, 'Vida+', '94.480.526/0001-60', '11 92265-5622', 'vida.mais@gmail.com'),
	(default, 'Bem Estar', '76.852.242/0001-75', '11 96421-8989', 'bem.estar@gmail.com');

select * from empresa;

create table usuario(
idCadastro int primary key auto_increment,
nome varchar (45) not null,
dtNasc date not null,
cpf char(14) unique not null,
email varchar(60) unique not null,
telCelular char(13) not null,
senha varchar(45) not null,
fkEmpresa int,
constraint fkEmpresaFunc foreign key (fkEmpresa) references empresa(idEmpresa)
)auto_increment = 100;

-- insert into usuario values
	-- (default, 'Cecília Fabiana Aurora', '1992-01-15', '567.637.942-15', 'cecilia.fabiana@gmail.com', '13 99768-5730', 'hqhhull33#', null),
	-- (default, 'Jaqueline Sabrina de Paula', '1980-01-12', '670.834.039-96', 'jaqueline.dpaula@gmail.com', '11 98896-6300', '!jt9qgnxas', null),
	-- (default, 'Vinicius da Rocha', '1999-01-10', '468.078.578-02', 'vinicius.rocha@gmail.com', '14 98613-1290', '6cf3%8dlwg', null),
	-- (default, 'Juan Fernandes Pereira', '2001-06-19', '361.549.148-30', 'juan.pereira@gmail.com', '19 99573-6826', '##n46h0i0q', null),
	-- (default, 'Augusto Lopes', '1998-07-20', '776.832.758-67', 'augusto.lopes@gmail.com', '11 98640-2239', '6fx04!elb%', null);
   
select * from usuario;

-- insert into usuario values
	-- (default, 'Fernando Brandão', '2000-10-10', '123-123-123-12', 'fernando.brandao@sptech.school', '11 91234-1234', 'Sptech#2024', 2);

-- update usuario set fkEmpresa = 1 where idusuario in (100, 101);
-- update usuario set fkEmpresa = 2 where idusuario in (102, 103);
-- update usuario set fkEmpresa = 3 where idusuario = 104;

create table endereco(
idEndereco int primary key auto_increment,
logradouro varchar(80) not null,
numEnd varchar (45) not null,
cep char(9) not null,
fkEmpresa int,
constraint fkEnderecoEmpresa foreign key (fkEmpresa) references empresa(idEmpresa));

-- insert into endereco values
	-- (default, 'Rua Rosa Cruz', 1778, '96211-120', null),
	-- (default, 'Rua Coronel Fabriciano', 651, '29171-744', null),
	-- (default, 'Rua Vista Alegre', 137, '94834-228', null),
	-- (default, 'Rua Prudêncio Martins', 886, '88703-500', null),
	-- (default, 'Rua Berilo', 120, '37701-397', null);

-- update endereco set fkEmpresa = 1 where idEndereco in (1, 2);
-- update endereco set fkEmpresa = 2 where idEndereco in (3, 4);
-- update endereco set fkEmpresa = 3 where idEndereco = 5;

select * from endereco;

create table parametro(
idParametro int primary key auto_increment,
tempMinima double not null,
tempMaxima double not null);

insert into parametro values
	(1, 2, 8);
    
    select * from parametro;

create table geladeira(
idGeladeira int primary key auto_increment,
modelo varchar(45),
marca varchar (45),
numeroSerial int,
fkEmpresa int,
constraint fkEmpresa foreign key (fkEmpresa) references empresa(idEmpresa),
fkParametro int,
constraint fkParametro foreign key (fkParametro) references parametro(idParametro));

insert into geladeira values
	(default, 'Freezer 3349/FV', 'Fanem', 1234, 1, 1),
	(default, 'Câmara de Conservação', 'Thermotemp', 44, 2, 1),
	(default, 'MC-4L316', 'Midea', 100, 3, 1);

select * from geladeira;

create table sensor(
idSensor int primary key auto_increment,
nome varchar(30),
tipo varchar (45),
fkGeladeira int,
constraint fkGeladeira foreign key (fkGeladeira) references geladeira(idGeladeira));

insert into sensor values 
(default, 'Sensor1', 'Temperatura', 1),
(default, 'Sensor2', 'Temperatura', 2),
(default, 'Sensor3', 'Temperatura', 3);

select * from sensor;

create table dado_sensor(
idDado int auto_increment,
dtHora timestamp default current_timestamp,
temperatura double,
fkSensor int,
constraint fkSensorDado foreign key (fkSensor)
	references sensor (idSensor),
primary key (idDado, fkSensor)
);

insert into dado_sensor values
	(default, default, 5, 1),
	(default, default, 3, 1),
	(default, default, 4, 1);
    
create table alerta(
idAlerta int primary key auto_increment,
resolvido varchar(45),
tipo varchar(45),
fkDadoSensor int,
constraint fkDadoSensor foreign key (fkDadoSensor) references dado_sensor(idDado));


insert into alerta values
	(default, 'Resolvido', 'Alerta Crítico', 1),
	(default, 'Não Resolvido', 'Alerta Crítico', 2),
	(default, 'Não Resolvido', 'Manutenção de Sensor', 3);
    
    
select * from alerta;
select * from dado_sensor;
select * from empresa;
select * from endereco;
select * from usuario;
select * from parametro;
select * from sensor;
select * from geladeira;

select empresa.nome as 'Nome da Empresa',
		endereco.logradouro as Rua,
        endereco.numEnd as 'Número',
        usuario.nome as 'Nome do usuario',
        geladeira.modelo as 'Modelo da Geladeira',
        geladeira.numeroSerial as 'Numero Serial',
        parametro.tempMinima as 'Temperatura Mínima',
        parametro.tempMaxima as 'Temperatura Máxima',
        sensor.nome as 'Nome do Sensor',
        dado_sensor.temperatura as 'Temperatura Armazenada',
        dado_sensor.dtHora as 'Dia e hora da armazenação',
        alerta.resolvido as Situação,
        alerta.tipo as 'Tipo de alerta'
        from empresa join endereco on fkEmpresa = idEmpresa
        join usuario on usuario.fkEmpresa = idEmpresa
        join geladeira on geladeira.fkEmpresa = idEmpresa
        join parametro on fkParametro = idParametro
        join sensor on fkGeladeira = idGeladeira
        join dado_sensor on fkSensor = idSensor
        join alerta on fkDadoSensor = idDado
        where empresa.nome = 'Remédio Certo' and endereco.numEnd = '1778' and usuario.nome like 'Jaqueline %' and dado_sensor.temperatura = 5; 
        
select * from empresa join usuario on fkEmpresa = idEmpresa;