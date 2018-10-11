/*
	24 - Levante a segunda e penultima ocorrência de cada semana de 2018, informar data, cidade + uf e nível de dano da aeronave.
*/

-- uma de baixo do outro
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
		)aux
	where aux.segpos = 2 OR ultpos = 2


-- uma na frente do outro
CREATE TABLE #temp1 (numRow INT, semana INT, ocorrencia_dia DATE, ocorrencia_uf varchar(2), nivel_dano VARCHAR(50))
CREATE TABLE #temp2 (semana INT, ocorrencia_dia DATE, ocorrencia_uf varchar(2), nivel_dano VARCHAR(50))
CREATE TABLE #temp3 (numRow INT, semana INT, ocorrencia_dia DATE, ocorrencia_uf varchar(2), nivel_dano VARCHAR(50))
CREATE TABLE #temp4 (semana INT, ocorrencia_dia DATE, ocorrencia_uf varchar(2), nivel_dano VARCHAR(50))

INSERT INTO #temp1(numRow, semana, ocorrencia_dia, ocorrencia_uf, nivel_dano)
	(SELECT ROW_NUMBER() over(partition by DATEPART(WEEK,oco.ocorrencia_dia) order by oco.ocorrencia_dia ) AS numRow,
			DATEPART(WEEK,oco.ocorrencia_dia) AS semana, 
			oco.ocorrencia_dia, 
			oco.ocorrencia_uf, 
			aer.aeronave_nivel_dano
					
		FROM oco WITH(NOLOCK)
		INNER JOIN anv aer WITH(NOLOCK)
			ON oco.codigo_ocorrencia = aer.codigo_ocorrencia
		WHERE YEAR(oco.ocorrencia_dia) = 2018 
		)

INSERT INTO #temp2(semana, ocorrencia_dia, ocorrencia_uf, nivel_dano)
	(SELECT tb.semana, tb.ocorrencia_dia, tb.ocorrencia_uf, tb.nivel_dano 
		FROM #temp1 tb
		WHERE numRow = 2 )


INSERT INTO #temp3(numRow, semana, ocorrencia_dia, ocorrencia_uf, nivel_dano)
	(SELECT ROW_NUMBER() over(partition by DATEPART(WEEK,oco.ocorrencia_dia) order by oco.ocorrencia_dia DESC) AS numRow,
			DATEPART(WEEK,oco.ocorrencia_dia) AS semana, 
			oco.ocorrencia_dia, 
			oco.ocorrencia_uf, 
			aer.aeronave_nivel_dano
					
		FROM oco WITH(NOLOCK)
		INNER JOIN anv aer WITH(NOLOCK)
			ON oco.codigo_ocorrencia = aer.codigo_ocorrencia
		WHERE YEAR(oco.ocorrencia_dia) = 2018 
		)

INSERT INTO #temp4(semana, ocorrencia_dia, ocorrencia_uf, nivel_dano)
	(SELECT tb.semana, tb.ocorrencia_dia, tb.ocorrencia_uf, tb.nivel_dano 
		FROM #temp3 tb
		WHERE numRow = 2 )

SELECT	tb2.semana, tb2.ocorrencia_dia, tb2.ocorrencia_uf, tb2.nivel_dano,
		tb4.ocorrencia_dia, tb4.ocorrencia_uf, tb4.nivel_dano
	FROM #temp2 tb2
	INNER JOIN #temp4 tb4
		ON tb2.semana = tb4.semana

DROP TABLE #temp1
DROP TABLE #temp2
DROP TABLE #temp3
DROP TABLE #temp4