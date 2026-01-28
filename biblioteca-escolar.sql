--Modelagem física da Biblioteca escolar
create database biblioteca_escolar;

create table usuario(
	id serial primary key,
	nome varchar(50) not null,
	matricula char(10) not null unique,
	email varchar(50) not null unique,
	telefone char(14) not null,
	status boolean not null,
	bloqueio boolean not null,
	perfil varchar(9) not null
);

create table emprestimo(
	id serial primary key,
	data_prev_dev timestamp not null,
	data_retirada timestamp not null,
	fk_usuario int not null references usuario(id)
);

create table livro(
	id serial primary key,
	titulo varchar(100) not null,
	autor varchar(80) not null,
	genero varchar(15) not null,
	editora varchar(30) not null,
	n_copias int not null,
	descricao_conservacao text not null
);

create table emprestimo_livro(
	id_emprestimo int references emprestimo(id),
	id_livro int references livro(id),
	data_real_dev timestamp not null,
	primary key(id_emprestimo, id_livro)
);

--drop table emprestimo_livro;
