/*
	14 - Levantamento das Ocorrências por Fabricante da Aeronave por Fatalidades
*/

SELECT anv.aeronave_fabricante, SUM(anv.total_fatalidades) as Fatalidade
	FROM anv WITH(NOLOCK)
	GROUP BY anv.aeronave_fabricante
	ORDER BY Fatalidade DESC
