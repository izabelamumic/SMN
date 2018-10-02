ALTER TABLE oco
	ADD CONSTRAINT pk_codigo_ocorrencia 
	PRIMARY KEY (codigo_ocorrencia)

ALTER TABLE anv
	ADD CONSTRAINT fk_codigo_ocorrencia
	FOREIGN KEY (codigo_ocorrencia)
	REFERENCES oco(codigo_ocorrencia)

ALTER TABLE ftc
	ADD CONSTRAINT fk_ftc_codigo_ocorrencia
	FOREIGN KEY (codigo_ocorrencia)
	REFERENCES oco(codigo_ocorrencia)

ALTER TABLE rec
	ADD CONSTRAINT fk_rec_codigo_ocorrencia
	FOREIGN KEY (codigo_ocorrencia)
	REFERENCES oco(codigo_ocorrencia)
