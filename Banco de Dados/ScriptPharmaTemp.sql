create database pharmatemp;
use pharmatemp;

create table empresa(
idEmpresa int primary key auto_increment,
nome varchar(45) not null,
cnpj char(14) unique not null,
telCelular char (11) not null,
email varchar(60) unique not null);

insert into empresa values
	(default, 'Remédio Certo', '19.411.789/0001-00', '11 91234-5678', 'remedio.certo@gmail.com'),
	(default, 'Vida+', '94.480.526/0001-60', '11 92265-5622', 'vida.mais@gmail.com'),
	(default, 'Bem Estar', '76.852.242/0001-75', '11 96421-8989', 'bem.estar@gmail.com');

select * from empresa;

create table funcionario(
idFuncionario int primary key auto_increment,
nome varchar (45) not null,
dtNasc date not null,
cpf char(11) unique not null,
email varchar(60) unique not null,
telCelular char(11) not null,
senha varchar(45) not null,
fkEmpresa int,
constraint fkEmpresaFunc foreign key (fkEmpresa) references empresa(idEmpresa)
)auto_increment = 100;

insert into funcionario values
	(default, 'Cecília Fabiana Aurora', '1992-01-15', '567.637.942-15', 'cecilia.fabiana@gmail.com', '13 99768-5730', 'hqhhull33#', null),
	(default, 'Jaqueline Sabrina de Paula', '1980-01-12', '670.834.039-96', 'jaqueline.dpaula@gmail.com', '11 98896-6300', '!jt9qgnxas', null),
	(default, 'Vinicius da Rocha', '1999-01-10', '468.078.578-02', 'vinicius.rocha@gmail.com', '14 98613-1290', '6cf3%8dlwg', null),
	(default, 'Juan Fernandes Pereira', '2001-06-19', '361.549.148-30', 'juan.pereira@gmail.com', '19 99573-6826', '##n46h0i0q', null),
	(default, 'Augusto Lopes', '1998-07-20', '776.832.758-67', 'augusto.lopes@gmail.com', '11 98640-2239', '6fx04!elb%', null);
    
select * from funcionario;

update funcionario set fkEmpresa = 1 where idFuncionario in (100, 101);
update funcionario set fkEmpresa = 2 where idFuncionario in (102, 103);
update funcionario set fkEmpresa = 3 where idFuncionario = 104;

create table endereco(
idEndereco int primary key auto_increment,
logradouro varchar(80) not null,
numEnd varchar (45) not null,
cep char(9) not null);

insert into endereco values
	(default, 'Rua Rosa Cruz', 1778, '96211-120'),
	(default, 'Rua Coronel Fabriciano', 651, '29171-744'),
	(default, 'Rua Vista Alegre', 137, '94834-228'),
	(default, 'Rua Prudêncio Martins', 886, '88703-500'),
	(default, 'Rua Berilo', 120, '37701-397');
    
    select * from endereco;

create table parametro(
idParametro int primary key auto_increment,
tempMinima double not null,
temMaxima double not null);

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
(default, 'Geladeira Convencional', 'Eletrolux', 1234, 1, 1);

create table sensor(
idSensor int primary key auto_increment,
nome varchar(30),
tipo varchar (45),
fkGeladeira int,
constraint fkGeladeira foreign key (fkGeladeira) references geladeira(idGeladeira));

create table dado_sensor(
idDado int auto_increment,
fkSensor int,
constraint pkComposta primary key (idDado, fkSensor),
dtHora timestamp default current_timestamp,
temperatura double,
constraint fkSensor foreign key (fkSensor) references sensor(idSensor));

create table alerta(
idAlerta int primary key auto_increment,
resolvido varchar(45),
fkDadoSensor int,
constraint fkDadoSensor foreign key (fkDadoSensor) references dado_sensor(idDado));




