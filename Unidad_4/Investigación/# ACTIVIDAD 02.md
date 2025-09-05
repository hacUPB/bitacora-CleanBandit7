# ACTIVIDAD 02

En esta actividad vas a experimentar con pilas y colas en un contexto de arte generativo. El código incluye la gestión de memoria.

El código para la pila es este:

**ofApp.h:**

```C++
#pragma once

#include "ofMain.h"

class Node {
public:
    ofVec2f position;
    Node* next;

    Node(float x, float y) {
        position.set(x, y);
        next = nullptr;
    }
};

class Stack {
public:
    Node* top;

    Stack() {
        top = nullptr;
    }

    ~Stack() {
        clear();
    }

    void push(float x, float y) {
        Node* newNode = new Node(x, y);
        newNode->next = top;
        top = newNode;
    }

    void pop() {
        if (top != nullptr) {
            Node* temp = top;
            top = top->next;
            delete temp;  // Liberar memoria del nodo eliminado
        }
    }

    void clear() {
        while (top != nullptr) {
            pop();
        }
    }

    void display() {
        Node* current = top;
        while (current != nullptr) {
            ofDrawCircle(current->position.x, current->position.y, 20);
            current = current->next;
        }
    }
};

class ofApp : public ofBaseApp {

public:
    Stack circleStack;

    void setup();
    void update();
    void draw();
    void keyPressed(int key);
};
```
**ofApp.cpp:**

```C++
#include "ofApp.h"

//--------------------------------------------------------------
void ofApp::setup() {
    ofSetBackgroundColor(220);
}

//--------------------------------------------------------------
void ofApp::update() {

}

//--------------------------------------------------------------
void ofApp::draw() {
    // Dibujar todos los círculos en la pila
    circleStack.display();
}

//--------------------------------------------------------------
void ofApp::keyPressed(int key) {
    if (key == 'a') { // Apilar un nuevo círculo
        circleStack.push(ofGetMouseX(), ofGetMouseY());
    }
    else if (key == 'd') { // Desapilar el último círculo
        circleStack.pop();
    }
}
```

El código para la cola es este:

**ofApp.h:**

```C++

#pragma once

#include "ofMain.h"

class Node {
public:
    ofVec2f position;
    Node* next;

    Node(float x, float y) {
        position.set(x, y);
        next = nullptr;
    }
};

class Queue {
public:
    Node* front;
    Node* rear;

    Queue() {
        front = rear = nullptr;
    }

    ~Queue() {
        clear();
    }

    void enqueue(float x, float y) {
        Node* newNode = new Node(x, y);
        if (rear == nullptr) {
            front = rear = newNode;
        }
        else {
            rear->next = newNode;
            rear = newNode;
        }
    }

    void dequeue() {
        if (front != nullptr) {
            Node* temp = front;
            front = front->next;
            if (front == nullptr) {
                rear = nullptr;
            }
            delete temp;  // Liberar memoria del nodo eliminado
        }
    }

    void clear() {
        while (front != nullptr) {
            dequeue();
        }
    }

    void display() {
        Node* current = front;
        while (current != nullptr) {
            ofDrawCircle(current->position.x, current->position.y, 20);
            current = current->next;
        }
    }
};

class ofApp : public ofBaseApp {

public:
    Queue circleQueue;

    void setup();
    void update();
    void draw();
    void keyPressed(int key);
};
```

**ofApp.cpp:**

```C++

#include "ofApp.h"

//--------------------------------------------------------------
void ofApp::setup() {
    ofSetBackgroundColor(220);
}

//--------------------------------------------------------------
void ofApp::update() {

}

//--------------------------------------------------------------
void ofApp::draw() {
    // Dibujar todos los círculos en la cola
    circleQueue.display();
}

//--------------------------------------------------------------
void ofApp::keyPressed(int key) {
    if (key == 'a') { // Encolar un nuevo círculo
        circleQueue.enqueue(ofGetMouseX(), ofGetMouseY());
    }
    else if (key == 'd') { // Desencolar el primer círculo
        circleQueue.dequeue();
    }
}
```

**Gestión de memoria:** se maneja explícitamente la liberación de memoria mediante las funciones clear(). Nota que también se llama a clear() en el destructor de las clases Stack y Queue para asegurar que la memoria se libere cuando los objetos se destruyen.

Vas a reportar en tu bitácora de aprendizaje:

1. **Entendiendo la aplicación**: comienza explorando detenidamente cómo funciona el programa. Usa un un modelo del lenguaje como ChatGPT y el depurador para que verifiques las explicaciones que te propone ChatGPT. Puedes escribir el prompt: quiere entender de manera muy detallada el siguiente programa escrito en C++ y el openframeworks. Luego le das el código. Ve preguntando lo que no entiendas. recuerda ir usando al mismo tiempo el depurador de visual studio.

**2. Realiza evaluaciones formativas:** Dile a ChatGPT que te genere preguntas para verificar si entiendes cómo funciona el programa. Trata de verificar tus hipótesis usando el depurador y luego con las conclusiones del experimento responde la pregunta de ChatGPT. Continúa con este proceso hasta que estés seguro de que entiendes cómo funciona el programa.

RTA:

    A. Stack – orden de dibujo
    Pregunta: Si apilas en este orden A, luego B, luego C, ¿en qué orden se dibujan?
    Hipótesis esperada: Se dibujan C, luego B, luego A (desde top hacia abajo).
    Cómo verificar: breakpoint en display() de Stack, observa current->position al avanzar.
    Conclusión correcta: El último apilado se dibuja primero; el más antiguo puede quedar encima si se solapan.

    B. Queue – orden de salida
    Pregunta: Encolando A, B, C, ¿quién sale con el primer dequeue()?
    Hipótesis esperada: Sale A (FIFO).
    Verifica: breakpoint en dequeue(), observa temp->position antes del delete.
    Conclusión: Sale el más antiguo. Tras eliminar el único nodo, front y rear pasan a nullptr.

    C. Stack – complejidad de push/pop
    Pregunta: ¿Dependen de la cantidad de nodos?
    Hipótesis: push y pop son O(1).
    Verifica: Observa que no hay recorridos: solo reasignación de punteros.
    Conclusión: Constante, independientemente del tamaño.

    D. Queue – caso cola vacía
    Pregunta: ¿Qué pasa con front/rear al encolar el primer nodo?
    Hipótesis: Ambos apuntan al mismo newNode.
    Verifica: breakpoint en enqueue cuando rear == nullptr.
    Conclusión: Invariante: si la cola está vacía, front==rear==nullptr; después del primer enqueue, front==rear==newNode.

    E. Memoria – fugas
    Pregunta: ¿Quién libera el heap al cerrar la app?
    Hipótesis: El destructor llama clear(), y clear() elimina nodo por nodo.
    Verifica: breakpoint en ~Stack/~Queue, deja cerrar la app y sigue el rastro.
    Conclusión: No quedan nodos vivos; se evita fuga.

    F. Queue – rear->next
    Pregunta: ¿Cuál debe ser siempre el valor de rear->next?
    Hipótesis: Siempre nullptr.
    Verifica: tras cada enqueue, inspecciona rear->next.
    Conclusión: Invariante de cola.

    G. Stack – pop en vacío
    Pregunta: ¿Qué ocurre si presionas d con la pila vacía?
    Hipótesis: No hace nada (protección if(top!=nullptr)).
    Verifica: breakpoint en pop(), verás que no entra al bloque.
    Conclusión: Seguro ante vacío (no crashea).

**3. Pruebas:** pregunta a ChatGPT cómo podrías probar las partes del programa y el programa completo. Luego realiza las pruebas y verifica si los resultados coinciden con tus expectativas.

RTA:

**3.1. Pruebas funcionales manuales (con secuencias y resultados esperados)**

    Pila (Stack)

        A. Apilar 3 y recorrer

        - Mueve el mouse a (100,100), presiona 'a'; luego (200,100), 'a'; luego (200,200), 'a'.

        - Esperado: top apunta a (200,200). Orden en display: (200,200) → (200,100) → (100,100).

        - Visual: si se superponen, el más antiguo puede quedar encima.

        B. Desapilar 1

        - Presiona 'd' una vez.

        - Esperado: top ahora (200,100). Se liberó el nodo (200,200).

        C. Desapilar hasta vacío

        - Presiona 'd' dos veces más.

        - Esperado: top == nullptr. Pops en vacío no hacen nada.

    - Cola (Queue)

        A. Encolar 3 y recorrer

        - Encola en (100,100), (200,100), (200,200) con 'a'.

        - Esperado: front=(100,100), rear=(200,200). rear->next==nullptr.

        - Orden display: (100,100) → (200,100) → (200,200).
        El más nuevo queda encima si se solapan.

        B. Desencolar 1

        - Presiona 'd'.

        - Esperado: salió (100,100). front pasa a (200,100). rear sigue (200,200).

        C. Desencolar hasta vacío

        - 'd' dos veces más.

        - Esperado: front==nullptr && rear==nullptr. Presionar 'd' extra no hace nada.

**3.2. Pruebas de invariantes (muy importantes)**

    - Stack:

        - Vacía ⇒ top==nullptr.

        - No vacía ⇒ top!=nullptr.

        - Tras pop, top apunta al que era top->next.

    - Queue:

        - Vacía ⇒ front==nullptr && rear==nullptr.

        - No vacía ⇒ front!=nullptr && rear!=nullptr.

        - Siempre rear->next==nullptr.

        - Tras dequeue que deja un elemento, front==rear.

        - Tras dequeue del único elemento ⇒ front==rear==nullptr.

        - Para verificar, añade una función auxiliar temporal (solo para test) y úsala en breakpoints o logs:

        ```C++
        int sizeStack(const Stack& s){
            int c=0; Node* cur=s.top; while(cur){++c; cur=cur->next;} return c;
        }
        int sizeQueue(const Queue& q){
            int c=0; Node* cur=q.front; while(cur){++c; cur=cur->next;} return c;
        }
        ```

**3.3. Pruebas de robustez**

- Teclas rápidas: mantén presionada 'a' 2–3s moviendo el mouse; luego 'd' 2–3s.
Esperado: sin crasheos; tamaños suben y bajan correctamente.

- Alternancia: 'a', 'd', 'a', 'd' repetido 50 veces.
Esperado: no se “rompen” punteros.

**3.4. Pruebas de memoria (Windows/Visual Studio)**

- Usa Diagnostics Tools > Memory Usage (o CRT Debug Heap / Visual Leak Detector) para confirmar cero fugas al cerrar la app.

- Prueba:
    a. Ejecuta, encola/apila muchos nodos, luego cierra.

    b. Observa que el destructor llama clear() y todos los Node se eliminan.

    c. Repite tras una sesión larga de uso (estrés).

Si tienes WSL/Linux disponible, puedes correr la versión consola y usar valgrind: valgrind --leak-check=full ./tuApp, esperando “no leaks are possible”.

**3.5. Pruebas visuales**

- Coloca círculos que se solapen y verifica el orden de pintura:

    - Stack: el más viejo termina encima (porque se dibuja después).

    - Queue: el más nuevo termina encima.


**Preguntas de reflexión para el stack (Pila):**

1. ¿Cómo se gestiona la memoria en una implementación manual de un stack en C++? Reflexiona sobre cómo el uso de new y delete en la creación y destrucción de nodos afecta el rendimiento y la seguridad de tu programa.

RTA: En este caso la memoria no es automática como en un arreglo estático, sino que se maneja dinámicamente con new y delete.

- Cada vez que se hace push(), se crea un nodo en el heap (new Node(...)), es decir, se aparta espacio de memoria para ese nodo.

- Cuando se hace pop(), se libera el nodo de arriba con delete temp.

- Esto significa que somos responsables de reservar y liberar memoria.

- Si se usa new sin delete, se tendrán fugas de memoria.

- Si se libera mal (ejemplo, delete dos veces el mismo nodo), se pueden tener errores graves como corrupción de memoria (es decir, liberar memoria que ya no existe, un proceso que puede dañar al heap).

- En cuanto a rendimiento: la gestión manual con new y delete puede ser un poco más lenta que usar estructuras predefinidas, pero da control total.

2. ¿Por qué es importante liberar la memoria cuando se desapila un nodo en un stack? Considera las consecuencias de no liberar memoria en términos de fugas de memoria y cómo esto puede impactar aplicaciones de largo tiempo de ejecución.

RTA: Cuando se saca un nodo (pop), ese espacio ya no se necesita.

- Si no se llama delete, el nodo sigue ocupando espacio en el heap.

- Esto se llama fuga de memoria.

En programas pequeños puede no notarse, pero en aplicaciones de largo tiempo (servidores, simulaciones, videojuegos que corren horas) el heap se llena, causando:

- Consumo excesivo de RAM.

- Posibles crashes o ralentizaciones por falta de memoria.

- Liberar memoria en pop() asegura que el stack no acumule basura con el tiempo.

3. ¿Qué diferencias existen entre usar un stack de la STL (std::stack) y crear un stack manualmente? Explora cómo la abstracción que proporciona la STL puede simplificar la implementación, pero también cómo una implementación manual ofrece mayor control sobre la gestión de recursos.

RTA:
std::stack (STL):

    - Ya viene implementado, probado y optimizado.

    - No hay que preocuparse por fugas de memoria, porque gestiona todo internamente.

    - Es más seguro y rápido de usar, ideal en proyectos reales.

Stack manual (como el tuyo):

    - Uno controla exactamente cómo se crea, almacena y elimina cada nodo.

    - Uno mismo puede modificar la estructura interna (por ejemplo, añadir atributos a los nodos, hacer un display() personalizado como en tu código).

    - Riesgo mayor de errores de memoria si olvidas delete.

En resumen: la STL da seguridad y simplicidad, pero el manual da control y flexibilidad.

4. ¿Cómo afecta la estructura de un stack al orden de acceso y eliminación de elementos? Analiza cómo la naturaleza LIFO (Last In, First Out) del stack influye en los tipos de problemas que esta estructura de datos puede resolver eficientemente.

RTA: 

El stack sigue el principio LIFO (Last In, First Out):

    - El último nodo en entrar (push) es el primero en salir (pop).

    - Solo puedes acceder/modificar el nodo de arriba (top).

Esto significa que un stack es eficiente para problemas donde el orden importa:

    - Deshacer/rehacer (Ctrl+Z).

    - Recorrido de expresiones matemáticas (paréntesis, notación polaca inversa).

    - Algoritmos de backtracking (laberintos, juegos, generación de fractales).

El acceso a elementos intermedios no es posible directamente (a diferencia de un arreglo). Solo trabajas con el tope.

5. ¿Cómo podrías modificar el stack para almacenar tipos de datos más complejos (e.g., objetos con múltiples atributos) sin causar problemas de memoria? Reflexiona sobre cómo gestionar adecuadamente la memoria para objetos más complejos y cómo esto afectaría tu implementación actual.

RTA:

Ahora solo se guarda un ofVec2f (x, y). Pero se podría guardar:

    - Colores, radios, texturas, IDs, etc.

    - Incluso objetos completos (ejemplo: una clase Circle con atributos de dibujo).

Opciones:

    a. Cambiar el nodo:

    ```C++
    class Node {
    public:
    Circle circleData;  // objeto con múltiples atributos
    Node* next;
    };
    ```
    Aquí hay que asegurarse de que Circle tenga un constructor, destructor y copia seguros.

    b. Usar punteros a objetos:

    ```C++
    class Node {
    public:
    Circle* circleData;
    Node* next;
    };
    ```
    Pero aquí obligatoriamente se tendría que hacer delete circleData al liberar el nodo, para evitar fugas.

En ambos casos, lo clave es gestionar la memoria de los objetos internos (no solo de los nodos). Si no se hace bien, se tendrían fugas o dobles liberaciones.


