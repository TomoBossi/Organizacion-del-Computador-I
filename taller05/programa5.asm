SET R0, rai
STR [0x00], R0
SET R1, 0x02 ; bocina
STR [0xF1], R1
SET R2, 0x00 ; curvas atravesadas
SET R3, 0x0F ; velocidad inicial
SET R4, 0x0F ; velocidad maxima
SET R6, 0x0C ; velocidad minima
SET R7, 0x02 ; superada
SET R5, 0x20 ; 32

STI


loop:
	STR [0xF0], R3
	JMP loop


rai:
	CMP R3, R4 ; ¿Hay una curva cerca?
	JZ curva_cerca

	SET R3, 0x0F

	INC R2
	CMP R2, R5
	JZ treintaydos
	JMP fin_rai

	treintaydos:
		SET R2, 0x00
		INC R1
		STR [0xF1], R1
		JMP fin_rai

	curva_cerca:
		SET R3, 0x0C

	fin_rai:
		IRET
