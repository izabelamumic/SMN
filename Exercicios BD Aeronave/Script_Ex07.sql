/*
	07 - Levantamento das Ocorrências por UF
	O levantamento deve conter a primeira e a última ocorrência de cada classificação por UF.
*/

--COLOCAR CLASSIFICAÇÃO

-- Mostrar por coluna
SELECT	oco.ocorrencia_uf,
		MIN(
				CASE 
					WHEN oco.ocorrencia_classificacao = oco.ocorrencia_classificacao
						THEN oco.ocorrencia_dia
				END
				) AS 'Primeira Ocorrência',
		MAX(	
				CASE 
					WHEN oco.ocorrencia_classificacao = oco.ocorrencia_classificacao
						THEN oco.ocorrencia_dia
				END
				) AS 'Última Ocorrência'
	FROM oco WITH(NOLOCK)
	WHERE oco.ocorrencia_uf <> ' '
	GROUP BY oco.ocorrencia_uf
	ORDER BY oco.ocorrencia_uf



-- Mostrar por linha
SELECT	oco.ocorrencia_classificacao, oco.ocorrencia_uf,
		MIN(oco.ocorrencia_dia) as primeiraOcorrencia,
		MAX(oco.ocorrencia_dia) as ultimaOcorrencia
	FROM oco WITH(NOLOCK)
	WHERE oco.ocorrencia_uf <> ' '
	GROUP BY oco.ocorrencia_classificacao, oco.ocorrencia_uf
	ORDER BY oco.ocorrencia_uf
