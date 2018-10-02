/*
	13 - Levantamento das Ocorrências por Classificação da Ocorrência e Quantidade de Fatalidades
*/

SELECT	[ACIDENTE],
		[INCIDENTE], 
		[INCIDENTE GRAVE] 
	FROM  (SELECT	COUNT(aer.total_fatalidades) as conta,
					oco.ocorrencia_classificacao
			FROM oco WITH(NOLOCK)
			INNER JOIN anv aer WITH(NOLOCK)
				ON oco.codigo_ocorrencia = aer.codigo_ocorrencia
			GROUP BY oco.ocorrencia_classificacao
		)aux
	PIVOT (SUM(aux.conta)
	FOR ocorrencia_classificacao IN (	[ACIDENTE],
										[INCIDENTE], 
										[INCIDENTE GRAVE])) as pivo
	--ORDER BY FATALIDADE

