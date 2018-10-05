/*
	18 - Levantar Média de Fatalidades por Hora (sem minutos)
*/

SELECT	DATEPART(HOUR, oco.ocorrencia_horario) as Hora,
		SUM(aer.total_fatalidades) as Fatalidade,
		CONVERT(DECIMAL(10,4),(CONVERT(DECIMAL(10,4),(SUM(aer.total_fatalidades))) / (DATEDIFF(DAY,(MIN(oco.ocorrencia_dia)),MAX(oco.ocorrencia_dia)))))  AS MediaHora
	FROM oco WITH(NOLOCK)
	INNER JOIN  anv aer	WITH(NOLOCK)
		ON oco.codigo_ocorrencia = aer.codigo_ocorrencia
	GROUP BY DATEPART(HOUR, oco.ocorrencia_horario)
	order by HORA asc 
