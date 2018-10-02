/*
	07 - Levantamento das Ocorr�ncias por UF
	O levantamento deve conter a primeira e a �ltima ocorr�ncia de cada classifica��o por UF.
*/

--COLOCAR CLASSIFICA��O

-- Mostrar por coluna
SELECT	oco.ocorrencia_uf,
		MIN(
				CASE 
					WHEN oco.ocorrencia_classificacao = oco.ocorrencia_classificacao
						THEN oco.ocorrencia_dia
				END
				) AS 'Primeira Ocorr�ncia',
		MAX(	
				CASE 
					WHEN oco.ocorrencia_classificacao = oco.ocorrencia_classificacao
						THEN oco.ocorrencia_dia
				END
				) AS '�ltima Ocorr�ncia'
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
