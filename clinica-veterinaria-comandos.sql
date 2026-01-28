--1) Altere o tamanho do campo nome do veterinário para 100 caracteres.
alter table veterinario alter column nome type varchar(100);

--2) Insira 3 registros em cada uma das 7 tabelas.
insert into dono(nome, cpf, status) values
('Alice Guimarães', '12345678911', true),
('Bernardo Vasques', '11122233300', true),
('Jeferson Aguiar', '00112255447', true);

insert into veterinario(nome, crmv, especializacao, jornada) values
('Júlia Vieira', 'CRMV-RJ123456', 'Clínico', 4),
('Wilson Marques', 'CRMV-RJ112233', 'Cirurgião', 4),
('Valéria Andrade', 'CRMV-RJ012344', 'Dermato', 6);

insert into endereco(cep, logradouro, localidade, uf, bairro, numero, complemento, referencia, principal, fk_dono) values
('25650320', 'Rua Pará', 'Petrópolis', 'RJ', 'Quitandinha', 0, 'Lote 55', 'Em frente ao mercado Xodó', true, 1),
('25620321', 'Rua do Alemão', 'Petrópolis', 'RJ', 'Centro', 10, null, null, true, 2),
('25600000', 'Rua das Flores', 'Petrópolis', 'RJ', 'Bingen', 1, null, null, true, 3);

insert into telefone(numero, fk_dono) values
('(24)99999-6688', 1),
('(24)98456-9966', 2),
('(24)98520-3201', 3);

insert into animal(nome, especie, raca, idade, infos_medicas, status, fk_dono) values
('Flor', 'gato', 'Não declarado', 1, null, true, 1),
('Mia', 'gato', 'Não declarado', 2, null, true, 1),
('Laila', 'gato', 'Não declarado', 8, null, true, 1);

insert into consulta(data_hora, fk_animal) values
('2026-01-30 10:00', 1),
('2025-12-01 18:00', 3),
('2026-02-20 09:30', 1);

insert into veterinario_consulta(id_veterinario, id_consulta, obs_medicas) values
(1, 1, 'primeira consulta, vacinação'),
(2, 2, 'acompanhamento de tratamento'),
(1, 3, 'retorno do pet');

--3) Atualize o status do animal de id = 2.
update animal set status = false where id = 2;

--4) Remova a consulta de id = 1.
delete from veterinario_consulta where id_consulta = 1;
delete from consulta where id = 1;

--5) Altere a data da consulta de id = 2.
update consulta set data_hora = '2026-12-12 10:00' where id = 2;

--6) Crie uma view com os dados: nome do veterinário, nome do dono,
--nome do animal, telefone do dono, data e hora da consulta e observações
--médicas.
create view relatorio_consultas as
select
	v.nome as "Nome do Veterinário",
	d.nome as "Nome do Dono",
	a.nome as "Nome do Animal",
	t.numero,
	c.data_hora,
	vc.obs_medicas 
from dono d
join telefone t on t.fk_dono = d.id 
join animal a on a.fk_dono = d.id 
join consulta c on c.fk_animal = a.id 
join veterinario_consulta vc on vc.id_consulta = c.id 
join veterinario v on v.id = vc.id_veterinario;

--7) Selecione todas as consultas de um veterinário qualquer (variável).
select * from consulta c
join veterinario_consulta vc on vc.id_consulta = c.id
where id_veterinario = :idVeterinario;