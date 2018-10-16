/*
	06 - [10/10/2018] Eduardo: Contratos vendidos a partir de 2010 com parcela de corretagem vencida a mais de 30 dias.
*/

SELECT (CONVERT(VARCHAR(50), lt.Num_Empr) + '-' + lt.Cod_Quadra + '-' + CONVERT(VARCHAR(50), lt.Cod_Lot)) AS Eql,
		ct.Num_Contr,
		cl.Nom_Cli,
		cl.Num_CliCPFCNPJ,
		tbp.Ind_BaixaEfet,
		ct.Dat_Venda,
		pc.Dat_Pagto
	FROM GKSLT_Contratos ct WITH(NOLOCK)
	INNER JOIN GKSLT_Lotes lt WITH(NOLOCK)
		ON ct.Num_ChavLot = lt.Num_ChavLot
	INNER JOIN GKSLT_Parcelas pc WITH(NOLOCK)
		ON ct.Num_Contr = pc.Num_Contr
	INNER JOIN GKSLT_Clientes cl WITH(NOLOCK)
		ON ct.Num_CliCPFCNPJ = cl.Num_CliCPFCNPJ
	INNER JOIN GKSLT_TiposBaixaParcela tbp WITH(NOLOCK)
		ON pc.Cod_TipBaiPar = tbp.Cod_TipBaiPar
	INNER JOIN  GKSLT_TiposParcelas tp WITH(NOLOCK)
		ON pc.Cod_TipParc = tp.Cod_TipParc
	WHERE	ct.Dat_Venda >= '2010-01-01'
			AND tbp.Ind_BaixaEfet = 'N'
			AND pc.Dat_Venc < DATEADD(DAY,30,pc.Dat_Venc)
			AND tp.Cod_TipParc = 97 --97 porque é corretagem
