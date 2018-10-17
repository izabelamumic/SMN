/*
	09 - [10/10/2018] Eduardo: Levantamento da forma de pagamento das vendas de 2010.
	Todos os empreendimentos
	Data da Venda: 01/01/2010 até hoje  
	Retornar a forma de pagamento das parcelas de sinal e corretagem, se dinheiro, cheque, cartão (quantas vezes).
*/	
WITH cte AS (SELECT (CONVERT(VARCHAR(50), lt.Num_Empr) + '-' + lt.Cod_Quadra + '-' + CONVERT(VARCHAR(50), lt.Cod_Lot)) AS Eql,
					cl.Nom_Cli,
					cl.Num_CliCPFCNPJ,
					ct.Dat_Venda,
					pc.Cod_TipBaiPar
				FROM GKSLT_Parcelas pc 
				INNER JOIN GKSLT_Contratos ct 
					ON ct.Num_Contr = pc.Num_Contr
				INNER JOIN GKSLT_Lotes lt 
					ON ct.Num_ChavLot = lt.Num_ChavLot
				INNER JOIN GKSLT_Clientes cl 
					ON ct.Num_CliCPFCNPJ = cl.Num_CliCPFCNPJ	
				INNER JOIN  GKSLT_TiposParcelas tp WITH(NOLOCK)
					ON pc.Cod_TipParc = tp.Cod_TipParc
				INNER JOIN GKSLT_TiposBaixaParcela tbp WITH(NOLOCK)
					ON pc.Cod_TipBaiPar = tbp.Cod_TipBaiPar
				INNER JOIN GKSLT_StatusContVend sct
					ON ct.Cod_StatusContVend = sct.Cod_StatusContVend
				WHERE	ct.Dat_Venda >= '2010-01-01'
						AND (tp.Cod_TipParc = 99 OR tp.Cod_TipParc = 97)
						AND tbp.Ind_BaixaEfet = 'S'
						AND (sct.Cod_StatusContVend = 2 OR sct.Cod_StatusContVend = 3 OR sct.Cod_StatusContVend = 4)
		)
SELECT	cte.Eql,
		cte.Nom_Cli,
		cte.Num_CliCPFCNPJ,
		COUNT(CASE
				WHEN  cte.Cod_TipBaiPar = 1
					THEN 1		
				END 
		)AS 'Boleto',

		COUNT(CASE
				WHEN cte.Cod_TipBaiPar = 2
					THEN 1	
				END 
		)AS 'Cartão_Credito',

		COUNT(CASE
				WHEN cte.Cod_TipBaiPar = 3
					THEN 1	
				END 
		)AS 'Débito',

		COUNT(CASE		
				WHEN cte.Cod_TipBaiPar = 4
					THEN 1			
				END 
		)AS 'Caixa_Operacional',

		COUNT(CASE
				WHEN cte.Cod_TipBaiPar = 5
					THEN 1					
				END 
		)AS 'Cheque'
	FROM cte
	GROUP BY	cte.Eql,
				cte.Nom_Cli,
				cte.Num_CliCPFCNPJ

-- cartao
select pc.Cod_TipBaiPar, tbp.Nom_TipBaiPar from GKSLT_Parcelas pc inner join GKSLT_TiposBaixaParcela tbp on pc.Cod_TipBaiPar = tbp.Cod_TipBaiPar where tbp.Nom_TipBaiPar like '%cartão%'
-- cheque
select pc.Cod_TipBaiPar, tbp.Nom_TipBaiPar from GKSLT_Parcelas pc inner join GKSLT_TiposBaixaParcela tbp on pc.Cod_TipBaiPar = tbp.Cod_TipBaiPar where tbp.Nom_TipBaiPar like '%cheque%'
-- consulta tudo
select pc.Cod_TipBaiPar, tbp.Nom_TipBaiPar from GKSLT_Parcelas pc inner join GKSLT_TiposBaixaParcela tbp on pc.Cod_TipBaiPar = tbp.Cod_TipBaiPar group by pc.Cod_TipBaiPar, tbp.Nom_TipBaiPar
--corretagem
select tp.Nom_TipParc, tp.Cod_TipParc from GKSLT_TiposParcelas tp where tp.Nom_TipParc like  '%corretagem%' 