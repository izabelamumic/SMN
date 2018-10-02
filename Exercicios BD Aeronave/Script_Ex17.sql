/*
	17 - Levantar Média de Ocorrências por Mês e Ano
*/
-- REFAZER
SELECT  AVG(TotalMes.QuantidadeMes) as MediaMes,
		AVG(TotalAno.QuantidadeAno) as MediaAno
	FROM (SELECT
				MONTH(CONVERT(DATETIME, oco.ocorrencia_dia)) as Mes,
				COUNT(oco.ocorrencia_dia) as QuantidadeMes
			FROM oco WITH(NOLOCK)
			GROUP BY MONTH(CONVERT(DATETIME, oco.ocorrencia_dia))
		) as TotalMes,

		(SELECT
				YEAR(CONVERT(DATETIME, oco.ocorrencia_dia)) as Ano,
				COUNT(oco.ocorrencia_dia) as QuantidadeAno
			FROM oco WITH(NOLOCK)
			GROUP BY YEAR(CONVERT(DATETIME, oco.ocorrencia_dia))
		) as TotalAno

-- mes
SELECT	MONTH(CONVERT(DATETIME, oco.ocorrencia_dia)) as Mes,
		COUNT(oco.ocorrencia_dia) as QuantidadeMes
	FROM oco WITH(NOLOCK)
	GROUP BY MONTH(CONVERT(DATETIME, oco.ocorrencia_dia))
	ORDER BY Mes

-- ano
SELECT	YEAR(CONVERT(DATETIME, oco.ocorrencia_dia)) as Ano,
		COUNT(oco.ocorrencia_dia) as QuantidadeAno
	FROM oco WITH(NOLOCK)
	GROUP BY YEAR(CONVERT(DATETIME, oco.ocorrencia_dia))
	ORDER BY Ano

	select oco.ocorrencia_dia from oco