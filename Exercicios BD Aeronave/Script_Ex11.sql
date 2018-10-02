/*
	11 - Levantamento das Ocorr�ncias por N�vel de Dano e �rea de Fator
*/

SELECT	Fator,
		[SUBSTANCIAL],
		[LEVE], 
		[NENHUM], 
		[DESTRU�DA],
		[INDETERMINADO]
	FROM  (SELECT	COUNT(aer.aeronave_nivel_dano) as conta,
					aer.aeronave_nivel_dano,
					ftc.fator_area as Fator
			FROM anv aer WITH(NOLOCK)
			INNER JOIN  ftc   WITH(NOLOCK)
				ON aer.codigo_ocorrencia = ftc.codigo_ocorrencia
			GROUP BY aer.aeronave_nivel_dano, ftc.fator_area
		)aux
	PIVOT (SUM(aux.conta)
	FOR aeronave_nivel_dano IN (	[SUBSTANCIAL],
								[LEVE], 
								[NENHUM], 
								[DESTRU�DA],
								[INDETERMINADO])) as pivo
	ORDER BY Fator
