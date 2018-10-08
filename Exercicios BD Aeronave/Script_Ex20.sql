/*
	20 - Levantar o primeiro acidente de cada mês de 2018 - Ocorrências de SP.
*/

SELECT	prAc.ocorrencia_classificacao,
		prAc.ocorrencia_dia, 
		prAc.ocorrencia_horario
	FROM (SELECT MONTH(oco.ocorrencia_dia) AS mes
			FROM oco WITH(NOLOCK)
			GROUP BY MONTH(oco.ocorrencia_dia)
		) AS aux
CROSS APPLY (SELECT	TOP(1) *
				FROM oco WITH(NOLOCK)
				WHERE aux.mes = MONTH(oco.ocorrencia_dia)
					AND oco.ocorrencia_classificacao = 'Acidente'
					AND oco.ocorrencia_uf = 'SP'	
					AND YEAR(oco.ocorrencia_dia) = 2018
				ORDER BY oco.ocorrencia_dia
			)prAc	

	ORDER BY mes
	
-- usando row_number
CREATE TABLE #tbTemp(
	rowNumber INT, 
	ocorrencia_classificacao VARCHAR(50),
	ocorrencia_dia DATE,
	ocorrencia_horario TIME
)

INSERT INTO #tbTemp(RowNumber,
					ocorrencia_classificacao,
					ocorrencia_dia,
					ocorrencia_horario)

			( SELECT	ROW_NUMBER() OVER(PARTITION BY MONTH(oco.ocorrencia_dia) ORDER BY oco.ocorrencia_dia asc) AS rowNumber,
					oco.ocorrencia_classificacao,
					oco.ocorrencia_dia,
					oco.ocorrencia_horario
				FROM oco WITH(NOLOCK)
				WHERE	oco.ocorrencia_classificacao = 'Acidente'
						AND oco.ocorrencia_uf = 'SP'	
						AND YEAR(oco.ocorrencia_dia) = 2018
											
			)
			ORDER BY oco.ocorrencia_dia

SELECT	tb.ocorrencia_classificacao,
		tb.ocorrencia_dia,
		tb.ocorrencia_horario
	FROM #tbTemp tb WITH(NOLOCK)
	WHERE rowNumber = 1
	ORDER BY tb.ocorrencia_dia


-- usando with
WITH cte_table AS (SELECT ROW_NUMBER() OVER(PARTITION BY MONTH(oco.ocorrencia_dia) ORDER BY oco.ocorrencia_dia asc) AS rowNumber,
					oco.ocorrencia_classificacao,
					oco.ocorrencia_dia,
					oco.ocorrencia_horario
				FROM oco WITH(NOLOCK)
				WHERE	oco.ocorrencia_classificacao = 'Acidente'
						AND oco.ocorrencia_uf = 'SP'	
						AND YEAR(oco.ocorrencia_dia) = 2018					
			)
			
	SELECT	tb.ocorrencia_classificacao,
			tb.ocorrencia_dia,
			tb.ocorrencia_horario
		FROM cte_table tb WITH(NOLOCK)
		WHERE rowNumber = 1
		ORDER BY tb.ocorrencia_dia