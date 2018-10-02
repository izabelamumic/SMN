/*
	04 - Levantamento das Ocorrências por Hora.
	O levantamento deve conter uma visão da quantidade de ocorrências separadas por 
	classificação que aconteceram em cada hora. (Sem contar minutos).
*/

-- Mostrar por coluna
SELECT	DATEPART(HOUR, (CONVERT(DATETIME, oco.ocorrencia_horario))) AS ocorrencia_horario,
		COUNT(	
				CASE 
					WHEN oco.ocorrencia_classificacao = 'Acidente' 
						THEN 1 
				END
				) AS 'Acidentes',
		COUNT(	
				CASE 
					WHEN oco.ocorrencia_classificacao = 'Incidente' 
						THEN 1
				END
				) AS 'Incidentes',
		COUNT(	
				CASE 
					WHEN oco.ocorrencia_classificacao = 'Incidente Grave' 
						THEN 1
				END
				) AS 'Incidentes Grave'
	FROM oco WITH(NOLOCK)
	GROUP BY DATEPART(HOUR, (CONVERT(DATETIME, oco.ocorrencia_horario)))
	ORDER BY ocorrencia_horario



-- Mostrar por linha
SELECT	oco.ocorrencia_classificacao,
		COUNT(oco.ocorrencia_classificacao) AS quantidadeOcorrencia,
		DATEPART(HOUR, (CONVERT(DATETIME, oco.ocorrencia_horario))) AS ocorrencia_horario
	FROM oco WITH(NOLOCK)
	GROUP BY DATEPART(HOUR, (CONVERT(DATETIME, oco.ocorrencia_horario))), oco.ocorrencia_classificacao
	ORDER BY ocorrencia_horario

