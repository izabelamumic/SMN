/*
	19 - Levantar Fabricantes e a Primeira e �ltima Ocorr�ncia.
	Deve Retornar as seguintes informa��es para a Primeira e �ltima Ocorr�ncia:
	Tipo de Ve�culo, N�mero de Fatalidades e N�vel de Dano
*/
SELECT	PrimeiraOcorrencia.ocorrencia_dia
		aeronave_fabricante,
		UltimaOcorrencia.aeronave_fabricante,
		aer.aeronave_tipo_veiculo,
		aer.total_fatalidades,
		aer.aeronave_nivel_dano
	FROM anv aer WITH(NOLOCK)
	OUTER APPLY (
		SELECT	MIN(oco.ocorrencia_dia) AS PrimeiraOcorrencia
			FROM oco WITH(NOLOCK)
			GROUP BY MIN(oco.ocorrencia_dia)
			ORDER BY PrimeiraOcorrencia
			) PrimeiraOcorrencia
	OUTER APPLY (
		SELECT	MAX(oco.ocorrencia_dia) AS UltimaOcorrencia
			FROM oco WITH(NOLOCK)
			GROUP BY MAX(oco.ocorrencia_dia)
			ORDER BY UltimaOcorrencia
			) UltimaOcorrencia
	GROUP BY	 aer.aeronave_fabricante,aer.aeronave_tipo_veiculo, aer.total_fatalidades, aer.aeronave_nivel_dano
	


SELECT	aer.aeronave_fabricante, 
		MIN(oco.ocorrencia_dia) as PrimeiraOcorrencia,
		MAX(oco.ocorrencia_dia) as UltimaOcorrencia
	FROM oco WITH(NOLOCK)
	INNER JOIN anv aer WITH(NOLOCK)
		ON oco.codigo_ocorrencia = aer.codigo_ocorrencia
	GROUP BY	 aer.aeronave_fabricante
	ORDER BY aer.aeronave_fabricante

select oco.ocorrencia_dia, aer.aeronave_fabricante
	from  oco
	inner join anv aer
		on oco.codigo_ocorrencia = aer.codigo_ocorrencia
	order by aer.aeronave_fabricante

	----


SELECT	MIN(oco.ocorrencia_dia) as PrimeiraOcorrencia,
		aer.aeronave_fabricante, 
		aer.aeronave_tipo_veiculo, aer.total_fatalidades, aer.aeronave_nivel_dano,
		MAX(oco.ocorrencia_dia) as UltimaOcorrencia,
		aer.aeronave_fabricante, 
		aer.aeronave_tipo_veiculo, aer.total_fatalidades, aer.aeronave_nivel_dano
	FROM oco WITH(NOLOCK)
	INNER JOIN anv aer WITH(NOLOCK)
		ON oco.codigo_ocorrencia = aer.codigo_ocorrencia
	GROUP BY	 aer.aeronave_fabricante, aer.aeronave_tipo_veiculo, aer.total_fatalidades, aer.aeronave_nivel_dano
	ORDER BY aer.aeronave_fabricante

select oco.ocorrencia_dia, aer.aeronave_fabricante, aer.aeronave_tipo_veiculo, aer.total_fatalidades, aer.aeronave_nivel_dano
	from  oco
	inner join anv aer
		on oco.codigo_ocorrencia = aer.codigo_ocorrencia
	order by aer.aeronave_fabricante

