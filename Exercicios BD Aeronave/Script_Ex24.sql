/*
	24 - Levante a segunda e penultima ocorrência de cada semana de 2018, informar data, cidade + uf e nível de dano da aeronave.
*/

SELECT	aux.semana, aux.ocorrencia_dia, aux.ocorrencia_uf, aux.aeronave_nivel_dano
	FROM (SELECT	oco.ocorrencia_dia, 
					DATEPART(WEEK,oco.ocorrencia_dia) AS semana, 
					oco.ocorrencia_uf, 
					aer.aeronave_nivel_dano, 
					ROW_NUMBER() over(partition by DATEPART(WEEK,oco.ocorrencia_dia) order by oco.ocorrencia_dia ) AS segpos,
					ROW_NUMBER() over(partition by DATEPART(WEEK,oco.ocorrencia_dia) order by oco.ocorrencia_dia desc) AS ultpos
			FROM oco WITH(NOLOCK)
			INNER JOIN anv aer WITH(NOLOCK)
				ON oco.codigo_ocorrencia = aer.codigo_ocorrencia
			WHERE YEAR(oco.ocorrencia_dia) = 2018
			--WHERE	oco.ocorrencia_dia in (select top(2) oco.ocorrencia_dia from oco order by oco.ocorrencia_dia asc)
					--OR oco.ocorrencia_dia in (select top(2) oco.ocorrencia_dia from oco order by oco.ocorrencia_dia desc)
		)aux
	where aux.segpos = 2 OR ultpos = 2