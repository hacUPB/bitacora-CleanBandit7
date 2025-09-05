### Conclusiones de los Retos

**RETO 01**

1. ¿Cómo están implementadas las variables i y sum?

RTA: La variable "i" funciona como un contador y la variable "sum" funciona como un acumulador. 

2. ¿En qué direcciones de memoria están estas variables?

RTA: En Hack, las variables comienzan desde la dirección @16. Si i y sum son las primeras variables que aparecen en el programa, entonces:

- i estará en la dirección RAM[16]

- sum estará en la dirección RAM[17]

3. ¿Cómo está implementado el ciclo while?

RTA: En este caso, el ciclo "while" sirve como "loop" para que en caso de que el contador no sea mayor a 100, se repita un ciclo que permite que se vaya sumando de 1 en 1 hasta llegar a 100, cosa que cuando el número acumulado sea 101, el ciclo se detenga y se deje de sumar para que así, el programa pare.

```asm
@i
D=M
@100
D=D-A
@END
D;JGT      // si i > 100 → saltar a END
```

4. ¿Cómo se implementa la variable i?

RTA: La variable i se implementa como una posición de memoria (@i) donde se guarda su valor. En cada iteración del ciclo se usa para:

- Comparar con 100

- Sumar a sum

- Incrementarse con M=M+1

5. ¿En qué parte de la memoria se guarda la variable "i"?

RTA: En la RAM[16].

6. Después de todo lo que has hecho ¿Qué es entonces una variable?

RTA: Una variable en lenguaje ensamblador Hack es una etiqueta simbólica que representa una dirección de memoria RAM. Sirve para guardar y recuperar valores durante la ejecución del programa. También sirve para ejecutar ciertos arreglos dependiendo de su aplicación y el propósito con el que se quieran usar.

7. ¿Qué es la dirección de una variable?

RTA: El número de posición en la memoria RAM donde se almacena el valor de la variable, algo así como el espacio en la RAM en el que está ubicada.

8. ¿Qué es el contenido de una variable?

RTA: El valor numérico que está guardado en la dirección de memoria asociada a la variable.


**RETO 02**

- En este caso, se puede utilizar el mismo código pero en vez de utilizar el ciclo "while" así:

```C++
int i = 1;
int sum = 0;
While (i <= 100){
   sum += i;
   i++;
}
```
- Se cambia por el "for" y se le cambia la sintaxis del while por la del for, quedando el siguiente código:

```C++
int sum = 0;
for (int i = 1; i <= 100; i++) {
   sum += i;
}
```

**RETO 03**

- Escribe un programa en lenguaje ensamblador que implemente el programa anterior.

```asm
@i
M=1          // int i = 1

@sum
M=0          // int sum = 0

(LOOP)
@i
D=M
@100
D=D-A
@END
D;JGT        // if i > 100 → salir

@sum
D=M
@i
D=D+M
@sum
M=D          // sum += i

@i
M=M+1        // i++

@LOOP
0;JMP        // repetir

(END)
```
RTA: En lenguaje ensamblador el condicional for y while no se pueden representar como tal, se pronuncian al seguir cierto orden, pero en sí, lo único que se necesita para manifestarlos es una etiqueta de inicio del ciclo, una condición de salida, un cuerpo y un salto para repetir, por lo que ambos terminan viéndose iguales.


**RETO 04**

- Ahora vamos a acercarnos al concepto de puntero. Un puntero es una variable que almacena la dirección de memoria de otra variable. Observa el siguiente programa escrito en C++:

```C++

int var = 10;
int *punt;
punt = &var;
*punt = 20;

```
¿Cómo se declara un puntero en C++? 

RTA: int *punt;. punt es una variable que almacenará la dirección de un variable que almacena enteros.

- ¿Cómo se define un puntero en C++? 

RTA: punt = &var;. Definir el puntero es inicializar el valor del puntero, es decir, guardar la dirección de una variable. En este caso punt contendrá la dirección de var .

- ¿Cómo se almacena en C++ la dirección de memoria de una variable?

RTA: Con el operador &. punt = &var;

- ¿Cómo se escribe el contenido de la variable a la que apunta un puntero?

RTA: Con el operador "punt = 20";. En este caso como punt contiene la dirección de var  entonces punt a la izquierda del igual indica que quieres actualizar el valor de la variable var .


**RETO 05**

- Traduce este programa a lenguaje ensamblador:

```C++

int a = 10;
int *p;
p = &a;
*p = 20;

```
- Ahora la solución:

```asm

@10 // Posición 10
D=A // D guarda 10
@a  // Creamos la variable "a"
M=D // Guardamos 10 en la variable "a"
D=A // Copiamos en D la dirección de "a" (en este caso 16)
@p // Creamos el puntero
M=D // Guardamos la dirección de "a" en el puntero
@20 // Nos ubicamos en 20
D=A // Guardamos 20 en D
@p //Nos devolemos al puntero
A=M // Nos ubicamos en la dirección de "a" usando el valor guardado en el puntero
M=D // Asignamos el valor 20 a la dirección de "a"

```



**RETO 06**

Ahora vas a usar un puntero para leer la posición de memoria a la que este apunta, es decir, vas a leer por medio del puntero la variable cuya dirección está almacenada en él.

```C++
int var = 10;
int bis = 5;
int *p_var;
p_var = &var;
bis = *p_var;
```
En este caso "bis = *p_var;" hace que el valor de "bis" cambie de 5 a 10 porque "p_var" apunta a la la variable "var" y con "*p_var" a la derecha del igual estás leyendo el contenido de la variable apuntada.


**RETO 07**

Traduce este programa a lenguaje ensamblador:

```C++

int var = 10;
int bis = 5;
int *p_var;
p_var = &var;
bis = *p_var;
```

Solución:

```asm

@10 // Vamos a la dirección 10
D=A // Guardamos 10 en D
@var // Vamos a la posición 16 (dirección de var)
M=D // Guardamos 10 en el valor de la dirección 16

@5 // Vamos a la dirección 5
D=A // Guardamos 5 en D
@bis // Vamos a la dirección 17 (dirección de bis)
M=D //Guardamos 5 en el valor de la dirección 17

@var // Vamos a la dirección 16
D=A // Guardamos 16 en D
@p_var // Vamos a la dirección 18 (dirección del puntero)
M=D // Guardamos la dirección de var (16) en el valor del puntero

@p_var // Vamos a la dirección del puntero (18)
A=M // Vamos a la dirección 16 desde el puntero
D=M //Guardamos en D el valor de var, es decir 10
@bis // Vamos a la dirección 17 (bis)
M=D //Guaardamos en el valor de la dirección 17 el valor de la variable var, es decir, pasa de ser 5 a 10.
```


**RETO 08**

Vas a parar un momento y tratarás de recodar de memoria lo siguiente. Luego verifica con un compañero o con el profesor:

1. ¿Qué hace esto "int *pvar;"?

RTA: inicializar un puntero llamado "pvar". 

2. ¿Qué hace esto "pvar = var";?

RTA: Se supone que guardar la dirección de var en el puntero pero al estar mal escrito, faltando le símbolo &, no se está guardando correctamente ya que sin símbolo, es como si e estuviera guardando el valor de var en el puntero y los punteros no pueden guardar valores, solo direcciones.

3. ¿Qué hace esto "var2 = *pvar"?

RTA: Está guardando en var2 el valor asignado a la dirección de memoria que almacena el puntero.

4. ¿Qué hace esto "pvar = &var3"?

RTA: Esta guardando en el puntero pvar la dirección de la variable var3, esto se puede identificar por el símbolo &.



**RETO 09**

Considera que el punto de entrada del siguiente programa es la función "main", es decir, el programa inicia llamando la función "main". Vas a proponer una posible traducción a lenguaje ensamblador de la función "suma", cómo llamar a suma y cómo regresar a "std::cout << "El valor de c es: " << c << std::endl;" una vez suma termine.

```C++

#include <iostream>

int suma(int a, int b) {
   int var = a + b;
   return var;
}


int main() {
   int c = suma(6, 9);
   std::cout << "El valor de c es: " << c << std::endl;
   return 0;
}
```

Solución:

```asm
// main inicia aquí
@6         // Cargar valor 6 (a)
D=A
@16        // Guardar en RAM[16] (a)
M=D

@9         // Cargar valor 9 (b)
D=A
@17        // Guardar en RAM[17] (b)
M=D

// Llamada a la suma
@RETURN    // Guardar dirección de retorno
D=A
@21        // Usamos RAM[21] como temp para el return address
M=D

@SUMA      // Ir a la función suma
0;JMP

(RETURN)   // Punto de retorno después de suma

// Guarda el resultado de suma (que estará en RAM[18]) en c (RAM[19])
@18
D=M
@19
M=D

// Fin del programa (bucle infinito)
(END)
@END
0;JMP

// Función Suma
(SUMA)
// Suma de a + b → guardar en var
@16        // Cargar a
D=M
@17        // Sumar b
D=D+M
@18        // Guardar en var
M=D

// Retornar (saltamos a la dirección guardada en RAM[21])
@21
A=M
0;JMP
```

