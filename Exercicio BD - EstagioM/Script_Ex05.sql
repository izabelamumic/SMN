/*
	[10/10/2018] Eduardo: Levantamento das vendas a partir de 01/2008 com a 1ª parcela de terra paga.
	Todas as vendas a partir de 01/2018. Onde a 1ª parcela de terra (Cod_TipParc = 3) está quitada, 
	mas possui alguma parcela de sinal ou corretagem (97 e 99) em aberto.

	Parcela terra = Parcela com preço do terreno
	Data pagamento = Data que fez a baixa na parcela
	Baixa S = foi paga (tabela TiposBaixaParcela
	Baixa N = não foi paga e foi baixadapo08ih

	eql, nome cliente, cpf clientye, cod tipo parcela, num parcela, ind_Baixa Efet, data pagamento, data venda
*/


WITH cte AS(SELECT (CONVERT(VARCHAR(50), lt.Num_Empr) + '-' + lt.Cod_Quadra + '-' + CONVERT(VARCHAR(50), lt.Cod_Lot)) AS Eql,
		ct.Num_Contr,
		cl.Nom_Cli,
		cl.Num_CliCPFCNPJ,
		pc.Cod_TipParc,
		pc.Num_Parc,
		tp.Ind_BaixaEfet,
		ct.Dat_Venda,
		pc.Dat_Pagto 
	FROM GKSLT_Contratos ct WITH(NOLOCK)
	INNER JOIN GKSLT_Lotes lt WITH(NOLOCK)
		ON ct.Num_ChavLot = lt.Num_ChavLot
	INNER JOIN GKSLT_Parcelas pc WITH(NOLOCK)
		ON ct.Num_Contr = pc.Num_Contr
	INNER JOIN GKSLT_Clientes cl WITH(NOLOCK)
		ON ct.Num_CliCPFCNPJ = cl.Num_CliCPFCNPJ
	INNER JOIN GKSLT_TiposBaixaParcela tp WITH(NOLOCK)
		ON pc.Cod_TipBaiPar = tp.Cod_TipBaiPar
	WHERE	ct.Dat_Venda >= '2008-01-01'
			AND pc.Num_Parc = 1
			AND tp.Ind_BaixaEfet = 'S'
			AND pc.Cod_TipParc = 3
		),

cte2 AS (SELECT (CONVERT(VARCHAR(50), lt.Num_Empr) + '-' + lt.Cod_Quadra + '-' + CONVERT(VARCHAR(50), lt.Cod_Lot)) AS Eql,
		ct.Num_Contr,
		cl.Nom_Cli,
		cl.Num_CliCPFCNPJ,
		pc.Cod_TipParc,
		pc.Num_Parc,
		tp.Ind_BaixaEfet,
		ct.Dat_Venda,
		pc.Dat_Pagto 
	FROM GKSLT_Contratos ct WITH(NOLOCK)
	INNER JOIN GKSLT_Lotes lt WITH(NOLOCK)
		ON ct.Num_ChavLot = lt.Num_ChavLot
	INNER JOIN GKSLT_Parcelas pc WITH(NOLOCK)
		ON ct.Num_Contr = pc.Num_Contr
	INNER JOIN GKSLT_Clientes cl WITH(NOLOCK)
		ON ct.Num_CliCPFCNPJ = cl.Num_CliCPFCNPJ
	INNER JOIN GKSLT_TiposBaixaParcela tp WITH(NOLOCK)
		ON pc.Cod_TipBaiPar = tp.Cod_TipBaiPar
	WHERE	ct.Dat_Venda >= '2008-01-01'
			AND pc.Dat_Pagto  >= '2008-01-01'
			AND tp.Ind_BaixaEfet = 'N'
			AND (pc.Cod_TipParc = 97 OR pc.Cod_TipParc = 99)
	)


SELECT (CONVERT(VARCHAR(50), lt.Num_Empr) + '-' + lt.Cod_Quadra + '-' + CONVERT(VARCHAR(50), lt.Cod_Lot)) AS Eql,
		cte.Num_Contr,
		cte.Nom_Cli,
		cte.Num_CliCPFCNPJ,
		cte.Cod_TipParc,
		cte.Num_Parc,
		cte.Ind_BaixaEfet,
		cte.Dat_Venda,
		cte.Dat_Pagto 
	FROM cte WITH(NOLOCK)
	INNER JOIN cte2 
		ON cte.Num_Contr = cte2.Num_Contr 
	INNER JOIN GKSLT_Contratos ct WITH(NOLOCK)
		ON cte.Num_Contr = ct.Num_Contr
	INNER JOIN GKSLT_Lotes lt WITH(NOLOCK)
		ON ct.Num_ChavLot = lt.Num_ChavLot