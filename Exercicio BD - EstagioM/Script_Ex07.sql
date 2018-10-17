/*
	07 - [10/10/2018] Eduardo: Levantamento dos clientes com divida de contribuição social.
	Regras: 
		Contratos vendidos a partir de 03/04/2017. 
		Parcela de Contribuição Social em atraso: 
		De 10 a 16 dias
		De 17 a 19 dias
		De 20 a 32 dias
		Acima de 33 dias
*/

WITH cte AS (SELECT (CONVERT(VARCHAR(50), lt.Num_Empr) + '-' + lt.Cod_Quadra + '-' + CONVERT(VARCHAR(50), lt.Cod_Lot)) AS Eql,
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
				WHERE	ct.Dat_Venda >= '2017-04-03'
						AND tbp.Ind_BaixaEfet = 'N'
						--AND pc.Dat_Venc < DATEADD(DAY,30,pc.Dat_Venc)
						AND tp.Cod_TipParc = 21  --21 porque é contribuição social
			)
SELECT 
		CASE
			WHEN DATEDIFF (DAY, cte.Dat_Venda, GETDATE()) > 10 AND DATEDIFF(DAy, cte.Dat_Venda, GETDATE()) <= 15 
				THEN 'De 10 a 16 dias'
			WHEN DATEDIFF (DAY, cte.Dat_Venda, GETDATE()) > 17 AND DATEDIFF(DAy, cte.Dat_Venda, GETDATE()) <= 19
				THEN 'De 17 a 19 dias'
			WHEN DATEDIFF (DAY, cte.Dat_Venda, GETDATE()) > 20 AND DATEDIFF(DAy, cte.Dat_Venda, GETDATE()) <=32
				THEN 'De 20 a 32 dias'
			WHEN DATEDIFF (DAY, cte.Dat_Venda, GETDATE()) > 33	
				THEN 'Acima de 33 dias'
			ELSE null		
		END Atraso,

		cte.Eql,
		cte.Nom_Cli,
		cte.Num_CliCPFCNPJ

	FROM cte
	GROUP BY cte.Dat_Venda, cte.Eql, cte.Nom_Cli, cte.Num_CliCPFCNPJ 


	
	