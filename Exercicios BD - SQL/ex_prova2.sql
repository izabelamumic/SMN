-- ex entregue
CREATE TABLE #tbMaiorAux(
	num INT,
	id INT, 
	nome VARCHAR(70),
	dataVenda DATE,
	qtdItens DECIMAL(10,2),
	vlrTotal DECIMAL(10,2)
)

CREATE TABLE #tbMenorAux(
	num INT,
	id INT, 
	nome VARCHAR(70),
	dataVenda DATE,
	qtdItens DECIMAL(10,2),
	vlrTotal DECIMAL(10,2)
)

INSERT INTO #tbMaiorAux(num,
					id, 
					nome,
					dataVenda,
					qtdItens,
					vlrTotal
					)
		
	(SELECT		ROW_NUMBER() OVER (PARTITION BY cl.IdCliente ORDER BY SUM(vi.Quantidade * pr.ValorVenda) DESC) AS num,
				cl.IdCliente,
				cl.NomeCliente,
				ve.DataVenda,
				SUM(vi.Quantidade),
				SUM(vi.Quantidade * pr.ValorVenda)
		FROM Cliente cl
		INNER JOIN Venda ve
			ON cl.IdCliente = ve.IdCliente
		INNER JOIN VendaItem vi
			ON ve.IdVenda = vi.IdVenda
		INNER JOIN Produto pr
			ON vi.IdProduto = pr.IdProduto
			
		GROUP BY cl.IdCliente, cl.NomeCliente, ve.DataVenda
		)

INSERT INTO #tbMenorAux(num,
					id, 
					nome,
					dataVenda,
					qtdItens,
					vlrTotal
					)
		
	(SELECT		ROW_NUMBER() OVER (PARTITION BY cl.IdCliente ORDER BY SUM(vi.Quantidade * pr.ValorVenda)) AS num,
				cl.IdCliente,
				cl.NomeCliente,
				ve.DataVenda,
				SUM(vi.Quantidade),
				SUM(vi.Quantidade * pr.ValorVenda)
		FROM Cliente cl
		INNER JOIN Venda ve
			ON cl.IdCliente = ve.IdCliente
		INNER JOIN VendaItem vi
			ON ve.IdVenda = vi.IdVenda
		INNER JOIN Produto pr
			ON vi.IdProduto = pr.IdProduto
			
		GROUP BY cl.IdCliente, cl.NomeCliente, ve.DataVenda
		)

CREATE TABLE #tbMaior(id INT, 
				nome VARCHAR(70),
				dataVenda DATE,
				qtdItens DECIMAL(10,2),
				vlrTotal DECIMAL(10,2)
)

CREATE TABLE #tbMenor(id INT, 
				nome VARCHAR(70),
				dataVenda DATE,
				qtdItens DECIMAL(10,2),
				vlrTotal DECIMAL(10,2)
)

INSERT INTO #tbMaior(id, 
					nome,
					dataVenda,
					qtdItens,
					vlrTotal
					)
			
				(SELECT tb.id, 
						tb.nome,
						tb.dataVenda,
						tb.qtdItens,
						tb.vlrTotal
					FROM #tbMaiorAux tb WHERE num = 1  )


INSERT INTO #tbMenor(id, 
					nome,
					dataVenda,
					qtdItens,
					vlrTotal
					)
			
				(SELECT tb.id, 
						tb.nome,
						tb.dataVenda,
						tb.qtdItens,
						tb.vlrTotal
					FROM #tbMenorAux tb WHERE num = 1  )


SELECT	tbMa.id AS Id_Cliente, tbMa.nome as Nome_Clide,
		tbMa.dataVenda AS Data_Compra, tbMa.qtdItens AS Quantidade_Total_Itens, tbMa.vlrTotal AS Valor_Total_Compra,
		tbMe.dataVenda AS Data_Compra, tbMe.qtdItens AS Quantidade_Total_Itens, tbMe.vlrTotal AS Valor_Total_Compra
	FROM #tbMaior tbMa
	INNER JOIN #tbMenor tbMe
		ON tbMa.id = tbMe.id


-- outra forma de fazer
SELECT	cli.IdCliente, 
		cli.NomeCliente,
		menor.PrimeiraDataVenda,
		menor.QuantidadeItem,
		menor.ValorTotal,
		maior.UltimaDataVenda,
		maior.QuantidadeItem,
		maior.ValorTotal
	FROM Cliente cli WITH(NOLOCK)

CROSS APPLY(SELECT TOP(1)
					ve.DataVenda AS PrimeiraDataVenda,
					SUM(vi.Quantidade) as QuantidadeItem,
					SUM(vi.Quantidade * pr.ValorVenda) as ValorTotal
				FROM Venda ve WITH(NOLOCK)
				inner join Cliente cl
					on ve.IdCliente = cl.IdCliente
				INNER JOIN VendaItem vi WITH(NOLOCK)
					ON ve.IdVenda = vi.IdVenda
				INNER JOIN Produto pr WITH(NOLOCK)
					ON vi.IdProduto = pr.IdProduto
				
				WHERE ve.IdCliente = cli.IdCliente
				GROUP BY ve.DataVenda
				ORDER BY ValorTotal
			)menor

CROSS APPLY(SELECT	TOP(1)
					ve.DataVenda AS UltimaDataVenda,
					SUM(vi.Quantidade) as QuantidadeItem,
					SUM(vi.Quantidade * pr.ValorVenda) as ValorTotal
				FROM Venda ve WITH(NOLOCK)
				inner join Cliente cl
					on ve.IdCliente = cl.IdCliente
				INNER JOIN VendaItem vi WITH(NOLOCK)
					ON ve.IdVenda = vi.IdVenda
				INNER JOIN Produto pr WITH(NOLOCK)
					ON vi.IdProduto = pr.IdProduto
				
				WHERE ve.IdCliente = cli.IdCliente
				GROUP BY ve.DataVenda
				ORDER BY ValorTotal DESC
			)maior
	
	group by	cli.IdCliente,
				cli.NomeCliente,
				menor.PrimeiraDataVenda,
				menor.QuantidadeItem,
				menor.ValorTotal,
				maior.UltimaDataVenda,
				maior.QuantidadeItem,
				maior.ValorTotal
	order by cli.IdCliente
