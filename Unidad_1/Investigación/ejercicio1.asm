//RAM [100]>RAM[200]
@200
D=M
@100
M=D
//Restarle a la posición 3 15
@15
D=A 
@3
M=M-D 

//RAM[2]=RAM[0]+RAM[1]+17

@0
D=M 
@1
D=D+M
@17
D=D+A
@2
M=D 

