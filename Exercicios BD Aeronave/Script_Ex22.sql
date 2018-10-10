/*
	22 - Crie um Ranking dos UF's por quantidade de Fatalidades.
*/

-- Mostrar: Posição, UF, Quantidade de Fatalidades.
WITH cte_table AS (SELECT	ROW_NUMBER() OVER(ORDER BY SUM(aer.total_fatalidades)DESC) AS Posição, 
		oco.ocorrencia_uf AS UF,
		SUM(aer.total_fatalidades) AS QuantidadeFatalidade
	FROM oco WITH(NOLOCK)
	INNER JOIN anv aer WITH(NOLOCK)
		ON oco.codigo_ocorrencia = aer.codigo_ocorrencia
	WHERE oco.ocorrencia_uf <> ' '
	GROUP BY oco.ocorrencia_uf
	ORDER BY QuantidadeFatalidade DESC


SELECT oco.ocorrencia_uf, anv.total_fatalidades 
from anv 
inner join oco 
on oco.codigo_ocorrencia = anv.codigo_ocorrencia
WHERE oco.ocorrencia_uf = 'FB' AND ANV.total_fatalidades <> 0



	