/*
	03 - Levantar Acidentes e Incidentes por UF
	O levantamento deve conter uma visão de quantos ACIDENTES e INCIDENTES temos por UF
*/
-- Mostrar por coluna
SELECT	oco.ocorrencia_uf,
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
				) AS 'Incidentes'
	FROM oco WITH(NOLOCK)
	WHERE oco.ocorrencia_classificacao <> ' '  AND oco.ocorrencia_classificacao <> 'Incidente Grave' AND oco.ocorrencia_uf <> ' ' 
	GROUP BY oco.ocorrencia_uf
	ORDER BY oco.ocorrencia_uf



-- Mostrar por linha
SELECT	oco.ocorrencia_classificacao,
		COUNT(oco.ocorrencia_classificacao) as quantidade,
		oco.ocorrencia_uf
	FROM oco WITH(NOLOCK)
	WHERE oco.ocorrencia_classificacao <> ' '  AND oco.ocorrencia_classificacao <> 'Incidente Grave' AND oco.ocorrencia_uf <> ' ' 
	GROUP BY oco.ocorrencia_classificacao, oco.ocorrencia_uf
	ORDER BY oco.ocorrencia_uf
	