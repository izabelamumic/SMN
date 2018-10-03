declare @mediaAno int,
		@janeiro int, @fevereiro int, @marco int, @abril int, @maio int, @junho int,
		@julho int, @agosto int,  @setembro int, @outubro int, @novembro int, @dezembro int 

SELECT	@mediaAno = AVG(total.MediaAno),
		@janeiro = AVG(total.Janeiro), 
		@fevereiro = AVG(total.Fevereiro),
		@marco = AVG(total.Marco),	  
		@abril = AVG(total.Abril),
		@maio = AVG(total.Maio),
		@junho = AVG(total.Julho),
		@julho = AVG(total.Julho),
		@agosto = AVG(total.Agosto),
		@setembro = AVG(total.Setembro),
		@outubro = AVG(total.Outubro),
		@novembro = AVG(total.Novembro),
		@dezembro = AVG(total.Dezembro)
		FROM  (SELECT
					YEAR(CONVERT(DATETIME, oco.ocorrencia_dia)) AS Ano,
					COUNT (CASE	
								WHEN year(CONVERT(DATETIME, oco.ocorrencia_dia)) = 2008
									THEN 1
							END
							) AS MediaAno,
					COUNT (CASE 
								WHEN MONTH(CONVERT(DATETIME, oco.ocorrencia_dia)) = 01
									THEN 1
							END 
							) AS Janeiro,

					COUNT (CASE 
								WHEN MONTH(CONVERT(DATETIME, oco.ocorrencia_dia)) = 02
									THEN 1
							END 
							) AS Fevereiro,
					
					COUNT(
							CASE 
								WHEN MONTH(CONVERT(DATETIME, oco.ocorrencia_dia)) = 03
								THEN 1
							END 
							)  AS Marco,
					
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
							)  AS Dezembro
		
				FROM oco WITH(NOLOCK)
				GROUP BY YEAR(CONVERT(DATETIME, oco.ocorrencia_dia))
				--ORDER BY Ano
			) AS total

		
		
SELECT	YEAR(CONVERT(DATETIME, oco.ocorrencia_dia)) as Ano, 
		@mediaAno as MediaAno,
		@janeiro AS MediaJaneiro,
		@fevereiro AS MediaFevereiro,
		@marco AS MediaMarco,
		@abril AS MediaAbril,
		@maio AS MediaMaio,
		@junho AS MediaJunho,
		@julho AS MediaJulho,
		@agosto AS MediaAgosto,
		@setembro AS MediaSetembro,
		@outubro AS MediaOutubro,
		@novembro AS MediaNovembro,
		@dezembro AS MediaDezembro 
	FROM oco WITH(NOLOCK)
	 GROUP BY YEAR(CONVERT(DATETIME, oco.ocorrencia_dia))
	 order by Ano