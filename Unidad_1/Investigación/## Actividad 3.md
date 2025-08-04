## Actividad 3

¿Qué son PC, D y A?

RTA:

**PC (Program Counter):** Representa la posición en la ROM, básicamente es la ubicación de las órdenes que se le van a dar al programa, como un "dedito señalador" que permite registrar una orden y que normalmente avanza a la siguiente a menos de que haya un salto.

**D (Data Register):** Es el espacio en que se pueden guardar registros temporales, como un número que voy a usar más adelante en una operación o el resultado de una suma.

**A (Adress Register):** Es el registro que permite guardar datos como si fuera otro registro más o también, permite cambiar la dirección señalada en la memoria. Por ejemplo, si quiero leer o escribir en la memoria (RAM), primero pongo la dirección en A, y luego uso M para referirme a esa dirección.

¿Para qué los usa la CPU?

RTA: 

La CPU usa estos registros para poder ejecutar instrucciones de forma precisa y rápida:

- Usa el PC para saber en todo momento qué instrucción toca ejecutar (como un índice).

- Usa el A para dos cosas: almacenar direcciones de memoria o números literales que se necesiten en una operación.

- Usa el D para guardar datos intermedios en operaciones aritméticas o lógicas.