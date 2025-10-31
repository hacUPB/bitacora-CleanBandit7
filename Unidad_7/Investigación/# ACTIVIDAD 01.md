# ACTIVIDAD 01

**CPU:** Code Processing Unit

**GPU:** Graphics Processing Unit

- ¿Qué es un shader?

RTA: **Es un código que se ejecuta en la GPU**. Todo lo que se encuentre en este código es lo que se va a transmitir desde la CPU a la GPU. 

- ¿Qué son los vértices?

RTA: Son puntos ubicados en un espacio tridimensional, es decir, que tienen una **coordenada en las 3 dimensions (X,Y y Z)**.

- ¿Con qué figura geométrica se dibuja en 3D?

RTA: Con **triángulos**, ya que estos son la figura geométrica más simple para definir una superficie plana en el espacio tridimensional.

- ¿Cómo se le llaman a los grupos de píxeles de un mismo triángulo?

RTA: Se les llama **fragmentos** y cada fragmento representa un potencial pixel en pantalla que forme parte del triángulo.

- ¿Qué es un fragment shader?

RTA: Es el código que se ejecuta por cada **fragmento** y **determina el color final que va a tener cada uno** a la hora de ejecutarse, pasa esto, calcula iluminación, textura, reflejos, transparencia, etc.

- ¿Qué es un vertex shader?

RTA: Es el código que se ejecuta para cada **vértice** y  **determina el movimiento del modelo**. Su función es transformar las coordenadas del vértice del espacio del modelo (model space) al espacio de la cámara (view space) o de la pantalla (clip space) cada vez que estas sean modificadas tomando en cuenta la posición de la cámara. En pocas palabras, los vértices crean formas al estar en ciertas coordenadas, pero para que se vea que un modelo, por ejemplo (el personaje de un videojuego) se mueve, las coordenadas deben primero, ser transformadas al espacio de la cámara del jugador y luego, esos se mueven para generar el efecto del movimiento, para esto, son procesados hasta 60 veces por segundo.

- ¿Al proceso de determinar qué pixels del display va a cubrir cada triángulo de una mesh se le llama?

RTA: El proceso es la **rasterización** y este convierte **los triángulos en fragmentos** que, representan a los pixeles que ocuparán en pantalla.

- ¿Qué es el render pipeline?

RTA: El render pipeline es un **conjunto de etapas ejecutadas** por la GPU que permite **convertir un modelo 3D en una imagen 2D visible**:

    1. Input de vértices
    2. Vertex Shader
    3. Ensamblado de primitivas (triángulos)
    4. Rasterización
    5. Fragment Shader
    6. Pruebas y mezcla final en el "framebuffer" 

**¿Qué es el framebuffer?:** es una zona de memoria en la GPU o en el sistema donde se guarda la imagen que se va a mostrar en pantalla, por ejemplo:

    - Durante el renderizado, los shaders calculan el color de cada fragmento (posible píxel).

    - Estos colores se almacenan temporalmente en el framebuffer.

    - Cuando se termina de procesar el frame, el contenido del framebuffer se envía al monitor (lo que se ve como la imagen final).

- ¿Hay alguna diferencia entre aplicar un color a una superficie de una mesh o aplicar una textura?

RTA: 

    - Color = Es un valor único (por ejemplo, toda la superficie azul).

    - Textura = Es una imagen que se “pega” sobre la superficie usando coordenadas UV.

La textura puede variar el color en cada punto, creando más detalle (como madera, piel, metal, etc.).


- ¿Cuál es la diferencia entre una textura y un material?

RTA: 

    Textura: es una imagen (por ejemplo, un .png o .jpg) que aporta color, brillo, rugosidad, etc.

    Material: es un conjunto de propiedades (incluye una o varias texturas y shaders) que definen cómo interactúa el objeto con la luz.

Ejemplo: el “material de metal” puede tener textura de color, mapa de normales, brillo y reflexión; todo eso junto crea el efecto metálico.

- ¿Qué transformaciones se requieren para mover un vértice del 3D world al View Screen?

RTA:

Se aplican tres transformaciones principales:

    Model Matrix - Pasa del espacio del modelo al espacio mundial.

    View Matrix - Pasa del espacio mundial al espacio de la cámara.

    Projection Matrix - Pasa del espacio de la cámara al espacio de pantalla (2D).

*Espacio Mundial:* Es el espacio en el cual se sitúa el modelo una vez ha sido creado, ya que este tiene sus coordenadas de manera local, pero una vez se ubican en el espacio mundial, el modelo pasa de ser el mismo a estar rodeado por un entorno.

- ¿Al proceso de convertir los triángulos en fragmentos se le llama?

RTA: Rasterización

- ¿Qué es el framebuffer?

RTA: Es un tipo de lienzo que está en segundo plano y es en el cual, se guardan los datos de fragment shader antes de proyectarlos en pantalla, algo así como un pre de la visualización final en pantalla.

- ¿Para qué se usa el Z-buffer o depth buffer en el render pipeline?

RTA: El Z-buffer (o depth buffer) almacena la profundidad (distancia a la cámara) de cada píxel.
Sirve para saber qué fragmento está al frente y cuál debe ocultarse.

Ejemplo: si un cubo está delante de una esfera, el Z-buffer evita que la esfera “se pinte encima”.

Luego de ver el segundo video entiendes por qué la GPU tiene que funcionar tan rápido y de manera paralela. ¿Por qué?

RTA: Porque la información de los vértices está en constante actualización a la hora de realizar un movimiento comandado, por lo que si se quiere mostrar una imagen en pantalla, se tiene que realizar el procesamiento de la misma (realizar el proceso de transformación del espacio del modelo al de la pantalla 2D) a través de varios cálculos para así, lograr procesar la imagen en sincronía.
