/*
	25 - Levante o fabricante da primeira ocorrência de cada dia de 2018. Caso o fabricante seja o mesmo do dia anterior,
	deverá mostrar o fabricante da próxima ocorrência.
*/

CREATE TABLE #tbTemp(
	resIf INT, 
	ocorrenciaDia DATE,
	ocorrenciaHorario TIME,
	fabricante VARCHAR(50)
)

CREATE TABLE #tbTemp2(
	resIf INT, 
	ocorrenciaDia DATE,
	ocorrenciaHorario TIME,
	fabricante VARCHAR(50)
)

INSERT INTO #tbTemp(resIf,
					ocorrenciaDia,
					ocorrenciaHorario,
					fabricante)
		
	(SELECT	IIF(
			(LAG(aux.aeronave_fabricante,1,0) 
				OVER (PARTITION BY aux.pri ORDER BY aux.ocorrencia_dia) = aux.aeronave_fabricante), 2,1
			) resIf,
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
			
		WHERE aux.pri = 1

	)

INSERT INTO #tbTemp2(resIf,
					ocorrenciaDia,
					ocorrenciaHorario,
					fabricante)
		
	(SELECT	resIf,
			ocorrenciaDia,
			ocorrenciaHorario,
			fabricante	
		FROM #tbTemp	
		WHERE resIf = 2

	)

	select * from #tbTemp2

UPDATE #tbTemp2 SET 