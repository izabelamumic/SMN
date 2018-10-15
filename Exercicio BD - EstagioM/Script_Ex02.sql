/* 
	[10/10/2018] Eduardo: Forma de Pagamento
	Desenvolver levantamento de contratos vendidos em 2008 e sua forma de pagamento.
*/
SELECT	(CONVERT(VARCHAR(50), lt.Num_Empr) + ' - ' + lt.Cod_Quadra + ' - ' + CONVERT(VARCHAR(50), lt.Cod_Lot)) AS Eql,
		cl.Num_CliCPFCNPJ,
		cl.Nom_Cli,
		ct.Dat_Venda,
		ct.Dat_ConfirmaVenda,
		st.Nom_StatusContVend,
		fp.Nom_ForPag
	FROM GKSLT_Contratos ct WITH(NOLOCK)
	INNER JOIN GKSLT_Clientes cl WITH(NOLOCK)
		ON ct.Num_CliCPFCNPJ = cl.Num_CliCPFCNPJ
	INNER JOIN GKSLT_Lotes lt WITH(NOLOCK)
		ON ct.Num_ChavLot = lt.Num_ChavLot
	INNER JOIN GKSLT_StatusContVend st WITH(NOLOCK)
		ON ct.Cod_StatusContVend = st.Cod_StatusContVend
	INNER JOIN GKSLT_FormaPagamento fp WITH(NOLOCK)
		ON ct.Cod_ForPag = fp.Cod_ForPag
	WHERE YEAR(ct.Dat_Venda) = 2008 AND st.Cod_StatusContVend <> 1