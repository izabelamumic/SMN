/*
	05 - Levantamento das Ocorrências por Dia.
	O levantamento deve conter uma visão da quantidade de ocorrências separadas por classificação
	que aconteceram em cada dia. (Sem contar mês e ano).
*/

-- Mostrar por coluna
SELECT	DATEPART(DAY, (CONVERT(DATETIME, oco.ocorrencia_dia))) AS ocorrencia_dia,
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
				) AS 'Incidente Grave'
	FROM oco WITH(NOLOCK)
	GROUP BY DATEPART(DAY, (CONVERT(DATETIME, oco.ocorrencia_dia)))
	ORDER BY ocorrencia_dia



-- Mostrar por linha
SELECT	oco.ocorrencia_classificacao,
		COUNT(oco.ocorrencia_classificacao) AS quantidadeOcorrencia,
		DATEPART(DAY, (CONVERT(DATETIME, oco.ocorrencia_dia))) AS ocorrencia_dia
	FROM oco WITH(NOLOCK)
	GROUP BY DATEPART(DAY, (CONVERT(DATETIME, oco.ocorrencia_dia))), oco.ocorrencia_classificacao
	ORDER BY ocorrencia_dia

