/*
	10 - Levantamento das Aeronaves por Ano de Acidente e Nível de Dano
*/

SELECT	Ano,
		[SUBSTANCIAL],
		[LEVE], 
		[NENHUM], 
		[DESTRUÍDA],
		[INDETERMINADO]
	FROM  (SELECT	COUNT(aer.aeronave_nivel_dano) as conta,
					aer.aeronave_nivel_dano,
					DATEPART(YEAR, (CONVERT(DATETIME, oco.ocorrencia_dia))) as Ano
			FROM oco WITH(NOLOCK)
			INNER JOIN  anv  aer WITH(NOLOCK)
				ON oco.codigo_ocorrencia = aer.codigo_ocorrencia
			GROUP BY aer.aeronave_nivel_dano, DATEPART(YEAR, (CONVERT(DATETIME, oco.ocorrencia_dia))) 
		)aux
	PIVOT (SUM(aux.conta)
	FOR aeronave_nivel_dano IN (	[SUBSTANCIAL],
								[LEVE], 
								[NENHUM], 
								[DESTRUÍDA],
								[INDETERMINADO])) as pivo
	ORDER BY Ano



	select	anv.aeronave_nivel_dano
		from ANV
		GROUP BY anv.aeronave_nivel_dano
