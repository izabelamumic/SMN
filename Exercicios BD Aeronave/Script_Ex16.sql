/*
	16 - Levantamento Fabricantes e todas as suas Categorias de Ocorr�ncias
*/

SELECT	Fabricante,
		[CORTANTE DE VENTO / TEMPESTADE], [COMBUST�VEL], [COLIS�O NO SOLO], [FALHA OU MAU FUNCIONAMENTO DO MOTOR],
		[FOGO/FUMA�A (SEM IMPACTO)], [PERDA DE CONTROLE EM VOO], [VOO CONTROLADO CONTRA O TERRENO],
		[COLIS�O COM OBST�CULO DURANTE A DECOLAGEM E POUSO], [CONTATO ANORMAL COM A PISTA], [RELACIONADO COM SECURITY],
		[OPERA��O A BAIXA ALTITUDE], [MANOBRA ABRUPTA], [POUSO AQU�M/AL�M DA PISTA], [TURBUL�NCIA], 
		[PERDA DE SEPARA��O / COLIS�O EM VOO], [INCURS�O EM PISTA], [OUTROS], [FALHA OU MAU FUNCIONAMENTO DE SISTEMA / COMPONENTE],
		[AER�DROMO], [M�DICO], [INDETERMINADO], [OPERA��ES NO SOLO], [EXCURS�O DE PISTA], [PERDA DE CONTROLE NO SOLO]
	FROM  (SELECT	COUNT(oco.ocorrencia_tipo_categoria) as conta,
					oco.ocorrencia_tipo_categoria,
					aer.aeronave_fabricante as Fabricante
			FROM oco WITH(NOLOCK)
			INNER JOIN  anv aer WITH(NOLOCK)
				ON oco.codigo_ocorrencia = aer.codigo_ocorrencia
			GROUP BY oco.ocorrencia_tipo_categoria, aer.aeronave_fabricante
		)aux
	PIVOT (SUM(aux.conta)
	FOR ocorrencia_tipo_categoria IN (	[CORTANTE DE VENTO / TEMPESTADE], [COMBUST�VEL], [COLIS�O NO SOLO], 
										[FALHA OU MAU FUNCIONAMENTO DO MOTOR], [FOGO/FUMA�A (SEM IMPACTO)], 
										[PERDA DE CONTROLE EM VOO], [VOO CONTROLADO CONTRA O TERRENO],
										[COLIS�O COM OBST�CULO DURANTE A DECOLAGEM E POUSO], [CONTATO ANORMAL COM A PISTA],
										[RELACIONADO COM SECURITY], [OPERA��O A BAIXA ALTITUDE], [MANOBRA ABRUPTA], 
										[POUSO AQU�M/AL�M DA PISTA], [TURBUL�NCIA], [PERDA DE SEPARA��O / COLIS�O EM VOO], 
										[INCURS�O EM PISTA], [OUTROS], [FALHA OU MAU FUNCIONAMENTO DE SISTEMA / COMPONENTE],
										[AER�DROMO], [M�DICO], [INDETERMINADO], [OPERA��ES NO SOLO], [EXCURS�O DE PISTA], 
										[PERDA DE CONTROLE NO SOLO])) as pivo
	ORDER BY Fabricante

	select oco.ocorrencia_tipo_categoria from oco group by oco.ocorrencia_tipo_categoria

SELECT aer.aeronave_fabricante, oco.ocorrencia_tipo_categoria
	FROM anv aer WITH(NOLOCK)
	INNER JOIN oco WITH(NOLOCK)
		ON oco.codigo_ocorrencia = aer.codigo_ocorrencia
	GROUP BY aer.aeronave_fabricante, oco.ocorrencia_tipo_categoria
	ORDER BY oco.ocorrencia_tipo_categoria
