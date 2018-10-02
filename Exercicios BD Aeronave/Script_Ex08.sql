/*
	08 - Levantamento das Ocorr�ncias por Tipo de Opera��o e N�vel de Dano
*/

SELECT	aer.aeronave_tipo_operacao,
		COUNT(
				CASE 
					WHEN aer.aeronave_nivel_dano = 'DESTRU�DA'
						THEN 1
				END
				) AS 'DESTRU�DA',
		COUNT(
				CASE 
					WHEN aer.aeronave_nivel_dano = 'INDETERMINADO'
						THEN 1
				END
				) AS 'INDETERMINADO',
		COUNT(	
				CASE 
					WHEN aer.aeronave_nivel_dano = 'LEVE'
						THEN 1
				END
				) AS 'LEVE',
		COUNT(
				CASE 
					WHEN aer.aeronave_nivel_dano = 'NENHUM'
						THEN 1
				END
				) AS 'NENHUM',
		COUNT(	
				CASE 
					WHEN aer.aeronave_nivel_dano = 'SUBSTANCIAL'
						THEN 1
				END
				) AS 'SUBSTANCIAL'
	FROM oco WITH(NOLOCK)
	INNER JOIN anv aer WITH(NOLOCK)
		ON oco.codigo_ocorrencia = aer.codigo_ocorrencia
	GROUP BY aer.aeronave_tipo_operacao
	ORDER BY aer.aeronave_tipo_operacao

