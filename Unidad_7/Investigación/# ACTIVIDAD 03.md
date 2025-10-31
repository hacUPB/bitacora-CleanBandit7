# ACTIVIDAD 03

Ahora vas a pasar información personalizada de tu programa a los shaders. Vas a leer con detenimiento el tutorial Adding Uniforms.

- ¿Qué es un uniform?

RTA: Un uniform es una variable global dentro del shader que:

    - no cambia para cada vértice ni cada fragmento,

    - pero sí puede cambiar entre cuadros (frames), porque la CPU se la envía a la GPU antes de dibujar.

Características:

    - Se declaran en el shader con la palabra clave uniform.

    - Se pueden enviar desde C++ usando funciones como shader.setUniform1f(), shader.setUniform2f(), shader.setUniform4f(), shader.setUniformTexture(), etc.

    - Se mantienen con el mismo valor durante todo el dibujo hasta que la CPU los cambie.



- ¿Cómo funciona el código de aplicación, los shaders y cómo se comunican estos?

RTA: 

**a) En la aplicación C++ (CPU):**

    - Se define y se carga el shader (shader.load("shader.vert", "shader.frag");).

    - Luego, antes de dibujar, se envían las variables usando setUniform....

    - Finalmente, se dibuja la figura (ofDrawRectangle()).

    ```C#
    void ofApp::draw(){
    shader.begin();

    // Mandar uniforms (valores personalizados)
    shader.setUniform1f("time", ofGetElapsedTimef());
    shader.setUniform2f("resolution", ofGetWidth(), ofGetHeight());

    ofDrawRectangle(0, 0, ofGetWidth(), ofGetHeight());

    shader.end();
    }

    ```

**b) En los shaders (GPU):**

    - Los vertex shaders transforman las posiciones de los vértices.

    - Los fragment shaders calculan los colores finales.

    - Los uniforms enviados desde la CPU se usan dentro de esos shaders para generar efectos dinámicos.


    ```C#
    // shader.frag
    #version 150

    uniform float time;
    uniform vec2 resolution;
    out vec4 outputColor;

    void main(){
        vec2 st = gl_FragCoord.xy / resolution;
        float r = abs(sin(time + st.x * 3.14));
        float g = abs(sin(time + st.y * 3.14));
        float b = abs(sin(time));
        outputColor = vec4(r, g, b, 1.0);
    }
    ```
- Aquí el color cambia con el tiempo y depende de la posición del píxel en la pantalla. Cada fragmento usa los uniforms time y resolution que la CPU le envió.


**c) Comunicación entre la CPU y la GPU**

| Flujo        | Qué ocurre                                                                    |
| ------------ | ----------------------------------------------------------------------------- |
| CPU (C++)    | Llama a `shader.setUniform...` y envía valores                                |
| API OpenGL   | Transfiere esos valores por el bus hacia la GPU                               |
| GPU (shader) | Usa esos valores dentro del código GLSL para calcular el color de los píxeles |


Modifica el código de la actividad para cambiar el color de cada uno de los píxeles de la pantalla personalizando el fragment shader.

