//SALTOS
//Example
//i=1000
//LOOP:
//if (i=0) goto CONT
//i=i-1
//goto LOOP

//i=1000
@1000
D=A
@i
M=D
(LOOP)
//if(i=0)goto CONT
@1
D=M
@CONT
D;JEQ
//i=i-1
@i
M=M-1
//goto LOOP
@LOOP
0;JMP
(CONT) 
//iDENTIFICADOR: Nombre de la variable, ejem:@i
//Dirección de Memoria: @# (Pueden ser números o variables)
//Contenido: M