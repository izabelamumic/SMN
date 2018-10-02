/*
	18 - Levantar Média de Fatalidades por Hora (sem minutos)
*/
-- REFAZER
SELECT  AVG(Resultado.TotalFatalidade) as MediaPorHora
	FROM (SELECT
				DATEPART(HH, oco.ocorrencia_horario) as Hora ,
				COUNT(DATEPART(HH, oco.ocorrencia_horario)) as TotalFatalidade
			FROM  oco WITH(NOLOCK) 
			GROUP BY DATEPART(HH, oco.ocorrencia_horario) 
		) as Resultado

		0411133905300
		0411143730300