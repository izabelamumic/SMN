/*
	01 - Levantamento das aeronaves envolvidas em acidentes
	Deve conter os seguintes resultados:

	- Detalhamento 
	- Qtd. por fabricante
	- Qtd. por tipo de veiculo
	- Qtd. por quantidade de motor
	- Qtd. por categoria
	- Qtd. por Ano de Fabricação
*/

-- Detalhamento
SELECT oco.codigo_ocorrencia,
	SUBSTRING(detalhes,1,LEN(detalhes) - 1) AS Detalhe
	FROM oco WITH(NOLOCK)
	CROSS APPLY(SELECT (fat.fator_detalhe_fator + '  ')
		FROM ftc fat WITH(NOLOCK)
		WHERE oco.codigo_ocorrencia = fat.codigo_ocorrencia
			AND oco.ocorrencia_classificacao = 'Acidente' 
			AND fat.fator_detalhe_fator <> ' '
		FOR XML PATH('')
	) de (detalhes)
	WHERE detalhes IS NOT NULL

	 
SELECT	fat.fator_detalhe_fator,
		COUNT(fat.fator_detalhe_fator) AS QuantidadeDetalhe
	FROM ftc fat WITH(NOLOCK)
	INNER JOIN oco WITH(NOLOCK)
		ON oco.codigo_ocorrencia = fat.codigo_ocorrencia
	WHERE oco.ocorrencia_classificacao = 'Acidente' AND fat.fator_detalhe_fator <> ' '
	GROUP BY fat.fator_detalhe_fator
	ORDER BY QuantidadeDetalhe

-- Quantidade por fabricante
SELECT aer.aeronave_fabricante, 
		COUNT(aer.aeronave_fabricante) AS QuantidadeTipoAeronave
	FROM anv aer WITH(NOLOCK)
	INNER JOIN oco  WITH(NOLOCK)
		ON oco.codigo_ocorrencia = aer.codigo_ocorrencia
	WHERE oco.ocorrencia_classificacao = 'Acidente'
	GROUP BY aer.aeronave_fabricante
	ORDER BY QuantidadeTipoAeronave DESC

-- Quantidade por tipo de veiculo
SELECT aer.aeronave_tipo_veiculo, 
		COUNT(aer.aeronave_tipo_veiculo) AS QuantidadeTipoAeronave
	FROM anv aer  WITH(NOLOCK)
	INNER JOIN oco  WITH(NOLOCK)
		ON oco.codigo_ocorrencia = aer.codigo_ocorrencia
	WHERE oco.ocorrencia_classificacao = 'Acidente'
	GROUP BY aer.aeronave_tipo_veiculo
	ORDER BY QuantidadeTipoAeronave DESC

-- Quantidade por quantidade de motor
SELECT aer.aeronave_motor_quantidade, 
		COUNT(aer.aeronave_motor_quantidade) AS QuantidadeMotor
	FROM anv aer WITH(NOLOCK)
	INNER JOIN oco WITH(NOLOCK)
		ON oco.codigo_ocorrencia = aer.codigo_ocorrencia
	WHERE oco.ocorrencia_classificacao = 'Acidente'
	GROUP BY aer.aeronave_motor_quantidade
	ORDER BY QuantidadeMotor DESC

-- Quantidade por categoria
SELECT aer.aeronave_registro_categoria, 
		COUNT(aer.aeronave_registro_categoria) AS QuantidadeCategoria
	FROM anv aer
	INNER JOIN oco WITH(NOLOCK)
		ON oco.codigo_ocorrencia = aer.codigo_ocorrencia
	WHERE oco.ocorrencia_classificacao = 'Acidente' AND aer.aeronave_registro_categoria <> ' '
	GROUP BY aer.aeronave_registro_categoria
	ORDER BY QuantidadeCategoria DESC

-- Quantidade por Ano de Fabricação
SELECT aer.aeronave_ano_fabricacao, 
		COUNT(aer.aeronave_ano_fabricacao) AS QuantidadeAnoFabricacao
	FROM anv aer
	INNER JOIN oco WITH(NOLOCK)
		ON oco.codigo_ocorrencia = aer.codigo_ocorrencia
	WHERE oco.ocorrencia_classificacao = 'Acidente'
	GROUP BY aer.aeronave_ano_fabricacao
	ORDER BY aer.aeronave_ano_fabricacao