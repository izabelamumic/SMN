/*
	15 - Levantamento das Ocorrências por Fabricante da Aeronave por Classificação da Ocorrência
*/

SELECT	Fabricante,
		ISNULL([ACIDENTE],0),
		ISNULL([INCIDENTE],0), 
		ISNULL([INCIDENTE GRAVE],0) 
	FROM  (SELECT	COUNT(oco.ocorrencia_classificacao) as conta,
					oco.ocorrencia_classificacao,
					aer.aeronave_fabricante as Fabricante
			FROM oco WITH(NOLOCK)
			INNER JOIN  anv aer WITH(NOLOCK)
				ON oco.codigo_ocorrencia = aer.codigo_ocorrencia
			GROUP BY oco.ocorrencia_classificacao, aer.aeronave_fabricante
		)aux
	PIVOT (SUM(aux.conta)
	FOR ocorrencia_classificacao IN (	[ACIDENTE],
										[INCIDENTE], 
										[INCIDENTE GRAVE])) as pivo
	ORDER BY Fabricante



SELECT aer.aeronave_fabricante, oco.ocorrencia_classificacao
	FROM anv aer WITH(NOLOCK)
	INNER JOIN oco WITH(NOLOCK)
		ON oco.codigo_ocorrencia = aer.codigo_ocorrencia
	GROUP BY aer.aeronave_fabricante, oco.ocorrencia_classificacao
	ORDER BY oco.ocorrencia_classificacao DESC