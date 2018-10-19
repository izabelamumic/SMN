
SELECT  ROW_NUMBER()OVER(PARTITION BY cl.Num_CliCPFCNPJ ORDER BY pc.Dat_Venc DESC) AS numRow,
		lt.Num_Empr,
		em.Nom_SiglaEmpr,
		(CONVERT(VARCHAR(50), lt.Num_Empr) + ' - ' + lt.Cod_Quadra + ' - ' + CONVERT(VARCHAR(50), lt.Cod_Lot)) AS Eql,
		cl.Num_CliCPFCNPJ,
		cl.Nom_Cli,
		pc.Dat_Venc,
		tp.Cod_TipParc,
		pc.Vlr_Parc
	INTO #tbCli4
	FROM GKSLT_Parcelas pc 
			INNER JOIN GKSLT_Contratos ct 
				ON ct.Num_Contr = pc.Num_Contr
			INNER JOIN GKSLT_Lotes lt 
				ON ct.Num_ChavLot = lt.Num_ChavLot
			INNER JOIN GKSLT_Clientes cl 
				ON ct.Num_CliCPFCNPJ = cl.Num_CliCPFCNPJ	
			INNER JOIN GKSLT_TiposParcelas tp WITH(NOLOCK)
				ON pc.Cod_TipParc = tp.Cod_TipParc
			INNER JOIN GKSLT_Empreendimentos em
				ON lt.Num_Empr = em.Num_Empr
			INNER JOIN GKSLT_StatusContVend scv
				ON ct.Cod_StatusContVend = scv.Cod_StatusContVend
	WHERE (pc.Cod_TipParc = 21 OR pc.Cod_TipParc = 97 OR pc.Cod_TipParc = 99)
			AND pc.Dat_Venc <= GETDATE()
			AND scv.Cod_StatusContVend = 2
			AND em.Num_Empr = 4

-- tabela contribuicao social
SELECT TOP(10) tb.Nom_SiglaEmpr,
		tb.Eql,
		tb.Num_CliCPFCNPJ,
		tb.Nom_Cli,
		tb.Dat_Venc AS Data_Vend_CS
	INTO #tbCS4
	FROM #tbCli4 tb 
	WHERE	tb.Cod_TipParc = 21 
			AND numRow = 1
		
-- tabela corretagem
SELECT TOP(10) tb.Nom_SiglaEmpr,
		tb.Eql,
		tb.Num_CliCPFCNPJ,
		tb.Nom_Cli,
		tb.Dat_Venc AS Data_Vend_Corretagem
	INTO #tbC4
	FROM #tbCli4 tb 
	WHERE	tb.Cod_TipParc = 97 
			AND numRow = 1
		
-- tabela sinal
SELECT TOP(10) tb.Nom_SiglaEmpr,
		tb.Eql,
		tb.Num_CliCPFCNPJ,
		tb.Nom_Cli,
		tb.Dat_Venc as Data_Vend_Sinal
	INTO #tbS4
	FROM #tbCli4 tb 
	WHERE	tb.Cod_TipParc = 99
			AND numRow = 1
		

-- valor das parcelas
SELECT TOP(10) tb.Nom_SiglaEmpr,
		tb.Eql,
		tb.Num_CliCPFCNPJ,
		tb.Nom_Cli,
		SUM(CASE
				WHEN tb.cod_TipParc = 21
					THEN tb.Vlr_Parc
			END
			)Vlr_Cont_Social,
		SUM(CASE
				WHEN tb.cod_TipParc = 97
					THEN tb.Vlr_Parc
			END
			)Vlr_Corretagem,
		SUM(CASE
				WHEN tb.cod_TipParc = 99
					THEN tb.Vlr_Parc
			END
			)Vlr_Sinal
	INTO #tbVlrTotal4
	FROM #tbCli4 tb 
	WHERE numRow = 1 
	GROUP BY tb.Nom_SiglaEmpr,
			tb.Eql,
			tb.Num_CliCPFCNPJ,
			tb.Nom_Cli,
			tb.Dat_Venc,
			tb.Cod_TipParc
	order by Dat_Venc  DESC

SELECT	cs.Nom_SiglaEmpr,
		cs.Eql,
		cs.Num_CliCPFCNPJ,
		cs.Nom_Cli,
		cs.Data_Vend_CS,
		c.Data_Vend_Corretagem,
		s.Data_Vend_Sinal
	INTO #tbData4
	FROM #tbCS4 cs
	FULL JOIN #tbC4 c
		ON cs.Num_CliCPFCNPJ = c.Num_CliCPFCNPJ
	FULL JOIN #tbS4 s
		ON cs.Num_CliCPFCNPJ = s.Num_CliCPFCNPJ
		WHERE s.Nom_SiglaEmpr is null

SELECT tbd.Nom_SiglaEmpr,
		tbd.Eql,
		tbd.Num_CliCPFCNPJ,
		tbd.Nom_Cli,
		tbd.Data_Vend_CS,
		tbd.Data_Vend_Corretagem,
		tbd.Data_Vend_Sinal,
		vlt.Vlr_Cont_Social,
		vlt.Vlr_Corretagem,
		vlt.Vlr_Sinal
	FROM #tbData4 tbd
	full JOIN  #tbVlrTotal4 vlt
		ON tbd.Nom_Cli = vlt.Nom_Cli
	WHERE vlt.Nom_SiglaEmpr is null


-- lotes
SELECT	ROW_NUMBER()OVER(PARTITION BY tb.Num_CliCPFCNPJ ORDER BY tb.eql DESC) AS numRowLote,
		tb.Eql,
		tb.Num_CliCPFCNPJ
	INTO #tbNumLot
	FROM #tbCli4 tb
	GROUP BY tb.eql, tb.Num_CliCPFCNPJ

DROP TABLE #tbC4
DROP TABLE #tbCli4
DROP TABLE #tbCS4
DROP TABLE #tbData4
DROP TABLE #tbS4
DROP TABLE #tbVlrTotal4
DROP TABLE #tbNumLot

-- contribuicao social
--select top(10) * from #tbCli4 where Cod_TipParc = 21 and numRow = 1

-- corretagem
--select top(10) * from #tbCli4 where Cod_TipParc = 97 and numRow = 1

-- sinal
--select top(10) * from #tbCli4 where Cod_TipParc = 99 and numRow = 1
