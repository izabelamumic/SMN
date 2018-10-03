/*
	07 - Levantamento das Ocorrências por UF
	O levantamento deve conter a primeira e a última ocorrência de cada classificação por UF.
*/

--COLOCAR CLASSIFICAÇÃO

-- Mostrar por coluna
SELECT	oco.ocorrencia_uf,
		MIN(
				CASE 
					WHEN oco.ocorrencia_classificacao = 'Acidente'
						THEN oco.ocorrencia_dia
				END
				) AS 'PrimeiraOcorrenciaAcidente',
		MAX(	
				CASE 
					WHEN oco.ocorrencia_classificacao = 'Acidente'
						THEN oco.ocorrencia_dia
				END
				) AS 'UltimaOcorrenciaAcidente',
		MIN(
				CASE 
					WHEN oco.ocorrencia_classificacao = 'Incidente'
						THEN oco.ocorrencia_dia
				END
				) AS 'PrimeiraOcorrenciaIncidente',
		MAX(	
				CASE 
					WHEN oco.ocorrencia_classificacao = 'Incidente'
						THEN oco.ocorrencia_dia
				END
				) AS 'UltimaOcorrenciaIncidente',
		MIN(
				CASE 
					WHEN oco.ocorrencia_classificacao = 'Incidente Grave'
						THEN oco.ocorrencia_dia
				END
				) AS 'PrimeiraOcorrenciaIncidenteGrave',
		MAX(	
				CASE 
					WHEN oco.ocorrencia_classificacao = 'Incidente Grave'
						THEN oco.ocorrencia_dia
				END
				) AS 'UltimaOcorrenciaIncidenteGrave'
	FROM oco WITH(NOLOCK)
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
