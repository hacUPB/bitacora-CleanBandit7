
(LOOP)
@KBD
D=M //El valor de la tecla d es 100
@100
D=D-A 
@DRAW 
D;JEQ 
@KBD
D=M //El valor de la tecla e es 101
@101
D=D-A
@CLEAR
D;JEQ
@LOOP 
0;JMP
(DRAW)
	// put bitmap location value in R12
	// put code return address in R13
	@SCREEN
	D=A
	@R12
	AD=D+M
	// row 1
	@256 // A holds val
	D=D+A // D = addr + val
	A=D-A // A=addr + val - val = addr
	M=D-A // RAM[addr] = val
	AD=A+1 // D holds addr
	@32767
	A=!A // A holds val
	D=D+A // D = addr + val
	A=D-A // A=addr + val - val = addr
	M=D-A // RAM[addr] = val
	AD=A+1 // D holds addr
	M=1
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	// row 2
	D=A // D holds previous addr
	@17
	AD=D+A
	@30976 // A holds val
	D=D+A // D = addr + val
	A=D-A // A=addr + val - val = addr
	M=D-A // RAM[addr] = val
	AD=A+1 // D holds addr
	@15360 // A holds val
	D=D+A // D = addr + val
	A=D-A // A=addr + val - val = addr
	M=D-A // RAM[addr] = val
	AD=A+1 // D holds addr
	@3 // A holds val
	D=D+A // D = addr + val
	A=D-A // A=addr + val - val = addr
	M=D-A // RAM[addr] = val
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	// row 3
	D=A // D holds previous addr
	@17
	AD=D+A
	@1472 // A holds val
	D=D+A // D = addr + val
	A=D-A // A=addr + val - val = addr
	M=D-A // RAM[addr] = val
	AD=A+1 // D holds addr
	@24576 // A holds val
	D=D+A // D = addr + val
	A=D-A // A=addr + val - val = addr
	M=D-A // RAM[addr] = val
	AD=A+1 // D holds addr
	@12 // A holds val
	D=D+A // D = addr + val
	A=D-A // A=addr + val - val = addr
	M=D-A // RAM[addr] = val
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	// row 4
	D=A // D holds previous addr
	@17
	AD=D+A
	@6560 // A holds val
	D=D+A // D = addr + val
	A=D-A // A=addr + val - val = addr
	M=A-D // RAM[addr]=-val
	AD=A+1 // D holds addr
	@12416 // A holds val
	D=D+A // D = addr + val
	A=D-A // A=addr + val - val = addr
	M=A-D // RAM[addr]=-val
	AD=A+1 // D holds addr
	@8 // A holds val
	D=D+A // D = addr + val
	A=D-A // A=addr + val - val = addr
	M=D-A // RAM[addr] = val
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	// row 5
	D=A // D holds previous addr
	@17
	AD=D+A
	@19680 // A holds val
	D=D+A // D = addr + val
	A=D-A // A=addr + val - val = addr
	M=A-D // RAM[addr]=-val
	AD=A+1 // D holds addr
	@25215 // A holds val
	D=D+A // D = addr + val
	A=D-A // A=addr + val - val = addr
	M=A-D // RAM[addr]=-val
	AD=A+1 // D holds addr
	@9 // A holds val
	D=D+A // D = addr + val
	A=D-A // A=addr + val - val = addr
	M=D-A // RAM[addr] = val
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	// row 6
	D=A // D holds previous addr
	@17
	AD=D+A
	@12320 // A holds val
	D=D+A // D = addr + val
	A=D-A // A=addr + val - val = addr
	M=D-A // RAM[addr] = val
	AD=A+1 // D holds addr
	@13481 // A holds val
	D=D+A // D = addr + val
	A=D-A // A=addr + val - val = addr
	M=D-A // RAM[addr] = val
	AD=A+1 // D holds addr
	@24 // A holds val
	D=D+A // D = addr + val
	A=D-A // A=addr + val - val = addr
	M=D-A // RAM[addr] = val
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	// row 7
	D=A // D holds previous addr
	@17
	AD=D+A
	@11792 // A holds val
	D=D+A // D = addr + val
	A=D-A // A=addr + val - val = addr
	M=D-A // RAM[addr] = val
	AD=A+1 // D holds addr
	@2902 // A holds val
	D=D+A // D = addr + val
	A=D-A // A=addr + val - val = addr
	M=A-D // RAM[addr]=-val
	AD=A+1 // D holds addr
	@17 // A holds val
	D=D+A // D = addr + val
	A=D-A // A=addr + val - val = addr
	M=D-A // RAM[addr] = val
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	// row 8
	D=A // D holds previous addr
	@17
	AD=D+A
	@11024 // A holds val
	D=D+A // D = addr + val
	A=D-A // A=addr + val - val = addr
	M=D-A // RAM[addr] = val
	AD=A+1 // D holds addr
	@7338 // A holds val
	D=D+A // D = addr + val
	A=D-A // A=addr + val - val = addr
	M=D-A // RAM[addr] = val
	AD=A+1 // D holds addr
	@17 // A holds val
	D=D+A // D = addr + val
	A=D-A // A=addr + val - val = addr
	M=D-A // RAM[addr] = val
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	// row 9
	D=A // D holds previous addr
	@17
	AD=D+A
	@14608 // A holds val
	D=D+A // D = addr + val
	A=D-A // A=addr + val - val = addr
	M=D-A // RAM[addr] = val
	AD=A+1 // D holds addr
	@7338 // A holds val
	D=D+A // D = addr + val
	A=D-A // A=addr + val - val = addr
	M=D-A // RAM[addr] = val
	AD=A+1 // D holds addr
	@25 // A holds val
	D=D+A // D = addr + val
	A=D-A // A=addr + val - val = addr
	M=D-A // RAM[addr] = val
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	// row 10
	D=A // D holds previous addr
	@17
	AD=D+A
	@14728 // A holds val
	D=D+A // D = addr + val
	A=D-A // A=addr + val - val = addr
	M=D-A // RAM[addr] = val
	AD=A+1 // D holds addr
	@7594 // A holds val
	D=D+A // D = addr + val
	A=D-A // A=addr + val - val = addr
	M=D-A // RAM[addr] = val
	AD=A+1 // D holds addr
	@9 // A holds val
	D=D+A // D = addr + val
	A=D-A // A=addr + val - val = addr
	M=D-A // RAM[addr] = val
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	// row 11
	D=A // D holds previous addr
	@17
	AD=D+A
	@14472 // A holds val
	D=D+A // D = addr + val
	A=D-A // A=addr + val - val = addr
	M=D-A // RAM[addr] = val
	AD=A+1 // D holds addr
	@299 // A holds val
	D=D+A // D = addr + val
	A=D-A // A=addr + val - val = addr
	M=D-A // RAM[addr] = val
	AD=A+1 // D holds addr
	@25 // A holds val
	D=D+A // D = addr + val
	A=D-A // A=addr + val - val = addr
	M=D-A // RAM[addr] = val
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	// row 12
	D=A // D holds previous addr
	@17
	AD=D+A
	@14732 // A holds val
	D=D+A // D = addr + val
	A=D-A // A=addr + val - val = addr
	M=D-A // RAM[addr] = val
	AD=A+1 // D holds addr
	@365 // A holds val
	D=D+A // D = addr + val
	A=D-A // A=addr + val - val = addr
	M=D-A // RAM[addr] = val
	AD=A+1 // D holds addr
	@49 // A holds val
	D=D+A // D = addr + val
	A=D-A // A=addr + val - val = addr
	M=D-A // RAM[addr] = val
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	// row 13
	D=A // D holds previous addr
	@17
	AD=D+A
	@31996 // A holds val
	D=D+A // D = addr + val
	A=D-A // A=addr + val - val = addr
	M=A-D // RAM[addr]=-val
	AD=A+1 // D holds addr
	@837 // A holds val
	D=D+A // D = addr + val
	A=D-A // A=addr + val - val = addr
	M=D-A // RAM[addr] = val
	AD=A+1 // D holds addr
	@33 // A holds val
	D=D+A // D = addr + val
	A=D-A // A=addr + val - val = addr
	M=D-A // RAM[addr] = val
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	// row 14
	D=A // D holds previous addr
	@17
	AD=D+A
	@32356 // A holds val
	D=D+A // D = addr + val
	A=D-A // A=addr + val - val = addr
	M=D-A // RAM[addr] = val
	AD=A+1 // D holds addr
	@8506 // A holds val
	D=D+A // D = addr + val
	A=D-A // A=addr + val - val = addr
	M=A-D // RAM[addr]=-val
	AD=A+1 // D holds addr
	@33 // A holds val
	D=D+A // D = addr + val
	A=D-A // A=addr + val - val = addr
	M=D-A // RAM[addr] = val
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	// row 15
	D=A // D holds previous addr
	@17
	AD=D+A
	@198 // A holds val
	D=D+A // D = addr + val
	A=D-A // A=addr + val - val = addr
	M=D-A // RAM[addr] = val
	AD=A+1 // D holds addr
	@28672 // A holds val
	D=D+A // D = addr + val
	A=D-A // A=addr + val - val = addr
	M=D-A // RAM[addr] = val
	AD=A+1 // D holds addr
	@102 // A holds val
	D=D+A // D = addr + val
	A=D-A // A=addr + val - val = addr
	M=D-A // RAM[addr] = val
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	// row 16
	D=A // D holds previous addr
	@17
	AD=D+A
	@24702 // A holds val
	D=D+A // D = addr + val
	A=D-A // A=addr + val - val = addr
	M=A-D // RAM[addr]=-val
	AD=A+1 // D holds addr
	@193 // A holds val
	D=D+A // D = addr + val
	A=D-A // A=addr + val - val = addr
	M=D-A // RAM[addr] = val
	AD=A+1 // D holds addr
	@67 // A holds val
	D=D+A // D = addr + val
	A=D-A // A=addr + val - val = addr
	M=D-A // RAM[addr] = val
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	// row 17
	D=A // D holds previous addr
	@17
	AD=D+A
	@2 // A holds val
	D=D+A // D = addr + val
	A=D-A // A=addr + val - val = addr
	M=D-A // RAM[addr] = val
	AD=A+1 // D holds addr
	@3997 // A holds val
	D=D+A // D = addr + val
	A=D-A // A=addr + val - val = addr
	M=A-D // RAM[addr]=-val
	AD=A+1 // D holds addr
	@65 // A holds val
	D=D+A // D = addr + val
	A=D-A // A=addr + val - val = addr
	M=D-A // RAM[addr] = val
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	// row 18
	D=A // D holds previous addr
	@17
	AD=D+A
	@338 // A holds val
	D=D+A // D = addr + val
	A=D-A // A=addr + val - val = addr
	M=D-A // RAM[addr] = val
	AD=A+1 // D holds addr
	@34 // A holds val
	D=D+A // D = addr + val
	A=D-A // A=addr + val - val = addr
	M=D-A // RAM[addr] = val
	AD=A+1 // D holds addr
	@64 // A holds val
	D=D+A // D = addr + val
	A=D-A // A=addr + val - val = addr
	M=D-A // RAM[addr] = val
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	// row 19
	D=A // D holds previous addr
	@17
	AD=D+A
	@339 // A holds val
	D=D+A // D = addr + val
	A=D-A // A=addr + val - val = addr
	M=D-A // RAM[addr] = val
	AD=A+1
 AD=A+1 // D holds addr
	@85 // A holds val
	D=D+A // D = addr + val
	A=D-A // A=addr + val - val = addr
	M=D-A // RAM[addr] = val
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	// row 20
	D=A // D holds previous addr
	@17
	AD=D+A
	@337 // A holds val
	D=D+A // D = addr + val
	A=D-A // A=addr + val - val = addr
	M=D-A // RAM[addr] = val
	AD=A+1
 AD=A+1 // D holds addr
	@85 // A holds val
	D=D+A // D = addr + val
	A=D-A // A=addr + val - val = addr
	M=D-A // RAM[addr] = val
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	// row 21
	D=A // D holds previous addr
	@17
	AD=D+A
	@273 // A holds val
	D=D+A // D = addr + val
	A=D-A // A=addr + val - val = addr
	M=D-A // RAM[addr] = val
	AD=A+1
 AD=A+1 // D holds addr
	@81 // A holds val
	D=D+A // D = addr + val
	A=D-A // A=addr + val - val = addr
	M=D-A // RAM[addr] = val
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	// row 22
	D=A // D holds previous addr
	@17
	AD=D+A
	@16383 // A holds val
	D=D+A // D = addr + val
	A=D-A // A=addr + val - val = addr
	M=A-D // RAM[addr]=-val
	AD=A+1 // D holds addr
	@7281 // A holds val
	D=D+A // D = addr + val
	A=D-A // A=addr + val - val = addr
	M=D-A // RAM[addr] = val
	AD=A+1 // D holds addr
	@64 // A holds val
	D=D+A // D = addr + val
	A=D-A // A=addr + val - val = addr
	M=D-A // RAM[addr] = val
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	// row 23
	D=A // D holds previous addr
	@17
	AD=D+A
	@32257 // A holds val
	D=D+A // D = addr + val
	A=D-A // A=addr + val - val = addr
	M=D-A // RAM[addr] = val
	AD=A+1 // D holds addr
	@13915 // A holds val
	D=D+A // D = addr + val
	A=D-A // A=addr + val - val = addr
	M=D-A // RAM[addr] = val
	AD=A+1 // D holds addr
	@64 // A holds val
	D=D+A // D = addr + val
	A=D-A // A=addr + val - val = addr
	M=D-A // RAM[addr] = val
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	// row 24
	D=A // D holds previous addr
	@17
	AD=D+A
	@6913 // A holds val
	D=D+A // D = addr + val
	A=D-A // A=addr + val - val = addr
	M=D-A // RAM[addr] = val
	AD=A+1 // D holds addr
	@7794 // A holds val
	D=D+A // D = addr + val
	A=D-A // A=addr + val - val = addr
	M=A-D // RAM[addr]=-val
	AD=A+1 // D holds addr
	@64 // A holds val
	D=D+A // D = addr + val
	A=D-A // A=addr + val - val = addr
	M=D-A // RAM[addr] = val
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	// row 25
	D=A // D holds previous addr
	@17
	AD=D+A
	@385 // A holds val
	D=D+A // D = addr + val
	A=D-A // A=addr + val - val = addr
	M=D-A // RAM[addr] = val
	AD=A+1 // D holds addr
	@32767
	A=!A // A holds val
	D=D+A // D = addr + val
	A=D-A // A=addr + val - val = addr
	M=D-A // RAM[addr] = val
	AD=A+1 // D holds addr
	@65 // A holds val
	D=D+A // D = addr + val
	A=D-A // A=addr + val - val = addr
	M=D-A // RAM[addr] = val
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	// row 26
	D=A // D holds previous addr
	@17
	AD=D+A
	@129 // A holds val
	D=D+A // D = addr + val
	A=D-A // A=addr + val - val = addr
	M=D-A // RAM[addr] = val
	AD=A+1
 AD=A+1 // D holds addr
	@65 // A holds val
	D=D+A // D = addr + val
	A=D-A // A=addr + val - val = addr
	M=D-A // RAM[addr] = val
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	// row 27
	D=A // D holds previous addr
	@17
	AD=D+A
	M=1
	AD=A+1
 AD=A+1 // D holds addr
	@64 // A holds val
	D=D+A // D = addr + val
	A=D-A // A=addr + val - val = addr
	M=D-A // RAM[addr] = val
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	// row 28
	D=A // D holds previous addr
	@17
	AD=D+A
	M=1
	AD=A+1
 AD=A+1 // D holds addr
	@32 // A holds val
	D=D+A // D = addr + val
	A=D-A // A=addr + val - val = addr
	M=D-A // RAM[addr] = val
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	// row 29
	D=A // D holds previous addr
	@17
	AD=D+A
	@3 // A holds val
	D=D+A // D = addr + val
	A=D-A // A=addr + val - val = addr
	M=D-A // RAM[addr] = val
	AD=A+1
 AD=A+1 // D holds addr
	@60 // A holds val
	D=D+A // D = addr + val
	A=D-A // A=addr + val - val = addr
	M=D-A // RAM[addr] = val
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	// row 30
	D=A // D holds previous addr
	@17
	AD=D+A
	@1022 // A holds val
	D=D+A // D = addr + val
	A=D-A // A=addr + val - val = addr
	M=D-A // RAM[addr] = val
	AD=A+1 // D holds addr
	@32767
	A=!A // A holds val
	D=D+A // D = addr + val
	A=D-A // A=addr + val - val = addr
	M=D-A // RAM[addr] = val
	AD=A+1 // D holds addr
	@7 // A holds val
	D=D+A // D = addr + val
	A=D-A // A=addr + val - val = addr
	M=D-A // RAM[addr] = val
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	// row 31
	D=A // D holds previous addr
	@17
	AD=D+A
	@512 // A holds val
	D=D+A // D = addr + val
	A=D-A // A=addr + val - val = addr
	M=A-D // RAM[addr]=-val
	AD=A+1 // D holds addr
	M=-1
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	// row 32
	D=A // D holds previous addr
	@19
	AD=D+A
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	AD=A+1 // D holds addr
	M=0
	@LOOP
    0;JMP   // Salta Nuevamente a LOOP

(CLEAR)
@SCREEN
D=A
@R0
M=D        // R0 = dirección actual en pantalla

// Inicializar contador de 8192
@8192
D=A
@R1
M=D        // R1 = contador

(CLEAR_LOOP)
    @R1
    D=M
    @END_CLEAR
    D;JEQ   // Si el contador llega a 0, terminar

    @R0
    A=M
    M=0     // Borrar pixel (poner en 0)

    @R0
    M=M+1   // Avanzar una palabra de 16 bits
    @R1
    M=M-1   // Disminuir contador
    @CLEAR_LOOP
    0;JMP   // Repetir
	@LOOP
    0;JMP   // Salta nuevamente al LOOP