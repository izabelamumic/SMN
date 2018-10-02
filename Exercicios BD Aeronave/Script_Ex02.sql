/*
	02 - Levantar as ocorrências

	Deve conter os seguintes resultados:
	- Detalhamento 
	- Qtd. por tipo
	- Qtd. por categoria
	- Qtd. por UF
*/

-- Detalhamento
SELECT	oco.ocorrencia_classificacao, 
		ftc.fator_detalhe_fator, 
		COUNT(ftc.fator_detalhe_fator) AS QuantidadeDetalheTipo
	FROM oco WITH(NOLOCK)
	INNER JOIN ftc WITH(NOLOCK)
		ON oco.codigo_ocorrencia = ftc.codigo_ocorrencia
	GROUP BY oco.ocorrencia_classificacao, ftc.fator_detalhe_fator
	ORDER BY QuantidadeDetalheTipo DESC

-- Quantidade tipo ocorrencia
SELECT	oco.ocorrencia_classificacao, 
		oco.ocorrencia_tipo, 
		COUNT(oco.ocorrencia_tipo) AS QuantidadeTipoOcorrencia
	FROM oco
	GROUP BY oco.ocorrencia_classificacao, oco.ocorrencia_tipo
	ORDER BY QuantidadeTipoOcorrencia DESC

-- Quantidade Categoria
SELECT	oco.ocorrencia_classificacao,
		oco.ocorrencia_tipo_categoria, 
		COUNT(oco.ocorrencia_tipo_categoria) AS QuantidadeCategoria
	FROM oco
	GROUP BY oco.ocorrencia_classificacao, oco.ocorrencia_tipo_categoria
	ORDER BY QuantidadeCategoria DESC

-- Quantidade UF
SELECT	oco.ocorrencia_classificacao, 
		oco.ocorrencia_uf, 
		COUNT(oco.ocorrencia_uf) AS QuantidadeUF
	FROM oco
	GROUP BY oco.ocorrencia_classificacao, oco.ocorrencia_uf
	ORDER BY QuantidadeUF DESC