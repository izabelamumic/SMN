/*
	[10/10/2018] Eduardo: Lotes doados a partir de 2005 por empreendimento
*/
SELECT	(CONVERT(VARCHAR(50), lt.Num_Empr) + ' - ' + lt.Cod_Quadra + ' - ' + CONVERT(VARCHAR(50), lt.Cod_Lot)) AS Eql,
		em.Nom_Empr,
		cl.Num_CliCPFCNPJ,
		cl.Nom_Cli,
		ct.Dat_Venda,
		ct.Dat_ConfirmaVenda,
		st.Nom_StatusContVend,
		sv.Nom_SisVen
	FROM GKSLT_Contratos ct WITH(NOLOCK)
	INNER JOIN GKSLT_Clientes cl WITH(NOLOCK)
		ON ct.Num_CliCPFCNPJ = cl.Num_CliCPFCNPJ
	INNER JOIN GKSLT_Lotes lt WITH(NOLOCK)
		ON ct.Num_ChavLot = lt.Num_ChavLot
	INNER JOIN GKSLT_StatusContVend st WITH(NOLOCK)
		ON ct.Cod_StatusContVend = st.Cod_StatusContVend
	INNER JOIN GKSLT_Empreendimentos em WITH(NOLOCK)
		ON lt.Num_Empr = em.Num_Empr
	INNER JOIN GKSLT_SistemaVenda sv WITH(NOLOCK)
		ON ct.Cod_SisVen = sv.Cod_SisVen
	WHERE	YEAR(ct.Dat_Venda) >= 2005 
			AND sv.Nom_SisVen LIKE 'Doação%'
