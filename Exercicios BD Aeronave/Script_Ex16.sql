/*
	16 - Levantamento Fabricantes e todas as suas Categorias de Ocorrências
*/

SELECT	Fabricante,
		[CORTANTE DE VENTO / TEMPESTADE], [COMBUSTÍVEL], [COLISÃO NO SOLO], [FALHA OU MAU FUNCIONAMENTO DO MOTOR],
		[FOGO/FUMAÇA (SEM IMPACTO)], [PERDA DE CONTROLE EM VOO], [VOO CONTROLADO CONTRA O TERRENO],
		[COLISÃO COM OBSTÁCULO DURANTE A DECOLAGEM E POUSO], [CONTATO ANORMAL COM A PISTA], [RELACIONADO COM SECURITY],
		[OPERAÇÃO A BAIXA ALTITUDE], [MANOBRA ABRUPTA], [POUSO AQUÉM/ALÉM DA PISTA], [TURBULÊNCIA], 
		[PERDA DE SEPARAÇÃO / COLISÃO EM VOO], [INCURSÃO EM PISTA], [OUTROS], [FALHA OU MAU FUNCIONAMENTO DE SISTEMA / COMPONENTE],
		[AERÓDROMO], [MÉDICO], [INDETERMINADO], [OPERAÇÕES NO SOLO], [EXCURSÃO DE PISTA], [PERDA DE CONTROLE NO SOLO]
	FROM  (SELECT	COUNT(oco.ocorrencia_tipo_categoria) as conta,
					oco.ocorrencia_tipo_categoria,
					aer.aeronave_fabricante as Fabricante
			FROM oco WITH(NOLOCK)
			INNER JOIN  anv aer WITH(NOLOCK)
				ON oco.codigo_ocorrencia = aer.codigo_ocorrencia
			GROUP BY oco.ocorrencia_tipo_categoria, aer.aeronave_fabricante
		)aux
	PIVOT (SUM(aux.conta)
	FOR ocorrencia_tipo_categoria IN (	[CORTANTE DE VENTO / TEMPESTADE], [COMBUSTÍVEL], [COLISÃO NO SOLO], 
										[FALHA OU MAU FUNCIONAMENTO DO MOTOR], [FOGO/FUMAÇA (SEM IMPACTO)], 
										[PERDA DE CONTROLE EM VOO], [VOO CONTROLADO CONTRA O TERRENO],
										[COLISÃO COM OBSTÁCULO DURANTE A DECOLAGEM E POUSO], [CONTATO ANORMAL COM A PISTA],
										[RELACIONADO COM SECURITY], [OPERAÇÃO A BAIXA ALTITUDE], [MANOBRA ABRUPTA], 
										[POUSO AQUÉM/ALÉM DA PISTA], [TURBULÊNCIA], [PERDA DE SEPARAÇÃO / COLISÃO EM VOO], 
										[INCURSÃO EM PISTA], [OUTROS], [FALHA OU MAU FUNCIONAMENTO DE SISTEMA / COMPONENTE],
										[AERÓDROMO], [MÉDICO], [INDETERMINADO], [OPERAÇÕES NO SOLO], [EXCURSÃO DE PISTA], 
										[PERDA DE CONTROLE NO SOLO])) as pivo
	ORDER BY Fabricante

	select oco.ocorrencia_tipo_categoria from oco group by oco.ocorrencia_tipo_categoria

SELECT aer.aeronave_fabricante, oco.ocorrencia_tipo_categoria
	FROM anv aer WITH(NOLOCK)
	INNER JOIN oco WITH(NOLOCK)
		ON oco.codigo_ocorrencia = aer.codigo_ocorrencia
	GROUP BY aer.aeronave_fabricante, oco.ocorrencia_tipo_categoria
	ORDER BY oco.ocorrencia_tipo_categoria
