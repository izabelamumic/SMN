/*
	23 - Crie 3 Rankings de UF por quantidade de Ocorrências (descritos no card).
*/

--RANK 1
SELECT	ROW_NUMBER() OVER(ORDER BY SUM(aer.total_fatalidades)DESC) AS Posição, 
		oco.ocorrencia_uf AS UF,
		SUM(aer.total_fatalidades) AS QuantidadeFatalidade
	FROM oco WITH(NOLOCK)
	INNER JOIN anv aer WITH(NOLOCK)
		ON oco.codigo_ocorrencia = aer.codigo_ocorrencia
	WHERE oco.ocorrencia_uf <> ' '
	GROUP BY oco.ocorrencia_uf
	ORDER BY QuantidadeFatalidade DESC

--RANK 2
SELECT	DENSE_RANK() OVER(ORDER BY sum(aer.total_fatalidades) DESC) AS Posição, 
		oco.ocorrencia_uf AS UF,
		SUM(aer.total_fatalidades) AS QuantidadeFatalidade
	FROM oco WITH(NOLOCK)
	INNER JOIN anv aer WITH(NOLOCK)
		ON oco.codigo_ocorrencia = aer.codigo_ocorrencia
	WHERE oco.ocorrencia_uf <> ' '
	GROUP BY oco.ocorrencia_uf
	ORDER BY QuantidadeFatalidade DESC
			

--RANK 3
SELECT	RANK() OVER(ORDER BY sum(aer.total_fatalidades) DESC) AS Posição, 
		oco.ocorrencia_uf AS UF,
		SUM(aer.total_fatalidades) AS QuantidadeFatalidade
	FROM oco WITH(NOLOCK)
	INNER JOIN anv aer WITH(NOLOCK)
		ON oco.codigo_ocorrencia = aer.codigo_ocorrencia
	WHERE oco.ocorrencia_uf <> ' '
	GROUP BY oco.ocorrencia_uf
	ORDER BY QuantidadeFatalidade DESC