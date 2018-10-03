/*
	17 - Levantar Média de Ocorrências por Mês e Ano
*/

declare @media2008 int, @media2009 int,  @media2010 int, @media2011 int, @media2012 int,
		@media2013 int, 	@media2014 int, @media2015 int, @media2016 int, @media2017 int, @media2018 int

SELECT	@media2008 = AVG(total.Media2008),
		@media2009 = AVG(total.Media2009), 
		@media2010 = AVG(total.Media2010),
		@media2011 = AVG(total.Media2011),	  
		@media2012 = AVG(total.Media2012),
		@media2013 = AVG(total.Media2013),
		@media2014 = AVG(total.Media2014),
		@media2015 = AVG(total.Media2015),
		@media2016 = AVG(total.Media2016),
		@media2017 = AVG(total.Media2017),
		@media2018 = AVG(total.Media2018)

	FROM ( SELECT YEAR(CONVERT(DATETIME, oco.ocorrencia_dia)) as Ano,		
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
				) AS TotalAno,
		COUNT(
				CASE 
					WHEN MONTH(CONVERT(DATETIME, oco.ocorrencia_dia)) = 2008
						THEN 1
				END 
				) AS Media2008,
		COUNT(
				CASE 
					WHEN MONTH(CONVERT(DATETIME, oco.ocorrencia_dia)) = 2009
						THEN 1
				END 
				) AS Media2009,
		COUNT(
				CASE 
					WHEN MONTH(CONVERT(DATETIME, oco.ocorrencia_dia)) = 2010
						THEN 1
				END 
				) AS Media2010,
		
		COUNT(
				CASE 
					WHEN MONTH(CONVERT(DATETIME, oco.ocorrencia_dia)) = 2011
						THEN 1
				END 
				) AS Media2011,
		
		COUNT(
				CASE 
					WHEN MONTH(CONVERT(DATETIME, oco.ocorrencia_dia)) = 2012
						THEN 1
				END 
				) AS Media2012,
		
		COUNT(
				CASE 
					WHEN MONTH(CONVERT(DATETIME, oco.ocorrencia_dia)) = 2013
						THEN 1
				END 
				) AS Media2013,
		
		COUNT(
				CASE 
					WHEN MONTH(CONVERT(DATETIME, oco.ocorrencia_dia)) = 2014
						THEN 1
				END 
				) AS Media2014,
		
		COUNT(
				CASE 
					WHEN MONTH(CONVERT(DATETIME, oco.ocorrencia_dia)) = 2015
						THEN 1
				END 
				) AS Media2015,
		
		COUNT(
				CASE 
					WHEN MONTH(CONVERT(DATETIME, oco.ocorrencia_dia)) = 2016
						THEN 1
				END 
				) AS Media2016,
		
		COUNT(
				CASE 
					WHEN MONTH(CONVERT(DATETIME, oco.ocorrencia_dia)) = 2017
						THEN 1
				END 
				) AS Media2017,
		
		COUNT(
				CASE 
					WHEN MONTH(CONVERT(DATETIME, oco.ocorrencia_dia)) = 2018
						THEN 1
				END 
				) AS Media2018
						
				FROM oco WITH(NOLOCK)
				GROUP BY YEAR(CONVERT(DATETIME, oco.ocorrencia_dia))
				--ORDER BY Ano
			) AS total

	SELECT YEAR(CONVERT(DATETIME, oco.ocorrencia_dia)) AS Ano, 
			@media2008 AS Media2008,
			@media2009 AS Media2009,
			@media2010 AS Media2010,
			@media2011 AS Media2011,
			@media2012 AS Media2012,
			@media2013 AS Media2013,
			@media2014 AS Media2014,
			@media2015 AS Media2015,
			@media2016 AS Media2016,
			@media2017 AS Media2017,
			@media2018 AS Media2018
	FROM oco WITH(NOLOCK)
	GROUP BY YEAR(CONVERT(DATETIME, oco.ocorrencia_dia))
	order by Ano

-- REFAZER
--SELECT  AVG(TotalMes.QuantidadeMes) as MediaMes,
--		AVG(TotalAno.QuantidadeAno) as MediaAno
--	FROM (SELECT
--				MONTH(CONVERT(DATETIME, oco.ocorrencia_dia)) as Mes,
--				COUNT(oco.ocorrencia_dia) as QuantidadeMes
--			FROM oco WITH(NOLOCK)
--			GROUP BY MONTH(CONVERT(DATETIME, oco.ocorrencia_dia))
--		) as TotalMes,

--		(SELECT
--				YEAR(CONVERT(DATETIME, oco.ocorrencia_dia)) as Ano,
--				COUNT(oco.ocorrencia_dia) as QuantidadeAno
--			FROM oco WITH(NOLOCK)
--			GROUP BY YEAR(CONVERT(DATETIME, oco.ocorrencia_dia))
--		) as TotalAno

-- mes
--SELECT	MONTH(CONVERT(DATETIME, oco.ocorrencia_dia)) as Mes,
--		COUNT(oco.ocorrencia_dia) as QuantidadeMes
--	FROM oco WITH(NOLOCK)
--	GROUP BY MONTH(CONVERT(DATETIME, oco.ocorrencia_dia))
--	ORDER BY Mes

-- ano
--SELECT	YEAR(CONVERT(DATETIME, oco.ocorrencia_dia)) as Ano,
--		COUNT(oco.ocorrencia_dia) as QuantidadeAno
--	FROM oco WITH(NOLOCK)
--	GROUP BY YEAR(CONVERT(DATETIME, oco.ocorrencia_dia))
--	ORDER BY Ano

--	select oco.ocorrencia_dia from oco
