# Actividad 01

1. ¿Qué es la entrada-salida mapeada a memoria?

RTA: Es la parte de la memoria RAM que ocupan el teclado y la pantalla, ya que antes del registro 16384, desde el registro 0 hasta el registro 16383 la memoria RAM sirve para almacenar valores y datos.

2. ¿Cómo se implementa en la plataforma Hack?

RTA: A partir del registro 16384 hasta el registro 24575 los registros sirven para intervenir en la pantalla y el registro 24576 es ocupado por el teclado. En relación con lo anterior, la pantalla del computador tiene dimensiones de 512px X 256px, por lo que casa registro ocupa 1 fila de 16 bits, si se ingresa en un registro entre 16384 y 24575 el número 0, la parte de la pantalla que corresponde a ese registro va a quedar de color blanco mientras que si se ingresa 1, esa parte quedará de color blanco.

3. Inventa un programa que haga uso de la entrada-salida mapeada a memoria.

RTA:

@16384 (La dirección en la RAM es ubicada en la parte de la memoria que es ocupada por la pantalla)
M=1  (A ese registro se le asigna el número 1, que equivale al color negro)






