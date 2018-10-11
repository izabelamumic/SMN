SELECT	cliente.IdCliente,
		cliente.NomeCliente,
		pri.PrimeiraDataVenda,
		pri.QuantidadeItem,
		pri.ValorTotal,
		ul.UltimaDataVenda,
		ul.QuantidadeItem,
		ul.ValorTotal
	FROM (SELECT		cl.IdCliente,
					cl.NomeCliente
			FROM Cliente cl WITH(NOLOCK)
			)cliente
		

CROSS APPLY( SELECT	TOP(1)
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
				
			WHERE ve.IdCliente = cliente.IdCliente
				GROUP BY vi.Quantidade, vi.Quantidade, pr.ValorVenda
				order by PrimeiraDataVenda
				
			)pri

CROSS APPLY( SELECT	TOP(1)
				MAX(ve.DataVenda) AS UltimaDataVenda,
					vi.Quantidade as QuantidadeItem,
					(vi.Quantidade * pr.ValorVenda) as ValorTotal
				FROM Venda ve WITH(NOLOCK)
				inner join Cliente cl
					on ve.IdCliente = cl.IdCliente
				INNER JOIN VendaItem vi WITH(NOLOCK)
					ON ve.IdVenda = vi.IdVenda
				INNER JOIN Produto pr WITH(NOLOCK)
					ON vi.IdProduto = pr.IdProduto
				
			WHERE ve.IdCliente = cliente.IdCliente
				GROUP BY vi.Quantidade, vi.Quantidade, pr.ValorVenda
				order by UltimaDataVenda DESC
			)ul

	group by		cliente.IdCliente,
				cliente.NomeCliente,
				pri.PrimeiraDataVenda,
				pri.QuantidadeItem,
				pri.ValorTotal,
				ul.UltimaDataVenda,
				ul.QuantidadeItem,
				ul.ValorTotal
	order by cliente.IdCliente
