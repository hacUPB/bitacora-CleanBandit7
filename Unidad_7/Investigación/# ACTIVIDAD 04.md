# ACTIVIDAD 04

Vas a realizar la última actividad de esta experiencia de aprendizaje. Yo sé que quieres seguir haciendo más, pero tenemos un tiempo muy limitado.

Analiza el ejemplo Adding some interactivity.

- ¿Qué hace el código del ejemplo?

RTA: 

El ejemplo original muestra cómo se puede enviar información interactiva desde la CPU (tu aplicación en C++) hacia la GPU (el shader), para que el resultado visual responda a la interacción del usuario, como mover el mouse, hacer clic o cambiar parámetros en tiempo real. 🖱️💫

En este caso, normalmente se usa la posición del mouse (mouseX, mouseY) como uniform, y el shader reacciona a ella modificando los colores, la posición de formas, o la intensidad de algún efecto.

- ¿Cómo funciona el código de aplicación, los shaders y cómo se comunican estos?

RTA: 

**A) En la aplicación**

El programa principal:

    - Carga el shader.

    - Dibuja una figura (por ejemplo, un rectángulo que ocupa toda la pantalla).

    - Envía los uniforms, incluyendo la posición del mouse y el tiempo.

**B) En los Shaders**

Los shaders reciben esos valores y usan las variables uniform para cambiar el comportamiento del renderizado.

    - El vertex shader puede mover o deformar los vértices según el mouse o el tiempo.

    - El fragment shader puede cambiar los colores o crear efectos visuales dinámicos.


