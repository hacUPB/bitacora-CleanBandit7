### RETOS

##Reto1

//Carga en D el valor 1978.

@1978
D=A

##Reto2

//Guarda en la posición 100 de la RAM el número 69.

@69
D=A
@100
M=D

##Reto3

//Guarda en la posición 200 de la RAM el contenido de la posición 24 de la RAM

@24
D=M
@200
M=D

##Reto4

//Lee lo que hay en la posición 100 de la RAM, resta 15 y guarda el resultado en la posición 100 de la RAM.

@15
D=A
@100
M=M-D

## Reto 5

//Suma el contenido de la posición 0 de la RAM, el contenido de la posición 1 de la RAM y con la constante 69. Guarda el resultado en la posición 2 de la RAM.

@0  //Vamos a la posición 0
D=M //Guardamos el contenido de la posición 0 en D
@1  //Vamos a la posición 1
D=D+M //Guardamos en D el valor de la suma entre el valor que habíamos registrado antes ahí y que era el contenido de la posición 0 con el valor del contenido de la posición 1.

@69 //Vamos a la posición 69
D=D+A //Guardamos en D el valor de la suma entre el valor que habíamos registrado antes ahí y que era producto de la suma anterior con el valor de la posición actual, es decir, con el 69.

@2 //Vamos a la posición 2
M=D //Guardamos en el contenido de la posición 2 el resultado de las sumas hechas antes.

##Reto6

//Si el valor almacenado en D es igual a 0 salta a la posición 100 de la ROM.

@100
D;JEQ

##Reto7

//Si el valor almacenado en la posición 100 de la RAM es menor a 100 salta a la posición 20 de la ROM.
//Como tal, no se puede pedir un salto comparando directamente M con un valor de constante, hay que restarlo con el valor que me piden compararlo primero y si eso da menos que 0, ahí si se podría dar el comando de saltar.

@100
D=M
D=D-A //Se resta el valor contenido en la posición 100 con el número 100.

//if(D<100) goto 20

@20
D;JLT

##Reto8

//Considera el siguiente programa:

//¿Qué hace este programa?

@var1 //En este programa primero, nos ubicamos en la posición 16, llamada como la var1.
D = M //Luego guardamos en D el contenido de esta variable
@var2 //Luego vamos a la posición 17, la var2
D = D + M //Luego registramos en D la suma entre el contenido de la var1 con el contenido de la var2.

@var3 //Luego vamos a la posición 18, la var3
M = D //Luego en el contenido de esta variable registramos el valor del resultado de la suma de antes.

//¿En qué posición de la memoria está var1, var2 y var3? ¿Por qué en esas posiciones?

//En las posiciones 16, 17 y 18 ya que cuando se registra una variable no numérica en A al enunciarla con @, el sistema lo toma automáticamente como si estuviera en la casilla 16 y a partir de ahí, las demás variables alfabéticas que se registren van a ser los numeros sucedientes al 16.

##Reto9

//Considera el siguiente programa:

i = 1
sum = 0
sum = sum + i
i = i + 1

//La traducción a lenguaje ensamblador del programa anterior es:

//¿Qué hace este programa?

// i = 1
@i//Nos ubicamos en la posición 16, en la variable i
M=1//Asignamos el valor 1 a la variable i
// sum = 0
@sum//Nos ubicamos en la posición 17, en la variable sum
M=0//Le asignamos el valor 0 a la variable sum
// sum = sum + i
@i//Nos ubicamos en la variable i nuevamente
D=M//Copiamos el valor de i en D, es decir 1
@sum//Nos ubicamos en la variable sum
M=D+M//Al valor de la variable sum le vamos a asignar el resultado entre la suma del valor copiado en D y el valor actual de la variable sum
// i = i + 1
@i//Nos ubicamos en la variable i nuevamente
D=M+1//A D le asignamos el resultado de la suma entre el valor actual de i, es decir 1 con la constante 1
@i//Nos ubicamos en la variable i
M=D//Asignamos a la variable i el resultado de la suma anterior, es decir, el valor copiado en D.

//¿En qué parte de la memoria RAM está la variable i y sum? ¿Por qué en esas posiciones?

//RTA: La variable i está ubicada en la posición 16 y sum en la posición 17, ya que al ser variables no numéricas, se les asigna automáticamente espacios a partir de la posición 16 en adelante.

//Optimiza esta parte del código para que use solo dos instrucciones:

// i = i + 1
@i
D=M+1
@i
M=D

//Optimizado quedaría:

@i
M=M+1

##Reto10

//Las posiciones de memoria RAM de 0 a 15 tienen los nombres simbólico "R0" a "R15". Escribe un programa en lenguaje ensamblador que guarde en "R1" la operación 2*R0.

@R1 
M=A
M=M+1 
@R0 
D=M
@R1 
M=M*D

##Reto11

//Considera el siguiente programa:

i = 1000
LOOP:
if (i == 0) goto CONT
i = i - 1
goto LOOP
CONT:

//La traducción a lenguaje ensamblador del programa anterior es:

// i = 1000
@1000
D=A
@i
M=D
(LOOP)
// if (i == 0) goto CONT
@i
D=M
@CONT
D;JEQ
// i = i - 1
@i
M=M-1
// goto LOOP
@LOOP
0;JMP
(CONT)

//¿Qué hace este programa?

//RTA: Este programa cuenta hacia atrás desde i = 1000 hasta i = 0. 
//Específicamente:

//- Inicializa i con 1000.

//- Luego entra a un bucle (LOOP) donde:

//- Si i es igual a 0, salta a la etiqueta CONT (termina el bucle).

//- Si no, decrementa i en 1 y vuelve al inicio del bucle.

//- Repite hasta que i == 0.



//¿En qué memoria está almacenada la variable i? ¿En qué dirección de esa memoria?

//RTA: La variable i queda almacenada en la memoria RAAM, más específicamente en la dirección 16.



//¿En qué memoria y en qué dirección de memoria está almacenado el comentario i = 1000?

//RTA:Los comentarios (como // i = 1000) no se almacenan en la memoria del computador. Son solo para el programador y no tienen ninguna representación en el código binario ni en la memoria.



//¿Cuál es la primera instrucción del programa anterior? ¿En qué memoria y en qué dirección de memoria está almacenada esa instrucción?

//RTA: La primera instrucción es @1000, la memoria es la memoria ROM y la dirección de la memoria sería 0.



//¿Qué son CONT y LOOP?

//RTA: (CONT) y (LOOP) son etiquetas o símbolos de salto. Sirven para marcar direcciones específicas del programa a las que se puede saltar con instrucciones como @LOOP o @CONT. Cuando el ensamblador encuentra (LOOP), asigna esa etiqueta a la dirección ROM actual.



//¿Cuál es la diferencia entre los símbolos i y CONT?

//RTA: i es una variable, que representa una posición en la RAM donde se guarda un valor. CONT es una etiqueta, que representa una posición en la ROM (es decir, una dirección de instrucción en el programa).


##Reto12

//Implementa en ensamblador

R4 = R1 + R2 + 69

//Solución:

@1      // Dirección de R1
D=M     // D = R1

@2      // Dirección de R2
D=D+M   // D = R1 + R2

@69
D=D+A   // D = R1 + R2 + 69

@4      // Dirección de R4
M=D     // R4 = D

##Reto13

//Implementa en ensamblador

@0        // R0
D=M       // D = R0

@POS      // Si R0 >= 0, salta a POS
D;JGE     

@1        // ELSE: R1 = -1
M=-1
@AFTER
0;JMP

(POS)     // THEN: R1 = 1
@1
M=1

(AFTER)
(LOOP)
@LOOP
0;JMP

##Reto14

R4 = RAM[R1]

//Implementa en ensamblador:

@1      // Dirección de R1
A=M     // A = RAM[R1] → saltamos a la dirección contenida en R1
D=M     // D = RAM[ RAM[R1] ] → obtenemos el valor de esa dirección

@4      // Dirección de R4
M=D     // R4 = valor leído

##Reto15

//Implementa en ensamblador el siguiente problema. En la posición R0 está almacenada la dirección inicial de una región de memoria. En la posición R1 está almacenado el tamaño de la región de memoria. Almacena un -1 en esa región de memoria:

// Inicializar punteros
@0
D=M         // D = R0 (inicio)
@ptr
M=D         // ptr = R0

@1
D=M         // D = R1 (tamaño)
@count
M=D         // count = R1

(LOOP)
@count
D=M
@END
D;JEQ       // Si count == 0, termina

// RAM[ptr] = -1
@ptr
A=M         // A = ptr (dirección actual)
M=-1        // Guardar -1 en RAM[ptr]

// ptr = ptr + 1
@ptr
M=M+1

// count = count - 1
@count
M=M-1

@LOOP
0;JMP       // Repetir

(END)

##Reto16

int[] arr = new int[10];
int sum = 0;
for (int j = 0; j < 10; j++) {
    sum = sum + arr[j];
}

//Implementa en lenguaje ensamblador el siguiente problema:

// Inicializar sum = 0
@0
D=A
@30      // sum
M=D

// Inicializar j = 0
@0
D=A
@31      // j
M=D

(LOOP)
@31
D=M       // D = j
@10
D=D-A     // D = j - 10
@END
D;JGE     // if j >= 10, saltar al final

// sum = sum + arr[j]

// 1. Obtener arr[j]
@31
D=M       // D = j
@20
A=D+A     // A = 20 + j
D=M       // D = arr[j]

// 2. Agregarlo a sum
@30
M=D+M     // sum += arr[j]

// j = j + 1
@31
M=M+1

@LOOP
0;JMP

(END)

//¿Qué hace este programa?

//RTA: Suma los 10 valores almacenados en el arreglo arr[10] y guarda el resultado en la variable sum.



//¿Cuál es la dirección base de arr en la memoria RAM?

//RTA: El arreglo arr está almacenado a partir de RAM[20] (esto lo elegimos para esta implementación). Las siguientes 10 posiciones (RAM[20] hasta RAM[29]) corresponden a arr[0] hasta arr[9].




//¿Cuál es la dirección base de sum en la memoria RAM y por qué?

//RTA: sum está en RAM[30]. Elegimos esta dirección por claridad y para no mezclarla con las posiciones del arreglo ni con variables temporales del sistema.



//¿Cuál es la posición base de j en la memoria RAM y por qué?

//RTA: j está en RAM[31]. Es una posición libre después del arreglo (RAM[20]–[29]) y después de sum, ideal para una variable de control como el índice del ciclo for



##Reto17

if ( (D - 7) == 0) goto a la instrucción en ROM[69]

//Implementa en lenguaje ensamblador

@7
D=D-A      // Resta 7 a D

@69
D;JEQ      // Si D era 7, ahora D == 0 → salta a ROM[69]


##Reto18

//Utiliza esta herramienta (https://nand2tetris.github.io/web-ide/bitmap) para dibujar un bitmap en la pantalla.

function void draw(int location) {
	var int memAddress; 
	let memAddress = 16384+location;
	// column 0
	do Memory.poke(memAddress, 256);
	do Memory.poke(memAddress +32, 30976);
	do Memory.poke(memAddress +64, 1472);
	do Memory.poke(memAddress +96, -6560);
	do Memory.poke(memAddress +128, -19680);
	do Memory.poke(memAddress +160, 12320);
	do Memory.poke(memAddress +192, 11792);
	do Memory.poke(memAddress +224, 11024);
	do Memory.poke(memAddress +256, 14608);
	do Memory.poke(memAddress +288, 14728);
	do Memory.poke(memAddress +320, 14472);
	do Memory.poke(memAddress +352, 14732);
	do Memory.poke(memAddress +384, -31996);
	do Memory.poke(memAddress +416, 32356);
	do Memory.poke(memAddress +448, 198);
	do Memory.poke(memAddress +480, -24702);
	do Memory.poke(memAddress +512, 2);
	do Memory.poke(memAddress +544, 338);
	do Memory.poke(memAddress +576, 339);
	do Memory.poke(memAddress +608, 337);
	do Memory.poke(memAddress +640, 273);
	do Memory.poke(memAddress +672, -16383);
	do Memory.poke(memAddress +704, 32257);
	do Memory.poke(memAddress +736, 6913);
	do Memory.poke(memAddress +768, 385);
	do Memory.poke(memAddress +800, 129);
	do Memory.poke(memAddress +832, 1);
	do Memory.poke(memAddress +864, 1);
	do Memory.poke(memAddress +896, 3);
	do Memory.poke(memAddress +928, 1022);
	do Memory.poke(memAddress +960, -512);
	// column 1
	do Memory.poke(memAddress +1, ~32767);
	do Memory.poke(memAddress +33, 15360);
	do Memory.poke(memAddress +65, 24576);
	do Memory.poke(memAddress +97, -12416);
	do Memory.poke(memAddress +129, -25215);
	do Memory.poke(memAddress +161, 13481);
	do Memory.poke(memAddress +193, -2902);
	do Memory.poke(memAddress +225, 7338);
	do Memory.poke(memAddress +257, 7338);
	do Memory.poke(memAddress +289, 7594);
	do Memory.poke(memAddress +321, 299);
	do Memory.poke(memAddress +353, 365);
	do Memory.poke(memAddress +385, 837);
	do Memory.poke(memAddress +417, -8506);
	do Memory.poke(memAddress +449, 28672);
	do Memory.poke(memAddress +481, 193);
	do Memory.poke(memAddress +513, -3997);
	do Memory.poke(memAddress +545, 34);
	do Memory.poke(memAddress +673, 7281);
	do Memory.poke(memAddress +705, 13915);
	do Memory.poke(memAddress +737, -7794);
	do Memory.poke(memAddress +769, ~32767);
	do Memory.poke(memAddress +929, ~32767);
	do Memory.poke(memAddress +961, -1);
	// column 2
	do Memory.poke(memAddress +2, 1);
	do Memory.poke(memAddress +34, 3);
	do Memory.poke(memAddress +66, 12);
	do Memory.poke(memAddress +98, 8);
	do Memory.poke(memAddress +130, 9);
	do Memory.poke(memAddress +162, 24);
	do Memory.poke(memAddress +194, 17);
	do Memory.poke(memAddress +226, 17);
	do Memory.poke(memAddress +258, 25);
	do Memory.poke(memAddress +290, 9);
	do Memory.poke(memAddress +322, 25);
	do Memory.poke(memAddress +354, 49);
	do Memory.poke(memAddress +386, 33);
	do Memory.poke(memAddress +418, 33);
	do Memory.poke(memAddress +450, 102);
	do Memory.poke(memAddress +482, 67);
	do Memory.poke(memAddress +514, 65);
	do Memory.poke(memAddress +546, 64);
	do Memory.poke(memAddress +578, 85);
	do Memory.poke(memAddress +610, 85);
	do Memory.poke(memAddress +642, 81);
	do Memory.poke(memAddress +674, 64);
	do Memory.poke(memAddress +706, 64);
	do Memory.poke(memAddress +738, 64);
	do Memory.poke(memAddress +770, 65);
	do Memory.poke(memAddress +802, 65);
	do Memory.poke(memAddress +834, 64);
	do Memory.poke(memAddress +866, 32);
	do Memory.poke(memAddress +898, 60);
	do Memory.poke(memAddress +930, 7);
	return;
}

##Reto 19

//Analiza el siguiente programa en lenguaje de máquina:

0100000000000000
1110110000010000
0000000000010000
1110001100001000
0110000000000000
1111110000010000
0000000000010011
1110001100000101
0000000000010000
1111110000010000
0100000000000000
1110010011010000
0000000000000100
1110001100000110
0000000000010000
1111110010101000
1110101010001000
0000000000000100
1110101010000111
0000000000010000
1111110000010000
0110000000000000
1110010011010000
0000000000000100
1110001100000011
0000000000010000
1111110000100000
1110111010001000
0000000000010000
1111110111001000
0000000000000100
1110101010000111

//¿Qué hace este programa?

//RTA: Este programa parece ser parte de una rutina que:

//1. Calcula una dirección en la pantalla (RAM[16] = 16384)

//2. Hace operaciones aritméticas y lógicas con valores en memoria (RAM[4], RAM[19])

//3. Modifica memoria en función de esas operaciones — en especial, al final guarda un -1 (píxeles encendidos) en una dirección específica

//En resumen, este programa prepara una dirección de pantalla, hace cálculos combinando valores como RAM[19], RAM[4] y 24576 (teclado), y finalmente activa un pixel o región escribiendo -1 en una dirección resultante.


##Reto20

//Implementa un programa en lenguaje ensamblador que dibuje el bitmap que diseñaste en la pantalla solo si se presiona la tecla “d”.

@KBD
D=M            // Leer el teclado
@100
D=D-A          // Comparar con ASCII de 'd'
@SKIP_DRAW
D;JNE          // Si no es 'd', saltar el dibujo

// Llamar a rutina de dibujo
@DRAW
0;JMP

(SKIP_DRAW)
@SKIP_DRAW
0;JMP           // Loop infinito para detener

// --- RUTINA DE DIBUJO ---
(DRAW)
@0
D=A
@i
M=D             // i = 0

@16384
D=A
@screen
M=D             // screen = 16384

// Loop para escribir 30 valores del bitmap (ejemplo)
(LOOP_DRAW)
@i
D=M
@30             // <-- Cambia este número si quieres escribir más datos
D=D-A
@END_DRAW
D;JGE           // Si i >= 30, termina

// Cargar valor del bitmap[i]
@i
D=M
@bitmap
A=A+D          // A = &bitmap[i]
D=M            // D = bitmap[i]

// Escribir en pantalla
@screen
A=M
M=D

// Incrementar screen
@screen
M=M+1

// Incrementar i
@i
M=M+1

@LOOP_DRAW
0;JMP

(END_DRAW)
@END_DRAW
0;JMP           // Loop infinito para detener

// --- DATOS DEL BITMAP --- (Extra)
(bitmap)
@256            // bitmap[0]
D=A
@val0
M=D
@30976          // bitmap[1]
D=A
@val1
M=D
@1472
D=A
@val2
M=D
@-6560
D=A
@val3
M=D
@-19680
D=A
@val4
M=D
@12320
D=A
@val5
M=D
@11792
D=A
@val6
M=D
@11024
D=A
@val7
M=D
@14608
D=A
@val8
M=D
@14728
D=A
@val9
M=D
@14472
D=A
@val10
M=D
@14732
D=A
@val11
M=D
@-31996
D=A
@val12
M=D
@32356
D=A
@val13
M=D
@198
D=A
@val14
M=D
@-24702
D=A
@val15
M=D
@2
D=A
@val16
M=D
@338
D=A
@val17
M=D
@339
D=A
@val18
M=D
@337
D=A
@val19
M=D
@273
D=A
@val20
M=D
@-16383
D=A
@val21
M=D
@32257
D=A
@val22
M=D
@6913
D=A
@val23
M=D
@385
D=A
@val24
M=D
@129
D=A
@val25
M=D
@1
D=A
@val26
M=D
@1
D=A
@val27
M=D
@3
D=A
@val28
M=D
@1022
D=A
@val29
M=D

// Almacena los valores en memoria continua para el acceso en el bucle
(bitmap)
@val0
D=M
M=D
@val1
D=M
M=D
@val2
D=M
M=D
@val3
D=M
M=D
@val4
D=M
M=D
@val5
D=M
M=D
@val6
D=M
M=D
@val7
D=M
M=D
@val8
D=M
M=D
@val9
D=M
M=D
@val10
D=M
M=D
@val11
D=M
M=D
@val12
D=M
M=D
@val13
D=M
M=D
@val14
D=M
M=D
@val15
D=M
M=D
@val16
D=M
M=D
@val17
D=M
M=D
@val18
D=M
M=D
@val19
D=M
M=D
@val20
D=M
M=D
@val21
D=M
M=D
@val22
D=M
M=D
@val23
D=M
M=D
@val24
D=M
M=D
@val25
D=M
M=D
@val26
D=M
M=D
@val27
D=M
M=D
@val28
D=M
M=D
@val29
D=M
M=D

// --- FIN ---