# ACTIVIDAD 01

En esta actividad vas a experimentar con una aplicación interactiva y listas enlazadas El siguiente código código además incluye la gestión de memoria.

"ofApp.h":

```C++
#pragma once
#include "ofMain.h"

class Node {
public:
    float x, y;
    Node* next;
    
    Node(float _x, float _y);
    ~Node();
};

class LinkedList {
public:
    Node* head;
    Node* tail;
    int size;

    LinkedList();
    ~LinkedList();
    
    void clear();
    void addNode(float x, float y);
    void update(float x, float y);
    void display();
};

class ofApp : public ofBaseApp {
public:
    LinkedList snake;
    void setup();
    void update();
    void draw();
    void keyPressed(int key);  // Nueva función para manejar el teclado
};

```

"ofApp.cpp":

```C++

#include "ofApp.h"

//--------------------------------------------------------------
void ofApp::setup() {
    // Añadir nodos a la serpiente
    ofBackground(255, 255, 255);
    for (int i = 0; i < 10; i++) {
        snake.addNode(ofGetWidth() / 2, ofGetHeight() / 2);
    }
}
//--------------------------------------------------------------
void ofApp::update() {
    // Actualizar la posición de la serpiente
    snake.update(ofGetMouseX(), ofGetMouseY());
}
//--------------------------------------------------------------
void ofApp::draw() {
    ofBackground(220);
    // Dibujar la serpiente
    snake.display();
}
//--------------------------------------------------------------
void ofApp::keyPressed(int key) {
    if (key == 'c') {
        snake.clear();  // Limpiar explícitamente la lista cuando se presiona la tecla 'c'
    }
}
//--------------------------------------------------------------

LinkedList::LinkedList() {
    head = new Node(ofGetWidth() / 2, ofGetHeight() / 2);
    tail = head;
    size = 1;
}
//--------------------------------------------------------------
LinkedList::~LinkedList() {
    clear();
}
//--------------------------------------------------------------
void LinkedList::clear() {
    Node* current = head;
    while (current != nullptr) {
        Node* nextNode = current->next;
        delete current;
        current = nextNode;
    }
    head = nullptr;
    tail = nullptr;
    size = 0;
}
//--------------------------------------------------------------
void LinkedList::addNode(float x, float y) {
    Node* newNode = new Node(x, y);
    if (tail != nullptr) {
        tail->next = newNode;
        tail = newNode;
    } else {
        head = tail = newNode;
    }
    size++;
}
//--------------------------------------------------------------
void LinkedList::update(float x, float y) {
    Node* current = head;
    float prevX = x;
    float prevY = y;

    while (current != nullptr) {
        float tempX = current->x;
        float tempY = current->y;
        current->x = prevX;
        current->y = prevY;
        prevX = tempX;
        prevY = tempY;
        current = current->next;
    }
}
//--------------------------------------------------------------
void LinkedList::display() {
    Node* current = head;
    while (current != nullptr) {
        ofSetColor(ofColor(255,0,0));
        ofDrawCircle(current->x, current->y, 10);
        current = current->next;
    }
}
//--------------------------------------------------------------
Node::Node(float _x, float _y) {
    x = _x;
    y = _y;
    next = nullptr;
}
//--------------------------------------------------------------
Node::~Node() {
    // Destructor para Node (si hay recursos adicionales)
}
```

Gestión de memoria: se maneja explícitamente la liberación de memoria mediante la función `clear()`. Nota que también se llama a clear en el destructor de la clase LinkedList para asegurar que la memoria se libere cuando el objeto se destruye.

Vas a reportar en tu bitácora de aprendizaje:

**1. Entiende la aplicación:** comienza explorando detenidamente cómo funciona el programa. Usa un un modelo del lenguaje como ChatGPT y el depurador para que verifiques las explicaciones que te propone ChatGPT. Puedes escribir el prompt: quiere entender de manera muy detallada el siguiente programa escrito en C++ y el openframeworks. Luego le das el código. Ve preguntando lo que no entiendas. recuerda ir usando al mismo tiempo el depurador de visual studio.

**2. Realiza evaluaciones formativas:** Dile a ChatGPT que te genere preguntas para verificar si entiendes cómo funciona el programa. Trata de verificar tus hipótesis usando el depurador y luego con las conclusiones del experimento responde la pregunta de ChatGPT. Continúa con este proceso hasta que estés seguro de que entiendes cómo funciona el programa.

3. ¿Qué es una lista enlazada y en qué se diferencia de un arreglo en cuanto a la forma en que los elementos están almacenados en la memoria?

RTA: Una lista enlazada es una secuencia de nodos, los cuales son un conjunto de datos almacenados en la memoria "heap" y que contienen dentro de sus atributos un puntero de tipo puntero que apunta hacia el siguiente nodo que conforme a la lista. Las listas se diferencian de los arreglos ya que los elementos de los arreglos se almacenan en la memoria stack, la cual cuando se deja de ejecutar el programa, se borra. Mientras que los datos de la lista se almacenan en el heap y a menos de que no se borren manuelamente, estos permaneceran almacenados.

4. Al observar el código de una lista enlazada en C++, ¿Cómo crees que se vinculan los nodos entre sí? ¿Qué estructura se utiliza para lograr esta conexión?

RTA: En este caso, como se mencionó antes, cada nodo posee internamente un puntero que apunta al siguiente nodo al que está ligado y este puntero es de tipo nodo, esta sería la estructura que conecta a los punteros.

5. ¿Cómo se gestiona la memoria en una lista enlazada? Investiga cómo se crea y se destruye un nodo en memoria utilizando el operador new y delete en C++.

RTA: La gestión de la creación de memoria en una lista enlazada es por medio de un constructor de nodos, mientras que su destrucción es por medio de un destructor de nodos, el cual elimina la información del nodo en el heap.

**Constructor**
```C++
void LinkedList::addNode(float x, float y) {
    Node* newNode = new Node(x, y);
    if (tail != nullptr) {
        tail->next = newNode;
        tail = newNode;
    } else {
        head = tail = newNode;
    }
    size++;
}
```


**Destructor**
```C++
void LinkedList::clear() {
    Node* current = head;
    while (current != nullptr) {
        Node* nextNode = current->next;
        delete current;
        current = nextNode;
    }
    head = nullptr;
    tail = nullptr;
    size = 0;
}
```


6. Considerando la estructura de una lista enlazada, ¿qué ventajas ofrece en comparación con un arreglo cuando se trata de insertar o eliminar elementos en posiciones intermedias?

RTA: La ventaja de usar una lista enlazada en comparación con un arreglo en común es que, en el arreglo para poder insertar un objeto en medio es necesario mover todos los objetos siguientes ya que están en memoria contigua, por lo que requiere de desplazar todos los objetos hasta que el objeto que se quiere poner en la mitad quede en el medio. En cambio, en una lista enlazada, gracias a que cada nodo tiene un puntero, solo es necesario ajustar el nodo adecuado para que el objeto que se quiere poner en el medio quede en la mitad.

7. En el código presentado, ¿Cómo se asegura que no haya fugas de memoria? ¿Qué papel juega el destructor en la clase LinkedList?

RTA:Para que haya una fuga de memoria, se tienen que liberar las referencias más no el espacio dinámico (heap) generado con "new", el papel que juega el destructor en la clase LinkedList es eliminar esas referencias en el heap antes de que los nodos dejen de existir, evitando el uso inconsciente de memoria en el espacio dinámico.

8. ¿Qué sucede en la memoria cuando se invoca el método clear() en una lista enlazada? Explica paso a paso cómo se liberan los recursos.

RTA: Cuando se invoca el método clear() se convoca a un proceso en el que se recorre toda la lista enlazada desde head hasta tail para así, borrar todos los nodos tanto en el stack como en el heap, pero el proceso va sí:

    a. El puntero current que está en head apuntando al nodo1.

    b. Antes de borrar el nodo 1, en un puntero temporal se guarda el next que apunta al nodo2.

    c. Ahora se libera la memoria en el heap del nodo1, borrándolo al poner "delete=current".

    d. Se mueve el puntero hacia el siguiente nodo, ubicando el "currente=temp" es decir, el current apunta al temporary, es decir, el puntero del head está apuntando al nodo2 ahora.

    e. Se repite el mismo proceso con los siguientes nodos hasta que el current sea nullptr.

    f. Ya después de liberar el espacio consumido en el heap pro todos los nodos, head y tail van a tener un valor nullptr, completando el clear(). (En este caso, como el tail estaba apuntando al último nodo, esa es la razón por la cual queda en null...)

9. Explica cómo cambia la estructura en memoria de una lista enlazada al agregar un nuevo nodo al final de la lista. ¿Cómo afecta esto al rendimiento de la lista enlazada?

RTA: La estructura cambiaría ya que el tail estaría apuntando al nuevo nodo creado al final, esto afectaría al rendimiento de la lista de una manera menos significativa que si se pusiera en una posición intermedia ya que en este caso, no es necesario ubicar el puntero de varios nodos, solo el del tail y ya quedaría bien seteado.

10. Analiza una situación en la que utilizar una lista enlazada sería más ventajoso que utilizar un arreglo. Justifica tu respuesta considerando la gestión de memoria y las operaciones de inserción y eliminación.

RTA: En el caso de la lista enlazada, es que a la hora de insertar objetos es más fácil ya que, mientras que un arreglo requiere de que se desplazen todos los caracteres siguientes a la posición en la que se quiere poner el nuevo objeto, en las listas enlazadas solo se tiene que modificar el puntero del nodo anterior a la posición en que se quiere poner el nuevo nodo y que el puntero del nuevo puntero apunte (válgase la redundancia) al objeto siguiente, sin necesidad de desplazar objetos.

11. Después de estudiar el manejo de memoria en listas enlazadas, ¿Cómo aplicarías este conocimiento para diseñar una estructura de datos personalizada para una aplicación creativa? ¿Qué aspectos considerarías para asegurar la eficiencia y evitar fugas de memoria?

RTA: Por ejemplo creando un videojuego en el que hayan varios ítems que aparezcan y desaparezcan en un nivel, utilizaría una lista enlazada para controlar manualmente este patrón de aparición y desaparición de los objetos y que cuando se acabe un nivel, con la función clear() se puedan borrar todos los objetos para reiniciar la estructura en el siguiente. En este caso el destructor evitaría fugas y el funcionamiento de las listas enlazadas permitiría mover de manera dinámica los objetos.

12. Reflexiona sobre las diferencias en la gestión de memoria entre C++ y un lenguaje con recolección de basura automática como C#. ¿Qué ventajas y desafíos encuentras en la gestión explícita de memoria en C++ al trabajar con estructuras de datos?

RTA: 
- C++: gestión explícita. Tú decides cuándo usar new y delete.

    Ventaja: mayor control y eficiencia.

    Desafío: riesgo de fugas o doble liberación si no eres cuidadoso.

- C#: tiene Garbage Collector (GC).

    Ventaja: no te preocupas por liberar memoria.

    Desafío: menos control, el GC puede activarse en momentos inesperados y afectar rendimiento.

Básicamente, C++ da maor control sobre la gestión de datos y la memoria, pero de igual manera, requiere de mayor atención para así evitar borrar la memoria de los objetos en el heap y que hayan fugas.

13. Imagina que estás optimizando una pieza de arte generativo que usa listas enlazadas para representar elementos en movimiento. ¿Qué consideraciones tomarías en cuenta para garantizar que la gestión de la memoria sea eficiente y que no ocurran fugas de memoria?

RTA: Usualmente, el arte generartivo funciona con un sistema de partículas u objetos que cuando salen de pantalla o terminan su ciclo de uso, son eliminadas, así que en este caso, para garantizar el uso adecuado de la memoria y que el rendimiento de la aplicación sea eficiente, tendría e cuenta las siguientes consideraciones al estar usando listas enlazadas:

    a. Tener bien configurada la clase linkedlist para que cada vez que una partícula cumpla su tiempo de uso o salga de pantalla, el delete la borre del heap y así, no hayan fugas tanto en el stack como en el espacio dinámico.

    b. Usar la función clear() cada vez que se reinicie la aplicación para así liberar el espacio usado anteriormente y reiniciar su capacidad.

    c. Usar adecuadamente punteros y evitar copiar o duplicar listas muy grandes, cosa que no se repliquen estos datos en memoria y se gaste inconscientemente.

    d. Mantener los punteros de head y tail para que así la inserción de nodos sea más efectiva.

14. **Pruebas:** pregunta a ChatGPT cómo podrías probar las partes del programa y el programa completo. Luego realiza las pruebas y verifica si los resultados coinciden con tus expectativas.

RTA: 

**Pruebas unitarias:**

- Insertar en cabeza, en medio y en cola → verificar la lista.

- Eliminar en cabeza, en medio y en cola → verificar integridad.

- Llamar clear() y comprobar que head == nullptr.

**Prueba de fugas:**

- Usar herramientas como Valgrind en C++ para comprobar que no haya memoria sin liberar.

**Prueba de estrés:**

- Insertar y eliminar miles de nodos en ciclos → verificar que el programa siga rápido y sin fugas.

**Prueba completa:**

- Crear lista, agregar, eliminar, limpiar y volver a usarla → confirmar que todo funciona sin errores.

