/*
	08 - [10/10/2018] Eduardo: Clientes Inadimplentes
	Desenvolver levantamento de todos os clientes que estão inadimplentes, que compraram em 2008

	EQL, cpf cliente, nome cliente, data venda, qtd parcelas inadimplentes, data vencimento da parcela mais antiga,
	tipo de parcela mais antiga vencida, vlr total debito
*/	

with cte as (SELECT (CONVERT(VARCHAR(50), lt.Num_Empr) + '-' + lt.Cod_Quadra + '-' + CONVERT(VARCHAR(50), lt.Cod_Lot)) AS Eql,
				cl.Nom_Cli,
				cl.Num_CliCPFCNPJ,
				ct.Dat_Venda,
				COUNT(pc.Num_Parc) AS n_parcelas,
				SUM(pc.Vlr_Parc) AS vlr_parcelas
				--pc.Cod_TipBaiPar
			FROM GKSLT_Parcelas pc 
			INNER JOIN GKSLT_Contratos ct 
				ON ct.Num_Contr = pc.Num_Contr
			INNER JOIN GKSLT_Lotes lt 
				ON ct.Num_ChavLot = lt.Num_ChavLot
			INNER JOIN GKSLT_Clientes cl 
				ON ct.Num_CliCPFCNPJ = cl.Num_CliCPFCNPJ	
			INNER JOIN GKSLT_StatusContVend sct
				ON ct.Cod_StatusContVend = sct.Cod_StatusContVend
			WHERE pc.Cod_TipBaiPar IS NULL
					AND ct.Dat_Venda >= '2008-01-01'
					AND ct.Dat_Venda <= '2008-31-12'
					AND (sct.Cod_StatusContVend = 2 OR sct.Cod_StatusContVend = 3 OR sct.Cod_StatusContVend = 4)
			GROUP BY 	(CONVERT(VARCHAR(50), lt.Num_Empr) + '-' + lt.Cod_Quadra + '-' + CONVERT(VARCHAR(50), lt.Cod_Lot)),
						cl.Nom_Cli,
						cl.Num_CliCPFCNPJ,
						ct.Dat_Venda
				--ORDER BY cl.Num_CliCPFCNPJ
		),

cte2 as (SELECT cl.Num_CliCPFCNPJ,
			ct.Dat_Venda,
			antiga.Dat_Venc,
			antiga.Nom_TipParc
		FROM GKSLT_Contratos ct WITH(NOLOCK)
		INNER JOIN GKSLT_Clientes cl WITH(NOLOCK)
			ON ct.Num_CliCPFCNPJ = cl.Num_CliCPFCNPJ
		CROSS APPLY(SELECT TOP (1) pc1.Dat_Venc,
						tp1.Nom_TipParc,
						pc1.Cod_TipBaiPar
					FROM GKSLT_Parcelas pc1
					INNER JOIN GKSLT_Clientes cl1
						ON pc1.Num_CliCPFCNPJ = cl1.Num_CliCPFCNPJ	
					INNER JOIN  GKSLT_TiposParcelas tp1 WITH(NOLOCK)
						ON pc1.Cod_TipParc = tp1.Cod_TipParc
					WHERE cl.Num_CliCPFCNPJ = cl1.Num_CliCPFCNPJ							
				)antiga

		WHERE	ct.Dat_Venda >= '2008-01-01'
				AND ct.Dat_Venda <= '2008-31-12'
		)

SELECT	cte.Eql,
		cte.Nom_Cli,
		cte.Num_CliCPFCNPJ,
		cte.Dat_Venda,
		cte.n_parcelas,
		cte.vlr_parcelas,
		cte2.Dat_Venc,
		cte2.Nom_TipParc
	FROM cte 
	FULL OUTER JOIN cte2
		ON cte.Num_CliCPFCNPJ = cte2.Num_CliCPFCNPJ
	where cte.eql IS NOT NULL
	GROUP BY cte.Eql,
			cte.Nom_Cli,
			cte.Num_CliCPFCNPJ,
			cte.Dat_Venda,
			cte.n_parcelas,
			cte.vlr_parcelas,
			cte2.Dat_Venc,
			cte2.Nom_TipParc
	ORDER BY cte.Nom_Cli
