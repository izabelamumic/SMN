/*
	20 - Levantar o primeiro acidente de cada mês de 2018 - Ocorrências de SP.
*/

SELECT	prAc.ocorrencia_classificacao,
		prAc.ocorrencia_dia, 
		prAc.ocorrencia_horario
	FROM (SELECT MONTH(oco.ocorrencia_dia) AS mes
			FROM oco WITH(NOLOCK)
			--WHERE YEAR(oco.ocorrencia_dia) = 2018
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