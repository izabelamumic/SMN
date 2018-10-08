/*
	17 - Levantar Média de Ocorrências por Mês e Ano
*/
CREATE TABLE #tbTemp(
	Ano INT, 
	Janeiro INT, Fevereiro INT, Março INT, Abril INT, Maio INT, Junho INT,
	Julho INT, Agosto INT, Setembro INT, Outubro INT, Novembro INT, Dezembro INT, 
	TotalAno INT, MediaAno Decimal(10,2)
)

INSERT INTO #tbTemp(Ano, Janeiro, Fevereiro, Março, Abril, Maio, Junho,
					Julho, Agosto, Setembro, Outubro, Novembro, Dezembro, 
					TotalAno, MediaAno)

		(SELECT	Ano, 
			TotalOco.Janeiro, TotalOco.Fevereiro, TotalOco.Março, TotalOco.Abril, TotalOco.Maio, TotalOco.Junho, TotalOco.Junho,
			TotalOco.Agosto, TotalOco.Setembro, 	TotalOco.Outubro, TotalOco.Novembro, TotalOco.Dezembro, TotalOco.TotalAno, 
			CONVERT(DECIMAL(10,2),(CONVERT(DECIMAL(10,2),(TotalOco.TotalAno)) / 12))  AS MediaAno

		FROM (SELECT YEAR(CONVERT(DATETIME, oco.ocorrencia_dia)) as Ano,		
			COUNT(
					CASE 
						WHEN MONTH(CONVERT(DATETIME, oco.ocorrencia_dia)) = 01
							THEN 1
					END 
					) AS Janeiro,
			COUNT(
					CASE 
						WHEN MONTH(CONVERT(DATETIME, oco.ocorrencia_dia)) = 02
							THEN 1
					END 
					) AS Fevereiro,
			COUNT(
					CASE 
						WHEN MONTH(CONVERT(DATETIME, oco.ocorrencia_dia)) = 03
							THEN 1
					END 
					)  AS Março,
			COUNT(
					CASE 
						WHEN MONTH(CONVERT(DATETIME, oco.ocorrencia_dia)) = 04
							THEN 1
					END 
					)  AS Abril,
			COUNT(
					CASE 
						WHEN MONTH(CONVERT(DATETIME, oco.ocorrencia_dia)) = 05
							THEN 1
					END 
					) AS Maio,
			COUNT(
					CASE 
						WHEN MONTH(CONVERT(DATETIME, oco.ocorrencia_dia)) = 06
							THEN 1
					END 
					)  AS Junho,
			COUNT(
					CASE 
						WHEN MONTH(CONVERT(DATETIME, oco.ocorrencia_dia)) = 07
							THEN 1
					END 
					) AS Julho,
			COUNT(
					CASE 
						WHEN MONTH(CONVERT(DATETIME, oco.ocorrencia_dia)) = 08
							THEN 1
					END 
					) AS Agosto,
			COUNT(
					CASE 
						WHEN MONTH(CONVERT(DATETIME, oco.ocorrencia_dia)) = 09
							THEN 1
					END 
					) AS Setembro,
			COUNT(
					CASE 
						WHEN MONTH(CONVERT(DATETIME, oco.ocorrencia_dia)) = 10
							THEN 1
					END 
					)  AS Outubro,
			COUNT(
					CASE 
						WHEN MONTH(CONVERT(DATETIME, oco.ocorrencia_dia)) = 11
							THEN 1
					END 
					)  AS Novembro,
			COUNT(
					CASE 
						WHEN MONTH(CONVERT(DATETIME, oco.ocorrencia_dia)) = 12
							THEN 1
					END 
					)  AS Dezembro,
			COUNT(
					CASE 
						WHEN MONTH(CONVERT(DATETIME, oco.ocorrencia_dia)) BETWEEN 01 AND 12 
							THEN 1
					END 
					) AS TotalAno
	
				FROM 	oco WITH(NOLOCK)
				GROUP BY YEAR(CONVERT(DATETIME, oco.ocorrencia_dia))
			)TotalOco
		)

-- executa tudo junto a partir daqui

declare @qtdLinha int
set @qtdLinha = (select count(*) from #tbTemp)

SELECT * FROM #tbTemp
UNION
SELECT	NULL AS Ano,
		SUM(CONVERT(DECIMAL(10,2),(CONVERT(DECIMAL(10,2), temp.Janeiro) / @qtdLinha))), 
		SUM(CONVERT(DECIMAL(10,2),(CONVERT(DECIMAL(10,2),temp.Fevereiro) / @qtdLinha))),
		SUM(CONVERT(DECIMAL(10,2),(CONVERT(DECIMAL(10,2),temp.Março) / @qtdLinha))),
		SUM(CONVERT(DECIMAL(10,2),(CONVERT(DECIMAL(10,2),temp.Abril) / @qtdLinha))),
		SUM(CONVERT(DECIMAL(10,2),(CONVERT(DECIMAL(10,2),temp.Maio) / @qtdLinha))),
		SUM(CONVERT(DECIMAL(10,2),(CONVERT(DECIMAL(10,2),temp.Junho) / @qtdLinha))),
		SUM(CONVERT(DECIMAL(10,2),(CONVERT(DECIMAL(10,2),temp.Julho) / @qtdLinha))), 
		SUM(CONVERT(DECIMAL(10,2),(CONVERT(DECIMAL(10,2),temp.Agosto) / @qtdLinha))),
		SUM(CONVERT(DECIMAL(10,2),(CONVERT(DECIMAL(10,2),temp.Setembro) / @qtdLinha))), 
		SUM(CONVERT(DECIMAL(10,2),(CONVERT(DECIMAL(10,2),temp.Outubro) / @qtdLinha))), 
		SUM(CONVERT(DECIMAL(10,2),(CONVERT(DECIMAL(10,2),temp.Novembro) / @qtdLinha))), 
		SUM(CONVERT(DECIMAL(10,2),(CONVERT(DECIMAL(10,2),temp.Dezembro) / @qtdLinha))),
		NULL AS TotalAno, NULL AS TotalMedia

	FROM #tbTemp as temp
order by Ano DESC

