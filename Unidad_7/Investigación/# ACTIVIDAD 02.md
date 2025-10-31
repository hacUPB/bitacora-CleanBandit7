# ACTIVIDAD 02

ienza realizando la lectura de la introducción del tutorial [Introducing Shaders](https://openframeworks.cc/ofBook/chapters/shaders.html). Realiza la sección Your First Shader, pero antes de ejecutar el código, realiza un pequeño experimento. Modifica ligeramente el método draw:

```cpp
void ofApp::draw(){
    ofSetColor(255);

    //shader.begin();

    ofDrawRectangle(0, 0, ofGetWidth(), ofGetHeight());

    //shader.end();
}
```

Observa la salida.

Ahora ejecuta el código original. Analiza los resultados y responde:

- ¿Cómo funciona?

RTA: 

    - shader.begin() activa un programa en la GPU (los shaders que se cargaron).

    - ofDrawRectangle() genera los vértices del rectángulo (en este caso, como se pide que el ancho y el alto sean del tamaño de la pantalla, este cubre toda la pantalla).

    - El vertex shader procesa esos vértices (posiciones).

    - Luego la GPU rasteriza el rectángulo (lo convierte en fragmentos/píxeles).

    - Por último, el fragment shader decide el color de cada píxel en la pantalla.

    - shader.end() desactiva el shader y devuelve el control al render normal.


- ¿Qué resultados obtuviste?

RTA: Sin el shader, se ve un rectángulo blanco que cubre toda la ventana  y con el shader, se ve el rectángulo con un gradiente de color (colores combinados con difuminación), lo cual indica que el color la no lo elige ofSetColor() sino el shader.

- ¿Estás usando un vertex shader?

RTA: Sí y aunque su función solo sea pasar las coordenadas de los vértices del rectángulo a las coordenadas de la pantalla, si se emplea.

- ¿Estás usando un fragment shader?

RTA: Sí, de hecho este se encarga del efecto visible, es decir, de los colores del rectángulo y su difuminación.

- Analiza el código de los shaders. ¿Qué hace cada uno?

RTA: 

En el caso del vertex shader:

    ```C#
    #version 150

    in vec4 position;

    void main() {
        gl_Position = position;
    }
    ```

    Toma las coordenadas del vértice (position) y las envía directamente a la salida (gl_Position).
    No cambia color ni posición: solo pasa los datos al siguiente paso.


En el caso del fragment shader:

```C#
#version 150

out vec4 outputColor;

void main() {
    outputColor = vec4(gl_FragCoord.x / 1024.0, gl_FragCoord.y / 768.0, 0.5, 1.0);
}
```

Calcula un color basado en las coordenadas del píxel (gl_FragCoord).
En este ejemplo, crea un degradado de colores porque usa x e y para generar los valores rojo y verde del color.