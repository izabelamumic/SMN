/*
	19 - Levantar Fabricantes e a Primeira e Última Ocorrência.
*/
SELECT	maxmin.aeronave_fabricante,
		maxmin.PrimeiraDiaOcorrencia,
		primeiro.aeronave_tipo_veiculo,
		primeiro.total_fatalidades,
		primeiro.aeronave_nivel_dano,
		maxmin.ultimoDiaOcorrencia,
		ultimo.aeronave_tipo_veiculo,
		ultimo.total_fatalidades,
		ultimo.aeronave_nivel_dano
	FROM (SELECT aer.aeronave_fabricante,
				MIN(oco.ocorrencia_dia) AS PrimeiraDiaOcorrencia,
				MIN(oco.ocorrencia_horario) AS PrimeiraHoraOcorrencia,
				MAX(oco.ocorrencia_dia) AS ultimoDiaOcorrencia,
				MAX(oco.ocorrencia_horario) AS ultimoHoraOcorrencia
			FROM anv aer
			INNER JOIN oco WITH(NOLOCK)
				ON oco.codigo_ocorrencia = aer.codigo_ocorrencia
			group by aer.aeronave_fabricante
		)maxmin
CROSS APPLY(
		SELECT	aer.aeronave_tipo_veiculo,
				aer.total_fatalidades,
				aer.aeronave_nivel_dano
			FROM  anv aer WITH(NOLOCK)
			INNER JOIN oco WITH(NOLOCK)
				ON oco.codigo_ocorrencia = aer.codigo_ocorrencia
			WHERE oco.ocorrencia_dia = maxmin.PrimeiraDiaOcorrencia AND maxmin.aeronave_fabricante = aer.aeronave_fabricante
	)primeiro
CROSS APPLY(
		SELECT	aer.aeronave_tipo_veiculo,
				aer.total_fatalidades,
				aer.aeronave_nivel_dano
			FROM  anv aer WITH(NOLOCK)
			INNER JOIN oco WITH(NOLOCK)
				ON oco.codigo_ocorrencia = aer.codigo_ocorrencia
			WHERE oco.ocorrencia_dia = maxmin.ultimoDiaOcorrencia AND maxmin.aeronave_fabricante = aer.aeronave_fabricante
	)ultimo

	GROUP BY maxmin.aeronave_fabricante,maxmin.PrimeiraDiaOcorrencia,maxmin.PrimeiraDiaOcorrencia,
			primeiro.aeronave_tipo_veiculo, 	primeiro.total_fatalidades, 	primeiro.aeronave_nivel_dano,
			maxmin.ultimoDiaOcorrencia, 	ultimo.aeronave_tipo_veiculo, ultimo.total_fatalidades, 	ultimo.aeronave_nivel_dano
	ORDER BY maxmin.aeronave_fabricante