/* 
	[10/10/2018] Eduardo: Vendas a partir de 2010
	**Tabelas de Referencias:**
	[dbo].[GKSLT_Contratos] 
	[dbo].[GKSLT_Clientes]

	Mostrar: eql, cpf cliente, nome cliente, data venda, data confirmação venda , status
	Contratos para nós siginifica vendas para o cliente
*/
SELECT	(CONVERT(VARCHAR(50), lt.Num_Empr) + ' - ' + lt.Cod_Quadra + ' - ' + CONVERT(VARCHAR(50), lt.Cod_Lot)) AS eql,
		cl.Num_CliCPFCNPJ,
		cl.Nom_Cli,
		ct.Dat_Venda,
		ct.Dat_ConfirmaVenda,
		st.Nom_StatusContVend
	FROM GKSLT_Contratos ct WITH(NOLOCK)
	INNER JOIN GKSLT_Clientes cl WITH(NOLOCK)
		ON ct.Num_CliCPFCNPJ = cl.Num_CliCPFCNPJ
	INNER JOIN GKSLT_Lotes lt WITH(NOLOCK)
		ON ct.Num_ChavLot = lt.Num_ChavLot
	INNER JOIN GKSLT_StatusContVend st WITH(NOLOCK)
		ON ct.Cod_StatusContVend = st.Cod_StatusContVend
	WHERE YEAR(ct.Dat_Venda) >= 2010 AND st.Cod_StatusContVend <> 1