/*
	12 - Levantamento das Ocorr�ncias por Classifica��o da Ocorr�ncia e �rea de Fator
*/

SELECT	Fator,
		[ACIDENTE],
		[INCIDENTE], 
		[INCIDENTE GRAVE] 
	FROM  (SELECT	COUNT(oco.ocorrencia_classificacao) as conta,
					oco.ocorrencia_classificacao,
					ftc.fator_area as Fator
			FROM oco WITH(NOLOCK)
			INNER JOIN  ftc WITH(NOLOCK)
				ON oco.codigo_ocorrencia = ftc.codigo_ocorrencia
			GROUP BY oco.ocorrencia_classificacao, ftc.fator_area
		)aux
	PIVOT (SUM(aux.conta)
	FOR ocorrencia_classificacao IN (	[ACIDENTE],
										[INCIDENTE], 
										[INCIDENTE GRAVE])) as pivo
	ORDER BY Fator

