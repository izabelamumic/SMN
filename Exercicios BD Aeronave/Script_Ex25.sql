/*
	25 - Levante o fabricante da primeira ocorrência de cada dia de 2018. Caso o fabricante seja o mesmo do dia anterior,
	deverá mostrar o fabricante da próxima ocorrência.
*/
use Aeronautica
SELECT aux.ocorrencia_dia, aux.ocorrencia_horario, aux.aeronave_fabricante
	FROM(SELECT	oco.ocorrencia_dia, 
				oco.ocorrencia_horario, 
				aer.aeronave_fabricante,
				ROW_NUMBER() over(partition by oco.ocorrencia_dia order by oco.ocorrencia_dia ) AS pri
			FROM oco WITH(NOLOCK)
			INNER JOIN anv aer WITH(NOLOCK)
				ON oco.codigo_ocorrencia = aer.codigo_ocorrencia
			WHERE YEAR(oco.ocorrencia_dia) = 2018
		)aux

		WHERE aux.pri = 1
		ORDER BY aux.ocorrencia_dia, aux.ocorrencia_horario
