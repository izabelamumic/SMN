/*
	07 - Levantamento das ocoorrências por UF
	O levantamento deve conter a primeira e a última ocoorrência de cada classificação por UF.
*/

SELECT  oco.ocorrencia_uf,
        MIN(CASE
            WHEN  oco.ocorrencia_classificacao = 'ACIDENTE'
                THEN CONVERT(DATE, oco.ocorrencia_dia)
        END) AS primeiro_acidente, 
        MAX(CASE
            WHEN  oco.ocorrencia_classificacao = 'ACIDENTE'
                THEN CONVERT(DATE, oco.ocorrencia_dia)
        END) AS ultimo_acidente,
        MIN(CASE
            WHEN  oco.ocorrencia_classificacao = 'INCIDENTE'
                THEN CONVERT(DATE, oco.ocorrencia_dia)
        END) AS primeiro_incidente, 
        MAX(CASE
            WHEN  oco.ocorrencia_classificacao = 'INCIDENTE'
                THEN CONVERT(DATE, oco.ocorrencia_dia)
        END) AS ultimo_incidente,
        MIN(CASE
            WHEN  oco.ocorrencia_classificacao = 'INCIDENTE GRAVE'
                THEN CONVERT(DATE, oco.ocorrencia_dia)
        END) AS primeiro_grave, 
        MAX(CASE
            WHEN  oco.ocorrencia_classificacao = 'INCIDENTE GRAVE'
                THEN CONVERT(DATE, oco.ocorrencia_dia)
        END) AS ultimo_grave
            
    FROM oco WITH(NOLOCK)
    GROUP BY oco.ocorrencia_uf
    ORDER BY oco.ocorrencia_uf