# RETO UNIDAD 04

Crea una obra de arte generativo dinámica (con gestión de memoria). Utilizando los conceptos de arreglos, listas enlazadas, pilas y colas, crea una obra de arte generativo dinámica. Asegúrate de gestionar el ciclo de vida de todos los objetos creados dinámicamente.

**Requisitos**
1. **Combinación de estructuras de datos:** usa al menos un arreglo o lista enlazada y una pila o cola para gestionar diferentes aspectos de tu obra (por ejemplo, la posición y color de los elementos, la velocidad de movimiento, etc.).

2. **Interactividad:** implementa al menos una forma de interacción con el usuario, que cambie la visualización o el comportamiento de la obra.

3. **Gestión de memoria:** asegúrate de liberar la memoria de todos los objetos creados dinámicamente.

**Preguntas para guiar el proceso**

1. **Exploración creativa:** ¿Qué tipo de efecto visual quieres lograr? ¿Cómo pueden ayudarte las diferentes estructuras de datos a lograr ese efecto?
2. **Gestión de memoria:** ¿Qué consideraciones debes tener en cuenta al gestionar dinámicamente la memoria de los objetos? ¿Cómo asegurar que no haya fugas de memoria?
3. **Interacción y dinamismo:** ¿Cómo puedes hacer que la interacción del usuario influya en múltiples estructuras de datos simultáneamente para crear un efecto visual coherente y dinámico?
4. **Optimización:** ¿Qué técnicas puedes implementar para optimizar la gestión de memoria y el rendimiento de tu aplicación mientras mantienes una experiencia visual rica y fluida?

**Ejemplo de idea:«Lluvia de colores:»** crea una simulación de gotas de lluvia de colores que caen desde la parte superior de la pantalla. Usa un arreglo para almacenar las posiciones iniciales de las gotas y una pila para apilar nuevas gotas a medida que se generan. Al liberar las gotas que han caído fuera de la pantalla, asegúrate de gestionar y liberar correctamente la memoria.

**SOLUCIÓN DEL RETO**

1. RTA: Con mi aplicación, el efecto visual que quiero lograr es el uno similar al que tienen las pantallas de carga de los DVD´s cuando se quedan mucho tiempo sin interacción, en los que el signo de DVD se queda rebotando en la pantalla por una cantidad de tiempo ilimitada a menos de que el usuario interactúe con ella. Además, me gustaría que en mi aplicación, para que el funcionamiento de la misma no sea tan "monótono", se pueda modificar el número de partículas que rebotarán en los bordes de la pantalla, el color de las partículas y la  velocidad con la que van a moverse. En este  caso, las estructuras de datos aprendidas en esta unidad me pueden ayudar ya que permitirán modificar los datos de las partículas de manera única en cada una y aparte, me permitirán controlar correctamente el uso de memoria tanto en el stack como en el heap para que así, no hayan fugas de memoria y se pueda eliminar la última partícula generada.

2. RTA: Que cuando el algoritmo deje de estar en funcionamiento o cuando se cierre el panel de visualización, los datos almacenados en el heap para cada orbe se borren, evitando fugas de memoria.

3. RTA: En este caso, programando el código de forma que el color de las esferas, la velocidad con la que se desplazan y su posición se almacenen en diferentes espacios del tipo de estructura que es el algoritmo, permitiendo que el ususario tenga contribución sobre cómo se ve y sus funcionalidades.

4. RTA: El uso de arreglos y punteros, ya que así es más fácil generar orbes sin generar tantas modificaciones al orden del programa y de igual forma, es más fácil eliminar los datos que ya no se estén usando cuando el programa deje de estar en funcionamiento.

**CÓDIGO DE LA APLICACIÓN:**

- ofApp.cpp:

```C++
#include "ofApp.h"

// ================= ORB ==================
void Orb::update() {
	pos += vel;

	// Rebote en los bordes de la ventana
	if (pos.x - radius < 0 || pos.x + radius > ofGetWidth()) {
		vel.x *= -1;
	}
	if (pos.y - radius < 0 || pos.y + radius > ofGetHeight()) {
		vel.y *= -1;
	}
}

void Orb::draw() {
	ofSetColor(color);
	ofDrawCircle(pos, radius);
}

void Orb::randomizeSpeed() {
	vel.set(ofRandom(-5, 5), ofRandom(-5, 5));
}

void Orb::changeColor() {
	color.setHsb(ofRandom(255), 200, 255);
}

// ================= ofApp ==================
ofApp::ofApp() {
	// constructor vacío
}

ofApp::~ofApp() {
	clearOrbs(); // liberar memoria en el destructor
}

void ofApp::setup() {
	ofSetBackgroundColor(30);
	ofSetFrameRate(60); // opcional: 60 FPS
}

void ofApp::update() {
	for (auto & orb : orbs) {
		orb->update();
	}
}

void ofApp::draw() {
	for (auto & orb : orbs) {
		orb->draw();
	}

	// Mostrar instrucciones en pantalla
	ofSetColor(255);
	ofDrawBitmapString("N: nuevo orb | S: cambiar velocidad | D: borrar primero | Click: cambiar colores", 20, 20);
}

void ofApp::keyPressed(int key) {
	if (key == 'n') {
		// Crear un nuevo orbe en la posición del mouse
		orbs.push_back(new Orb(ofGetMouseX(), ofGetMouseY()));
	} else if (key == 's') {
		// Cambiar velocidades de todos los orbes
		for (auto & orb : orbs) {
			orb->randomizeSpeed();
		}
	} else if (key == 'd') {
		// Borrar el primer orbe (si existe)
		if (!orbs.empty()) {
			delete orbs.front(); // liberar memoria
			orbs.erase(orbs.begin()); // quitar del vector
		}
	}
}

void ofApp::mousePressed(int x, int y, int button) {
	for (auto & orb : orbs) {
		orb->changeColor();
	}
}

void ofApp::exit() {
	clearOrbs(); // limpiar al cerrar
}

void ofApp::clearOrbs() {
	for (auto & orb : orbs) {
		if (orb) {
			delete orb;
			orb = nullptr;
		}
	}
	orbs.clear();

	// opcional: liberar también la memoria reservada por el vector
	std::vector<Orb *>().swap(orbs);
}
```
- ofApp:

```C++
#pragma once

#include "ofMain.h"
#include <vector>

class Orb {
public:
	ofVec2f pos;
	ofVec2f vel;
	ofColor color;
	float radius;

	Orb(float x = 0.0f, float y = 0.0f) {
		pos.set(x, y);
		vel.set(ofRandom(-5, 5), ofRandom(-5, 5));
		radius = ofRandom(15, 40);
		color.setHsb(ofRandom(255), 200, 255);
	}

	~Orb() = default; // no hay memoria dinámica interna en Orb

	void update();
	void draw();
	void randomizeSpeed();
	void changeColor();
};

class ofApp : public ofBaseApp {
public:
	ofApp();
	~ofApp();

	void setup();
	void update();
	void draw();

	void keyPressed(int key);
	void mousePressed(int x, int y, int button);
	void exit(); // openFrameworks llama a esto al cerrar

private:
	std::vector<Orb *> orbs;

	void clearOrbs(); // utilidad para liberar memoria
};
```

**VIDEO:**

[Evidencias del reto de la unidad 4 (Video)](https://youtu.be/6Y23rTZdxrc)
