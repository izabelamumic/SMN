-- cria um banco de dados
CREATE DATABASE db_Biblioteca

-- cria tabelas
CREATE TABLE tbl_Livro
(ID_Livro SMALLINT PRIMARY KEY IDENTITY(100,1),
nome_Livro VARCHAR (50) NOT NULL,
ISBN VARCHAR(30) NOT NULL UNIQUE,
id_Autor SMALLINT NOT NULL,
data_Pub DATETIME NOT NULL,
preco_Livro MONEY NOT NULL)

CREATE TABLE tbl_Autor(
id_Autor SMALLINT PRIMARY KEY,
nome_Autor VARCHAR(50),
sobrenome_Autor VARCHAR(50))

CREATE TABLE tbl_Editoras(
id_Editora SMALLINT PRIMARY KEY IDENTITY,
nome_Editora VARCHAR(50) NOT NULL)

--sp_help tbl_editoras

CREATE TABLE tbl_Teste_Identidade
(id_Teste SMALLINT PRIMARY KEY IDENTITY,
valor SMALLINT NOT NULL)

-- insere dados na tabela
INSERT INTO tbl_teste_identidade (valor) 
VALUES (10),
		(20),
		(30),
		(40);

-- faz consulta, mostra tudo que tem na tabela teste identidade
SELECT * FROM tbl_teste_identidade

use bd_Biblioteca

-- Excluir uma coluna
alter table tbl_Livro
drop column id_Autor

-- Adicionar uma coluna
alter table tbl_Livro
add id_Autor smallint not null,
constraint fk_id_Autor foreign key(id_Autor)
references tbl_Autor

alter table tbl_Livro
add id_Editora smallint not null
constraint fk_id_Editora foreign key(id_Editora)
references tbl_Editoras

-- alterar o tipo de dado da tabela
alter table tbl_Livro
alter column id_Autor smallint 

-- Alterar tabela
--alter table NOME TABELA
--add primary key (NOME CAMPO)

-- Excluir uma tabela
drop table tbl_Teste_Identidade

-- inserir dados na tabela
insert into tbl_Autor (id_Autor, nome_Autor, sobrenome_Autor)
values	(1, 'Daniel', 'Barret'),
		(2, 'João', 'Camargo'),
		(3, 'Carlos', 'Barret'),
		(4, 'Mario', 'Camargo'),
		(5, 'Otavio', 'Silva');

insert into tbl_Editoras (nome_Editora)
values	('Prentice Hall'),
		('O Reilly'),
		('Microsoft Press'),
		('Wiley');

insert into tbl_Livro (nome_Livro, ISBN, data_Pub, preco_Livro, id_Autor, id_Editora)
values	('Linux Command Lione ', 98794613, '20091221', 67.35, null ,4),
		('Linux Command Lione and Shell Scripting', 1234569, '20091221', 68.35,5,4),
		('SSH, the Secure Shell', 123564321, '20091221', 58.30,1,2),
		('Using Samba', 123456789, '20001221', 61.45,2,2),
		('Using', 461215788, '7845123', 61.45,2,2);

-- consulta 
-- SELECT coluna FROM tabela
-- SELECT * (* = todos as colonas) FROM tabela
select nome_Autor from tbl_Autor
select nome_livro from tbl_Livro
-- trazer mais de uma coluna
select nome_Livro, isbn from tbl_Livro

-- ordena coluna nome_livro
select * from  tbl_Livro 
order by nome_livro

select nome_Autor from tbl_Autor order by nome_Autor

-- mostrar apaenas valores diferentes
select distinct id_Autor from tbl_Livro

-- mostrar na tabela livro apenas autores com id 2
select * from tbl_Livro
where id_autor = '2'

select id_Autor from tbl_Autor
where nome_Autor = 'Daniel'

-- condições
select * from tbl_Livro where id_Livro > 101 or id_Autor < 3
select * from tbl_Livro where id_Livro > 101 and id_Autor < 3

-- atualizar dados na tabela
-- UPDATE tabela SET coluna = valor WHERE filtro
update tbl_Livro 
set preco_Livro = 63.12 
where id_Livro = '101';

update tbl_Livro 
set preco_Livro = 80.00,
ISBN = '321456' 
where id_Livro = '102';

update tbl_Autor
set sobrenome_Autor = 'Alves' 
where id_Autor = 2;

-- mostrar os 10% primeiros registros da tabela libro
select top 10 percent nome_Livro from tbl_Livro

-- mostrar os 3 primeiros registros da tabela libro
select top 3 nome_Livro from tbl_Livro

-- retornar Livro para tabela livro na coluna nome_Livro
select nome_Livro
as Livro
from tbl_Livro

select nome_Livro
as Livro, id_autor as Autor
from tbl_Livro

-- concatenar dados
-- SELECT colunas FROM tabela1 UNION SELECT colunas FROM table2
select id_Autor from tbl_Autor
union
select id_Autor from tbl_Livro

-- mostra tudo 
select nome_Autor from tbl_Autor
union all
select nome_livro from tbl_Livro

-- pega dados de uma ou mais tabelas e cria uma nova tabela com esses dados
-- SELECT * INTO nova_tabela FROM tabela_atual
SELECT * INTO LivroAutor FROM tbl_Autor
select * into tbl_livro_backup from tbl_Livro

drop table LivroAutor
drop table tbl_livro_backup

-- mostrar quantos registros tem na tabela autor
select count(*) from tbl_Autor
-- mostrar quantos registros tem na coluna nome_autor da tabela autor
select count(nome_Autor) from tbl_Autor

-- mostrar o maior valor da coluna preço na tabela livro
select max(preco_Livro) from tbl_Livro

-- mostrar o valor mais baixo da coluna preço na tabela livro
select MIN(preco_Livro) from tbl_Livro

-- mostrar a media aritmética dos preos da tabela livro
select avg(preco_Livro) from tbl_Livro

-- mostrar a soma dos preos da tabela livro
select sum(preco_Livro) from tbl_Livro

-- retornar a data de publicação esteja entre 20040517 e 20100517
-- SELECT coluna FROM tabela WHERE coluna BETWEEN valor1 AND valor2
SELECT * FROM tbl_Livro 
WHERE data_Pub 
BETWEEN '20040517' AND '20100517'

select nome_Livro 
as Livro, preco_Livro 
from tbl_Livro 
where preco_Livro 
between 50.00 and 70.00

-- mostrar apenas os livros que começam o nome com a letra U
select nome_Livro 
from  tbl_Livro
where nome_Livro like 'U%'

-- mostrar apenas os livros que não começa a letra L
select nome_Livro 
from  tbl_Livro
where nome_Livro not like 'L%'

-- mostrar apenas os livros que começam o nome com a letra S ou L
select nome_Livro 
from  tbl_Livro
where nome_Livro like '[SL]%'


-- mostrar apenas os livros que terminam o nome com a letra g
select nome_Livro 
from  tbl_Livro
where nome_Livro like '%g'

-- mostrar apenas os livros que terminam o nome com a letra g ou l
select nome_Livro 
from  tbl_Livro
where nome_Livro like '%[gl]'

-- mostrar apenas os livros que a segunda letra do nome é i
select nome_Livro 
from  tbl_Livro
where nome_Livro like '_i%'

-- mostrar apenas os livros que a segunda letra do nome é i ou s
select nome_Livro 
from  tbl_Livro
where nome_Livro like '_[is]%'

-- mostrar apenas os livros que a segunda letra do nome é i e a quinta é o
select nome_Livro 
from  tbl_Livro
where nome_Livro like '_i__x%'

-- junta os id_autor da tabela livro com os id_livro da tabela livro
-- SELECT coluna FROM tabela1 INNER JOIN tabela2 ON tabela1.coluna=tabela2.coluna
SELECT * FROM tbl_Livro 
INNER JOIN tbl_Autor 
ON tbl_Livro.id_Autor = tbl_Autor.id_Autor


SELECT tbl_Livro.nome_livro, tbl_Livro.ISBN,
tbl_Autor.nome_Autor from tbl_Livro
INNER JOIN tbl_Autor 
ON tbl_Livro.id_Autor = tbl_Autor.id_Autor

SELECT L.nome_livro, E.nome_Editora
from tbl_Livro 
as L
INNER JOIN tbl_Editoras as E
ON L.id_Editora = E.id_Editora

-- mostrar apenas os registros que tem correspondência na tabela de autor e livro
-- SELECT coluna FROM tabela_esq LEFT(OUTER) JOIN tabela_dir ON tabela_esq.coluna = tabela_dir.coluna
SELECT * FROM tbl_Autor 
LEFT JOIN tbl_Livro 
ON tbl_Livro.id_Autor = tbl_Autor.id_Autor

SELECT * FROM tbl_Autor 
RIGHT JOIN tbl_Livro 
ON tbl_Livro.id_Autor = tbl_Autor.id_Autor

-- mostrar todos os registros que tem e não tem correspondência na tabela de autor e livro
SELECT * FROM tbl_Livro 
LEFT JOIN tbl_Autor
ON tbl_Livro.id_Autor = tbl_Autor.id_Autor

SELECT * FROM tbl_Livro 
RIGHT JOIN tbl_Autor
ON tbl_Livro.id_Autor = tbl_Autor.id_Autor


-- mostrando apenas correspondências nullas
SELECT * FROM tbl_Autor 
LEFT JOIN tbl_Livro 
ON tbl_Livro.id_Autor = tbl_Autor.id_Autor
where tbl_Livro.id_Autor is null

SELECT * FROM tbl_Autor 
RIGHT JOIN tbl_Livro 
ON tbl_Livro.id_Autor = tbl_Autor.id_Autor
where tbl_Livro.id_Autor is null

--full join junta as correspondencias da tabela a esquerda e a direita
--SELECT coluna FROM tabela1 FULL(OUTER)JOIN tabela2 ON tabela1.coluna = tabela2.coluna
SELECT Li.nome_Livro, Li.id_Autor, Au.nome_Autor
FROM tbl_Livro AS Li
FULL JOIN tbl_Autor AS Au
ON Li.id_Autor = Au.id_Autor

-- mostrando apenas correspondências nullas
SELECT Li.nome_Livro, Li.id_Autor, Au.nome_Autor
FROM tbl_Livro AS Li
FULL JOIN tbl_Autor AS Au
ON Li.id_Autor = Au.id_Autor
where Li.id_Autor is null
or Au.id_Autor is null

-- seleciona todos os dados da tabela livro onde todos os valores do id do autor seja 1 e 2
-- expressão_teste (NOT) IN (subconsulta|lita)
select * from tbl_Livro
where id_Autor in (1,2)

-- seleciona todos os dados da tabela livro onde todos os valores do id do autor não seja 1 e 2
select * from tbl_Livro
where id_Autor not in (1,2)

-- criar indice
-- CREATE INDEX nome_indice ON nome_tabela
create index indice_nome_livro 
on tbl_Livro (nome_Livro)

-- criar regra para preco. @valor é uma variavel
create rule rl_preco as @valor > 10.00

-- executa uma stored procedure (procedimento armazenado)
-- vincula a regra rl-preco na tabela livro
execute sp_bindrule rl_preco, 'tbl_Livro.preco_Livro'

select * from tbl_Livro
update tbl_Livro
set preco_Livro = 9.90
where id_Livro = 101

-- Concatenação de strings
-- string1 | coluna + string2 | coluna
select 'Izabela ' + 'Mumic'

select 'Izabela ' + 'Mumic' as Nome

select nome_autor, sobrenome_autor from tbl_Autor

select nome_autor + ' ' + sobrenome_autor 
as 'Nome Completo' 
from tbl_Autor 

select 'Eu gosto do livro' + nome_Livro 
as 'Meu libro' 
from tbl_Livro

select 'Eu gosto do livro' + nome_Livro 
as 'Meu libro' 
from tbl_Livro
where id_autor = 2

-- para ver opções de agrupamento
select * from fn_helpcollations()

-- para ver o esquema de colação usada atualmente pelo servidor
select serverproperty('Collation') as 'Collation usada'

-- verificar o sistema de agrupamento de um banco de dados
select DATABASEPROPERTYEX('bd_Biblioteca', 'Collation') as colacao

-- alterar o esquema de agrupamento
alter database bd_Biblioteca
collate greek_CI_AI

-- agrupar tabela livro com collate icelandic_CI_AI
select * from tbl_Livro
order by nome_livro
collate icelandic_CI_AI

-- criar uma exibição
create view vw_LivrosAutores
as select tbl_Livro.nome_livro as Livro,
tbl_Autor.nome_Autor as Autor
from tbl_Livro
inner join tbl_Autor
on tbl_Livro.id_Autor = tbl_Autor.id_Autor

-- consulta pela exibição
select livro, autor
from vw_LivrosAutores
where livro like 'S%'

-- alterar exibição
alter view vw_LivrosAutores
as select tbl_Livro.nome_livro as livro, 
tbl_Autor.nome_Autor as autor,
preco_Livro as valor
from tbl_Livro
inner join tbl_Autor
on tbl_Livro.id_Autor = tbl_Autor.id_Autor

select * from vw_LivrosAutores

--excluir exibição
drop view vw_LivrosAutores

-- subconsulta
select (select 'Izabela') as subconsulta

-- declarar variavel
-- @nome_var tipo
declare @valor int,
		@texto varchar(40),
		@data_nasc date,
		@nada money

-- atribuir valor a uma variavel
set @valor = 50
set @texto = 'Izabela'
set @data_nasc = GETDATE()

select @valor as Valor,
@texto as Texto,
@data_nasc as 'Data de Nascimento',
@nada as Salario

-- atribuir valore com select
declare @livro varchar (30)
select @livro = nome_Livro
from tbl_Livro
where id_Livro = 101
select @livro as 'Nome do Livro'

declare @preco money, 
		@quantidade int,
		@nome varchar(30)
set @quantidade = 5

select @preco = preco_Livro, @nome = nome_Livro
from tbl_Livro
where id_Livro = '101'

select @nome as 'Nome do Livro',
@preco * @quantidade as 'Preço dos Livros'

-- converter o preco_livro que estava como money para string, porque para concatenar tem que ser todo do tipo string
select 'O preco do livro ' + nome_Livro + ' é de R$ ' +
cast (preco_Livro as varchar(6)) as item
from tbl_Livro
where id_Autor = 2


select 'O preco do livro ' + nome_Livro + ' é de R$ ' +
convert (varchar(6), preco_Livro) as item
from tbl_Livro
where id_Autor = 2

-- converter datas sem alterar estilos
select 'A data de publicação ' + 
convert (varchar(15), data_Pub)
from tbl_Livro
where id_Livro = 102

-- converter datas alteraando estilos
select 'A data de publicação ' + 
convert (varchar(15), data_Pub, 103)
from tbl_Livro
where id_Livro = 102

-- utilizando if e else
declare @numero  int,
	@texto varchar(10)

set @numero = 20
set @texto = 'Ana'

if @numero = 20
	select 'Numero correto!'
if @texto = 'Izabela'
	begin
		set @numero = 30
		select @numero
	end;
else
	begin 
		set @numero = 40
		select 'Nome incorreto'
	end
 
 -- while
declare @valor int
set @valor = 0

while @valor < 10
	begin
		print 'Número: ' + cast (@valor as varchar(2))
		set @valor = @valor +1
	end;

declare @codigo int
set @codigo = 100

while @codigo < 106
	begin
		select id_Livro as id, nome_Livro as livro, preco_Livro as preco
		from tbl_Livro
		where id_Livro = @codigo
		set @codigo = @codigo + 1
	end;

-- precedures 
create procedure teste
as
select 'Bóson Treinamentos' as nome
exec teste

-- excluir procedure
drop procedure teste

create procedure p_LivroValor
as
select nome_Livro, preco_Livro
from tbl_Livro
exec p_LivroValor

-- visualizar código da procidure sp
exec sp_helptext p_LivroValor

-- criptografar procedure
create procedure p_LivroISBN
with encryption
as 
select nome_Livro, ISBN
from tbl_Livro

-- verificar se deu certo
exec sp_helptext p_LivroISBN

-- caso coloque exec p_LivroISBN mostra o resultado
exec p_LivroISBN

-- modificar procedure

alter procedure teste
(@part1 as int)
as
select @part1
exec teste 25

alter procedure p_LivroValor
(@id smallint)
as
select nome_Livro as livro, preco_Livro as preco
from tbl_Livro
where id_livro = @id
exec p_LivroValor 101

alter procedure teste 
(@part1 as int, @part2 as varchar(20))
as
select @part1
select @part2

-- por posicao
exec teste 26, 'Laranja'

-- por nome de paramentro
exec teste @part2 = 'Abacate', @part1 = 30

-- multiplos pâmetros de entrada
alter procedure p_LivroValor
(@id smallint, @preco money)
as
select nome_Livro as livro, preco_Livro as preco
from tbl_Livro
where id_Livro > @id and preco_Livro > @preco
exec p_LivroValor @id = 103, @preco = 60

-- usuario passa parâmetro
alter procedure p_LivroValor(
@quantidade smallint, 
@id smallint)
as
select nome_Livro as livro,
preco_Livro * @quantidade as preco
from tbl_Livro
where id_Livro = @id

exec p_LivroValor @id = 101, @quantidade =10

-- inserir informações dentro do banco de dados
create procedure p_insere_editora(@nome varchar (50))
as
insert into tbl_Editoras(nome_Editora)
values(@nome)

exec p_insere_editora @nome = 'Apress' 
exec p_insere_editora @nome = 'Alpha Books' 
exec p_insere_editora @nome = 'Companhia das Letras' 
exec p_insere_editora @nome = 'Ediouro' 

select * from tbl_Editoras

-- parâmentros com valor padrão
create procedure p_teste_valor_padrao(
@param1 int,
@param2 varchar(20) = 'Valor Padrão!')
as
select 'Valor do parâmetro 1: ' + cast(@param1 as varchar)
select 'Valor do parâmetro21: ' + @param2

exec p_teste_valor_padrao 30
exec p_teste_valor_padrao @param1 = 40, @param2 = 'valor foi modificado'

-- parâmetro de saída
alter procedure teste (@par1 as int output)
as
select @par1 * 2
return

declare @valor as int = 15
exec teste @valor output
print @valor

alter procedure p_LivroValor(
@quantidade smallint, @cod smallint = -10,
@id smallint)
as
-- evita contagem de linhas
set nocount on
-------------------------

if @id >= 100
	begin
		select nome_Livro as livro, 
		preco_Livro * @quantidade as preco
		from tbl_Livro
		where id_Livro = @id
		return 1
	end
else
	return @cod

declare @codigo int
exec @codigo = p_LivroValor @id = 102,
@quantidade = 5
print @codigo

-- função com valor de tabela embutida (Inline)
create function retorna_itens(@valor Real)
returns table
as 
return(
	select l.nome_Livro, a.nome_Autor, e.nome_editora
	from tbl_Livro as l
	inner join tbl_Autor as a
	on l.id_Autor = a.id_Autor
	inner join  tbl_Editoras as e
	on l.id_Editora = e.id_Editora
	where  l.preco_Livro > @valor)

select nome_Livro, nome_Autor
from retorna_itens(50.00)

-- funções com valor de tabela com varias instruções
create function multi_tabela()
returns @valor Table
	(nome_Livro varchar(50),
	data_pub datetime, 
	nome_Editora varchar (50),
	preco_Livro money)
as
begin
insert @valor(nome_Livro, data_pub, nome_Editora, preco_Livro)
	select l.nome_Livro, l.Data_pub, e.nome_Editora, l.preco_Livro
from tbl_Livro as l
inner join tbl_Editoras as e
on l.id_Editora = e.id_Editora
return
end

select * from multi_tabela()

-- criar tigger after
create trigger teste_trigger_after
on tbl_Editoras
after insert
as
print 'Ola mundo'

create trigger trigger_after
on tbl_Editoras
after insert
as
insert into tbl_Autor 
values (25, 'José', 'da Silva')
insert into tbl_Livro 
values ('Livro1', '123456000', '20001010', 77, 25, 2)

-- excluir triegger teste
drop trigger teste_trigger_after

-- criar triggert instead of
create trigger teste_trigger_insteadof
on tbl_Autor
instead of insert
as
print 'Olá de novo! Não inseri o registro desta vez'

insert into tbl_Autor values(26, 'João', 'Moura')

select * from tbl_Autor

-- desabilitar triggers
alter table tbl_Editoras
disable trigger trigger_after

-- habilitar triggers
alter table tbl_Editoras
enable trigger trigger_after

-- verificar se existe triggers na tabela especifica
exec sp_helptrigger @tabname = tbl_Editoras

-- verificar se existe triggers no banco de dados
-- is_disabled = 0 = não está desabilitado
-- is_disabled = 1 = está desabilitado
select * from sys.triggers
where is_disabled = 0

select * from sys.triggers
where is_disabled = 1

select * from sys.triggers
where is_disabled = 0 or is_disabled = 1

-- update trigger (função)
-- é disparado automaticamente, quando faz alteração na tabela autor
create trigger trigger_after_autores
on tbl_Autor
after insert, update
as
if update(nome_autor)
	begin
		print 'O  nome do autor foi alterado'
	end
else
	begin
		print 'O nome não foi modificado'
	end

update tbl_Autor
set nome_Autor = 'João'
where id_Autor = 2

update tbl_Autor
set sobrenome_Autor = 'Guimarães'
where id_Autor = 2

-- criando trigger recursivo
create table tbl_trigger_recursivo(
codigo int primary key)

select codigo from tbl_trigger_recursivo

create trigger trigeer_rec 
on tbl_trigger_recursivo
after insert
as
declare @cod int
select
@cod = max(codigo)
from tbl_trigger_recursivo
if @cod < 10
	begin
		insert into tbl_trigger_recursivo 
		select max(codigo) + 1 from tbl_trigger_recursivo
	end
else
	begin
		print 'Trigger Recursivo Finalizado'
	end

insert into tbl_trigger_recursivo values(1)
select * from tbl_trigger_recursivo

-- habilitando triggers recursivo
alter database bd_Biblioteca
set recursive_triggers on

-- desabilitando triggers recursivo
alter database bd_Biblioteca
set recursive_triggers off