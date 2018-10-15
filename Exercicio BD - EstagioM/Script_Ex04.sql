/*
	[10/10/2018] Eduardo: Retornar todos os clientes ativos que compraram lotes a partir de 2008
	Caso o cliente possuía outro lote ativo antes da compra em 2008, retornar os lotes em outra coluna.
*/
SELECT	(CONVERT(VARCHAR(50), lt.Num_Empr) + ' - ' + lt.Cod_Quadra + ' - ' + CONVERT(VARCHAR(50), lt.Cod_Lot)) AS Eql,
		cl.Num_CliCPFCNPJ,
		cl.Nom_Cli,
		ct.Dat_Venda,
		ct.Dat_ConfirmaVenda,
		sv.Nom_StatusContVend
	FROM GKSLT_Contratos ct WITH(NOLOCK)
	INNER JOIN GKSLT_Clientes cl WITH(NOLOCK)
		ON ct.Num_CliCPFCNPJ = cl.Num_CliCPFCNPJ
	INNER JOIN GKSLT_Lotes lt WITH(NOLOCK)
		ON ct.Num_ChavLot = lt.Num_ChavLot
	INNER JOIN GKSLT_StatusContVend  sv
		ON ct.Cod_StatusContVend = sv.Cod_StatusContVend
	WHERE	YEAR(ct.Dat_Venda) >= 2008
			AND sv.Cod_StatusContVend = 2

select ct.Cod_StatusContVend, sv.Nom_StatusContVend from GKSLT_Contratos ct
inner join GKSLT_StatusContVend  sv
on ct.Cod_StatusContVend = sv.Cod_StatusContVend
group by ct.Cod_StatusContVend, sv.Nom_StatusContVend
