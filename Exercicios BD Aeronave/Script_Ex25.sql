/*
	25 - Levante o fabricante da primeira ocorrência de cada dia de 2018. Caso o fabricante seja o mesmo do dia anterior,
	deverá mostrar o fabricante da próxima ocorrência.
*/

CREATE TABLE #tbTemp(resIf INT,  fab VARCHAR(50), ocorrenciaDia DATE, ocorrenciaHorario TIME, fabricante VARCHAR(50))

CREATE TABLE #tbTemp2(resIf INT, fab VARCHAR(50), ocorrenciaDia DATE, ocorrenciaHorario TIME, fabricante VARCHAR(50))

INSERT INTO #tbTemp(resIf, fab, ocorrenciaDia, ocorrenciaHorario, fabricante) 
	(SELECT	IIF(
			(LAG(aux.aeronave_fabricante,1,0) 
				OVER (PARTITION BY aux.pri ORDER BY aux.ocorrencia_dia) = aux.aeronave_fabricante), 2,1
			) resIf,

			IIF (aux.aeronave_fabricante <> LAG(aux.aeronave_fabricante,1,0) OVER (ORDER BY aux.ocorrencia_dia, aux.ocorrencia_horario),
				aux.aeronave_fabricante, ' '
				) fab,

			aux.ocorrencia_dia, aux.ocorrencia_horario, aux.aeronave_fabricante
		FROM(SELECT	oco.ocorrencia_dia, 
					oco.ocorrencia_horario, 
					aer.aeronave_fabricante,
					ROW_NUMBER() over(partition by oco.ocorrencia_dia order by oco.ocorrencia_dia ) AS pri
				FROM oco WITH(NOLOCK)
				INNER JOIN anv aer WITH(NOLOCK)
					ON oco.codigo_ocorrencia = aer.codigo_ocorrencia
				WHERE YEAR(oco.ocorrencia_dia) = 2018
			)aux
	)

	select * from #tbTemp order by ocorrenciaDia


INSERT INTO #tbTemp2(resIf,fab, ocorrenciaDia, ocorrenciaHorario, fabricante)		
	(SELECT	resIf,
			FIRST_VALUE(fab) OVER (PARTITION BY ocorrenciaDia ORDER BY ocorrenciaDia, ocorrenciaHorario) AS x,	
			ocorrenciaDia,
			ocorrenciaHorario,
			fabricante
		FROM #tbTemp	
		WHERE fab <> ' ' 
	)

SELECT aux.fab, aux.ocorrenciaDia, aux.ocorrenciaHorario
	FROM ( SELECT IIF(tb2.fab <> LAG(tb2.fab,1,0) OVER(ORDER BY tb2.ocorrenciaDia, tb2.ocorrenciaHorario),  tb2.fab, NULL
			) fab,
			tb2.ocorrenciaDia AS ocorrenciaDia,
			tb2.ocorrenciaHorario AS ocorrenciaHorario
			FROM #tbTemp2 tb2
		) aux

		WHERE aux.fab IS NOT NULL
		