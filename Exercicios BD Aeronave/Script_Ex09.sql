/*
	09 - Levantamento das Aeronaves por UF e Segmento por Ano de Acidente
*/

SELECT	Ano,
		[ADMINISTRAÇÃO DIRETA], [ADMINISTRAÇÃO INDIRETA], [AGRÍCOLA], [ESPECIALIZADA], [EXPERIMENTAL], [HISTÓRICA], 
		[INSTRUÇÃO], [MÚLTIPLA], [NÃO REGULAR], [PARTICULAR], [REGULAR], [TÁXI AÉREO]
	FROM (SELECT		COUNT(aer.aeronave_registro_segmento) as conta,
					aer.aeronave_registro_segmento,
					DATEPART(YEAR, (CONVERT(DATETIME, oco.ocorrencia_dia))) as Ano
			FROM oco WITH(NOLOCK)
			INNER JOIN anv aer WITH(NOLOCK)
				ON oco.codigo_ocorrencia = aer.codigo_ocorrencia
				WHERE oco.ocorrencia_uf = 'SP'
			GROUP BY oco.ocorrencia_uf, aer.aeronave_registro_segmento, DATEPART(YEAR, (CONVERT(DATETIME, oco.ocorrencia_dia))) 
			)aux
	PIVOT( SUM(aux.conta)
	FOR  aeronave_registro_segmento IN (	[ADMINISTRAÇÃO DIRETA], [ADMINISTRAÇÃO INDIRETA], [AGRÍCOLA], [ESPECIALIZADA], [EXPERIMENTAL], [HISTÓRICA], 
							[INSTRUÇÃO], [MÚLTIPLA], [NÃO REGULAR], [PARTICULAR], [REGULAR], [TÁXI AÉREO])) as pivo
	ORDER BY Ano

--SELECT	oco.ocorrencia_uf, 
--		DATEPART(YEAR, (CONVERT(DATETIME, oco.ocorrencia_dia))) AS Ano
--	FROM oco WITH(NOLOCK)
--	INNER JOIN anv aer WITH(NOLOCK)
--		ON oco.codigo_ocorrencia = aer. codigo_ocorrencia
--	WHERE oco.ocorrencia_uf <> ' '
--	GROUP BY oco.ocorrencia_uf,
--			DATEPART(YEAR, (CONVERT(DATETIME, oco.ocorrencia_dia)))
--	ORDER BY oco.ocorrencia_uf

	
--SELECT	oco.ocorrencia_uf FROM oco
--group by oco.ocorrencia_uf
--order by oco.ocorrencia_uf


--	select	DATEPART(YEAR, (CONVERT(DATETIME, oco.ocorrencia_dia))) as Ano,
--			anv.aeronave_registro_segmento
--		from oco
--		inner join anv
--			on oco.codigo_ocorrencia = anv.codigo_ocorrencia
--		group by DATEPART(YEAR, (CONVERT(DATETIME, oco.ocorrencia_dia))),
--			anv.aeronave_registro_segmento 
--		order by aeronave_registro_segmento