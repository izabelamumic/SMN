/*
	21 - Levantar o primeiro incidente de cada hora do dia que houve mais incidente.
*/

SELECT  CONCAT(dia.Dia, '  -  ', ocorrencia.hora, 'h') AS Data_Hora,
		ocorrencia.Qtdhora AS Quantidade, 
		ocorrencia.ocorrencia_tipo AS 'Tipo_Ocorrencia'
	FROM (SELECT	top(1)	oco.ocorrencia_dia as Dia,
					COUNT(oco.codigo_ocorrencia) AS quantidade
		FROM oco WITH(NOLOCK)
		WHERE oco.ocorrencia_classificacao = 'INCIDENTE'
		GROUP BY oco.ocorrencia_dia
		ORDER BY quantidade desc
	) AS dia		
		
	CROSS APPLY(
	SELECT	oco.ocorrencia_tipo,
			DATEPART(HOUR,oco.ocorrencia_horario) AS hora,
			oco.ocorrencia_dia AS diaOco, 
			COUNT(DATEPART(HOUR,oco.ocorrencia_horario)) AS Qtdhora
		FROM oco with(nolock)
		WHERE oco.ocorrencia_dia = dia.Dia 
		AND oco.ocorrencia_classificacao = 'INCIDENTE'
		GROUP BY  oco.ocorrencia_tipo, DATEPART(HOUR,oco.ocorrencia_horario), oco.ocorrencia_dia
	)ocorrencia

	ORDER BY hora

