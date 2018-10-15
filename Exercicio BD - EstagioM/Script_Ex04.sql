/*
	[10/10/2018] Eduardo: Retornar todos os clientes ativos que compraram lotes a partir de 2008
	Caso o cliente possuía outro lote ativo antes da compra em 2008, retornar os lotes em outra coluna.
*/

SELECT	ROW_NUMBER() OVER(PARTITION BY cl.Num_CliCPFCNPJ ORDER BY cl.Num_CliCPFCNPJ) AS numRow,
		(CONVERT(VARCHAR(50), lt.Num_Empr) + '-' + lt.Cod_Quadra + '-' + CONVERT(VARCHAR(50), lt.Cod_Lot)) AS Eql,
		cl.Num_CliCPFCNPJ,
		cl.Nom_Cli,
		ct.Dat_Venda,
		ct.Dat_ConfirmaVenda,
		sv.Nom_StatusContVend,
		lt.Cod_Lot
	INTO #tbMais2008
	FROM GKSLT_Contratos ct WITH(NOLOCK)
	INNER JOIN GKSLT_Clientes cl WITH(NOLOCK)
		ON ct.Num_CliCPFCNPJ = cl.Num_CliCPFCNPJ
	INNER JOIN GKSLT_Lotes lt WITH(NOLOCK)
		ON ct.Num_ChavLot = lt.Num_ChavLot
	INNER JOIN GKSLT_StatusContVend  sv
		ON ct.Cod_StatusContVend = sv.Cod_StatusContVend
	WHERE	YEAR(ct.Dat_Venda) >= 2008
			AND sv.Cod_StatusContVend = 2
	ORDER BY ct.Dat_Venda DESC


SELECT	SUBSTRING(mostra,1,LEN(mostra) - 1) AS EqlJunto,
		tbM.Num_CliCPFCNPJ,
		tbM.Nom_Cli,
		tbM.Dat_Venda,
		tbM.Dat_ConfirmaVenda,
		tbM.Nom_StatusContVend
	INTO #tbTempJunta2008
	FROM #tbMais2008 tbM WITH(NOLOCK)
	CROSS APPLY(SELECT (CONVERT(VARCHAR(100),(tbM1.Eql))) + '; '
		FROM #tbMais2008 tbM1 WITH(NOLOCK)
		WHERE  tbM.Num_CliCPFCNPJ = tbM1.Num_CliCPFCNPJ
		FOR XML PATH('')
	)mo (mostra)
	WHERE tbM.numRow = 1

SELECT	ROW_NUMBER() OVER(PARTITION BY cl.Num_CliCPFCNPJ ORDER BY cl.Num_CliCPFCNPJ) AS numRow,
		(CONVERT(VARCHAR(50), lt.Num_Empr) + ' - ' + lt.Cod_Quadra + ' - ' + CONVERT(VARCHAR(50), lt.Cod_Lot)) AS Eql,
		lt.Cod_Lot,
		cl.Num_CliCPFCNPJ,
		cl.Nom_Cli,
		ct.Dat_Venda,
		ct.Dat_ConfirmaVenda,
		sv.Nom_StatusContVend
	INTO #tbTudo
	FROM GKSLT_Contratos ct WITH(NOLOCK)
	INNER JOIN GKSLT_Clientes cl WITH(NOLOCK)
		ON ct.Num_CliCPFCNPJ = cl.Num_CliCPFCNPJ
	INNER JOIN GKSLT_Lotes lt WITH(NOLOCK)
		ON ct.Num_ChavLot = lt.Num_ChavLot
	INNER JOIN GKSLT_StatusContVend  sv
		ON ct.Cod_StatusContVend = sv.Cod_StatusContVend
	WHERE sv.Cod_StatusContVend = 2 AND YEAR(ct.Dat_Venda) < 2008
	ORDER BY ct.Dat_Venda DESC

SELECT tb.Num_CliCPFCNPJ,
	SUBSTRING(mostra,1,LEN(mostra) - 1) AS junta
	INTO #tbTempJunta
	FROM #tbTudo tb WITH(NOLOCK)
	CROSS APPLY(SELECT (CONVERT(VARCHAR(100),(tb1.Cod_Lot))) + ', '
		FROM #tbTudo tb1 WITH(NOLOCK)
		WHERE  tb.Num_CliCPFCNPJ = tb1.Num_CliCPFCNPJ
		FOR XML PATH('')
	)mo (mostra)
	WHERE tb.numRow = 1

SELECT	tb.EqlJunto AS eql,
		tb.Num_CliCPFCNPJ,
		tb.Nom_Cli,
		tb.Dat_Venda,
		tb.Dat_ConfirmaVenda,
		tb.Nom_StatusContVend,
		tj.junta AS LotesAntigos
	FROM #tbTempJunta2008 tb WITH(NOLOCK)
	LEFT JOIN #tbTempJunta tj WITH(NOLOCK)
		ON tb.Num_CliCPFCNPJ = tj.Num_CliCPFCNPJ


	drop table #tbMais2008
	drop table #tbTempJunta2008
	drop table #tbTempJunta
	drop table #tbTudo
	
 