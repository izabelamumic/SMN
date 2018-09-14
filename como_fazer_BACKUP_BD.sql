create database test

use test
--campos calculados
create table Produto(codProduto smallint, 
	nomeProduto varchar(20),
	preco money,
	quant smallint,
	total as (preco * quant)
	);

insert into Produto 
values (1, 'Mouse', 15.00, 2),
		(2, 'Teclado', 18.00, 1),
		(3, 'Fones', 25.00, 1),
		(4, 'Pendrive', 25.00, 3),
		(5, 'SD card', 29.00, 2),
		(6, 'DVD-R', 1.30, 1);


select * from Produto
select sum(Total) from Produto

-- Backup do banco de dados
backup database test
to disk = 'C:\teste backup bd\test.bak';
go

select * from Produto