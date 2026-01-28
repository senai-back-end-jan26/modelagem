--Modelagem física da Clínica Veterinária
create database clinica_veterinaria;

create table dono(
	id serial primary key,
	nome varchar(80) not null,
	cpf char(11) not null unique,
	status boolean not null
);

create table telefone(
	id serial primary key,
	numero varchar(14) not null,
	fk_dono int not null references dono(id)
);

create table endereco(
	id serial primary key,
	cep char(8) not null,
	logradouro varchar(100) not null,
	localidade varchar(50) not null,
	uf char(2) not null,
	bairro varchar(50) not null,
	numero int not null,
	complemento varchar(30),
	referencia varchar(100),
	principal boolean not null,
	fk_dono int not null references dono(id)
);

create table animal(
	id serial primary key,
	nome varchar(30) not null,
	especie varchar(30) not null,
	raca varchar(30) not null,
	idade int not null,
	infos_medicas text,
	status boolean not null,
	fk_dono int not null references dono(id)
);

create table consulta(
	id serial primary key,
	data_hora timestamp not null,
	fk_animal int not null references animal(id)
);

create table veterinario(
	id serial primary key,
	nome varchar(80) not null,
	crmv char(13) not null unique,
	especializacao varchar(80) not null,
	jornada int not null
);
--drop table veterinario_consulta;
create table veterinario_consulta(
	id_veterinario int references veterinario(id),
	id_consulta int references consulta(id),
	obs_medicas text not null,
	primary key(id_veterinario, id_consulta)
);