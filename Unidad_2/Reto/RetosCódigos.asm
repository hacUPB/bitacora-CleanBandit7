// RETO 01

@i 
M=1
@sum
M=0

(LOOP) 

@i 
D=M
@100
D=D-A
@END
D;JGT

@sum 
D=M
@i 
D=D+M
@sum
M=D 

@i 
M=M+1

@LOOP
0;JMP

(END)

// RETO 02

int sum = 0;
for (int i = 1; i <= 100; i++) {
   sum += i;
}

// RETO 03

@i
M=1         

@sum
M=0         

(LOOP)
@i
D=M
@100
D=D-A
@END
D;JGT       

@sum
D=M
@i
D=D+M
@sum
M=D       

@i
M=M+1       

@LOOP
0;JMP        

(END)

// RETO 05

@10 
D=A 
@a  
M=D 
D=A 
@p 
M=D 
@20 
D=A 
@p 
A=M 
M=D 

// RETO 07

@10
D=A 
@var
M=D

@5
D=A 
@bis
M=D

@var
D=A 
@p_var
M=D

@p_var
A=M
D=M 
@bis 
M=D



// RETO 09


@6         
D=A
@16        
M=D

@9         
D=A
@17        
M=D


@RETURN    
D=A
@21       
M=D

@SUMA     
0;JMP

(RETURN)   


@18
D=M
@19
M=D


(END)
@END
0;JMP


(SUMA)

@16        
D=M
@17        
D=D+M
@18        
M=D

@21
A=M
0;JMP