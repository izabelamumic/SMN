SELECT 	top (10)lt.Num_Empr,
		em.Nom_SiglaEmpr,
		(CONVERT(VARCHAR(50), lt.Num_Empr) + ' - ' + lt.Cod_Quadra + ' - ' + CONVERT(VARCHAR(50), lt.Cod_Lot)) AS Eql,
		cl.Num_CliCPFCNPJ,
		cl.Nom_Cli,
		recente.Dat_Venc,
		tp.Cod_TipParc,
		SUM(pc.Vlr_Parc	) AS vlr_parc
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
		
	CROSS APPLY( SELECT TOP(1) CAST(pc.Dat_Venc AS DATE) AS Dat_Venc
						FROM GKSLT_Parcelas pc1
						INNER JOIN GKSLT_Contratos ct1
							ON pc1.Num_Contr = ct1.Num_Contr
						INNER JOIN GKSLT_Clientes cl1 
							ON ct1.Num_CliCPFCNPJ = cl1.Num_CliCPFCNPJ
						INNER JOIN GKSLT_Lotes lt1 
							ON ct1.Num_ChavLot = lt1.Num_ChavLot
						WHERE cl.Num_CliCPFCNPJ = cl1.Num_CliCPFCNPJ
								AND Dat_Venc <= GETDATE()
						ORDER BY Dat_Venc DESC
				)recente
	--vendas nao pagas
	WHERE	pc.Cod_TipBaiPar IS NULL 
	--Contratos Ativos
			AND scv.Cod_StatusContVend = 2
			AND recente.Dat_Venc <= GETDATE()
	GROUP BY	lt.Num_Empr,
				em.Nom_SiglaEmpr,
				(CONVERT(VARCHAR(50), lt.Num_Empr) + ' - ' + lt.Cod_Quadra + ' - ' + CONVERT(VARCHAR(50), lt.Cod_Lot)),
				cl.Num_CliCPFCNPJ,
				cl.Nom_Cli,
				recente.Dat_Venc,
				tp.Cod_TipParc
	 ORDER BY recente.Dat_Venc DESC