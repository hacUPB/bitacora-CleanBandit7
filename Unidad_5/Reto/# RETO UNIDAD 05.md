# RETO UNIDAD 05

Ahora es momento de aplicar todo lo que has aprendido. En estas sesiones, crearás tu propio proyecto de arte generativo en openFrameworks, utilizando la programación orientada a objetos de manera consciente y fundamentada. Cada decisión que tomes estará basada en una comprensión profunda de cómo funcionan los objetos, datos y métodos en la memoria. Además, documentarás este proceso en tu bitácora, reflejando tus descubrimientos y aprendizajes. ¡Es tu oportunidad para transformar el conocimiento en creatividad!

Objetivo: implementar un proyecto de arte generativo, documentando en detalle cómo se aplican e impactan las abstracciones de OOP en el proyecto.

### Enunciado

- Diseñar y desarrollar un proyecto de arte generativo utilizando openFrameworks.
- Aplicar conceptos de encapsulamiento, herencia y polimorfismo.
- Ejemplos de proyectos: sistema de partículas con comportamientos variados, generación procedimental de formas y patrones. Prompt para ChatGPT: ¿Puedes ayudarme a diseñar un proyecto de arte generativo en C++ utilizando openFrameworks que utilice encapsulamiento, herencia y polimorfismo? Quiero implementar un sistema de partículas con diferentes comportamientos.

### Reflexión y ajuste Final

- Realizar pruebas finales y ajustes.
- Asegurar que el código sigue buenas prácticas de OOP.
- ¿Cómo influyó el entendimiento de los mecanismos internos de OOP en el proyecto?
- ¿Qué desafíos enfrentaste y cómo los superaste?
- ¿Qué aprendiste sobre el equilibrio entre diseño y eficiencia?



### CÓDIGO FINAL DEL ARTE GENERATIVO

- ofApp.h:

```C++
#pragma once
#include "Particles.h"
#include "ofMain.h"


class ofApp : public ofBaseApp {
public:
	void setup() override;
	void update() override;
	void draw() override;
	void exit() override;

	void keyPressed(int key) override;
	void keyReleased(int key) override;
	void mousePressed(int x, int y, int button) override;
	void mouseDragged(int x, int y, int button) override;

private:
	std::deque<Particle *> particles; // usamos punteros crudos y new/delete
	//ofImage rabbitImage; // imagen cargada en setup
	//bool rabbitLoaded = false;

	bool holeActive = false;
	float holeRadius = 100.0f;

	// helpers
	void spawnDefaultParticle(const ofVec2f & pos);
	void spawnBlueParticles(const ofVec2f & pos, int count = 6);
	//void spawnImageParticles(const ofVec2f & pos, int count = 4);
	void spawnAbsorberParticles(const ofVec2f & pos, int count = 1);
	void removeOldestParticle(); // tecla D
	void applyHole();
	void handleCollisions();

	// limpieza segura
	void clearAllParticles();
    ```

    - ofApp.cpp:

    ```C++

    #include "ofApp.h"
#include "Particles.h"

// ---------------- setup ----------------
void ofApp::setup() {
	ofSetFrameRate(60);
	ofBackground(20);
	//rabbitLoaded = rabbitImage.load("rabbit.png"); // poner rabbit.png en bin/data/
	//if (!rabbitLoaded) ofLogWarning() << "No se cargo rabbit.png en bin/data/";

	// crear algunas partículas iniciales
	for (int i = 0; i < 20; i++) {
		spawnDefaultParticle(ofVec2f(ofRandomWidth(), ofRandomHeight()));
	}
}

void ofApp::exit() {
	// liberar toda la memoria antes de salir
	clearAllParticles();
}

// ---------------- update ----------------
void ofApp::update() {
	float dt = ofGetLastFrameTime();

	for (auto p : particles) {
		p->update(dt);
	}

	handleCollisions();

	if (holeActive) applyHole();

	// borrar partículas marcadas (recorrer y eliminar con delete)
	for (auto it = particles.begin(); it != particles.end();) {
		Particle * p = *it;
		if (p->isRemovable()) {
			delete p;
			it = particles.erase(it);
		} else
			++it;
	}

	// opcional: limitar número máximo de partículas para evitar petadas
	const size_t MAX_PARTICLES = 4000;
	while (particles.size() > MAX_PARTICLES) {
		delete particles.front();
		particles.pop_front();
	}
}

// ---------------- draw ----------------
void ofApp::draw() {
	for (auto p : particles)
		p->draw();

	ofSetColor(255);
	ofDrawBitmapString("B: spawn blue | R: spawn rabbit image | K: spawn absorber | D: delete oldest | Hold H: hole", 10, 15);
	ofDrawBitmapString("Particles: " + ofToString(particles.size()), 10, 30);

	if (holeActive) {
		ofSetColor(255, 100, 100, 120);
		ofDrawCircle(ofGetMouseX(), ofGetMouseY(), holeRadius);
	}
}

// ---------------- inputs ----------------
void ofApp::keyPressed(int key) {
	ofVec2f mpos(ofGetMouseX(), ofGetMouseY());
	if (key == 'b' || key == 'B') {
		spawnBlueParticles(mpos, 12);
	//} else if (key == 'r' || key == 'R') {
		//spawnImageParticles(mpos, 8);
	} else if (key == 'k' || key == 'K') {
		spawnAbsorberParticles(mpos, 1);
	} else if (key == 'd' || key == 'D') {
		removeOldestParticle();
	} else if (key == 'h' || key == 'H') {
		holeActive = true;
	}
}

void ofApp::keyReleased(int key) {
	if (key == 'h' || key == 'H') {
		holeActive = false;
	}
}

void ofApp::mousePressed(int x, int y, int button) {
	spawnDefaultParticle(ofVec2f(x, y));
}

void ofApp::mouseDragged(int x, int y, int button) {
	for (int i = 0; i < 3; i++)
		spawnDefaultParticle(ofVec2f(x + ofRandom(-6, 6), y + ofRandom(-6, 6)));
}

// ---------------- helpers ----------------
void ofApp::spawnDefaultParticle(const ofVec2f & pos) {
	Particle *p = new Particle(pos, ofRandom(4, 10));
	particles.push_back(p);
}

void ofApp::spawnBlueParticles(const ofVec2f & pos, int count) {
	for (int i = 0; i < count; i++) {
		Particle * p = new BlueParticle(pos + ofVec2f(ofRandom(-10, 10), ofRandom(-10, 10)), ofRandom(4, 18));
		particles.push_back(p);
	}
}

void ofApp::spawnAbsorberParticles(const ofVec2f & pos, int count) {
	for (int i = 0; i < count; i++) {
		Particle * p = new AbsorberParticle(pos + ofVec2f(ofRandom(-6, 6), ofRandom(-6, 6)), ofRandom(12, 28));
		particles.push_back(p);
	}
}

void ofApp::removeOldestParticle() {
	if (!particles.empty()) {
		delete particles.front();
		particles.pop_front();
	}
}

void ofApp::applyHole() {
	ofVec2f mpos(ofGetMouseX(), ofGetMouseY());
	// eliminar partículas dentro del radio del hoyo
	for (auto it = particles.begin(); it != particles.end();) {
		Particle * p = *it;
		if (p->getPosition().distance(mpos) < holeRadius) {
			delete p;
			it = particles.erase(it);
		} else
			++it;
	}
}

void ofApp::handleCollisions() {
	// O(n^2) simple: para muchos particles esto se vuelve lento -> optimizar si hace falta
	for (size_t i = 0; i < particles.size(); ++i) {
		for (size_t j = i + 1; j < particles.size(); ++j) {
			Particle * pi = particles[i];
			Particle * pj = particles[j];
			float dist = pi->getPosition().distance(pj->getPosition());
			if (dist < (pi->getRadius() + pj->getRadius())) {
				// llamar a onCollide de ambos
				pi->onCollide(pj);
				pj->onCollide(pi);
			}
		}
	}
}

void ofApp::clearAllParticles() {
	for (auto p : particles)
		delete p;
	particles.clear();
}
```

**LINK VIDEO DE PRUEBA**

[Video En Youtube](https://youtu.be/3hJ-yAv476I)

**PREGUNTAS DE REFLEXIÓN**

- ¿Cómo influyó el entendimiento de los mecanismos internos de OOP en el proyecto?

RTA: De manera que permitió tener mejor organización sobre la implementación de clases y métodos, ayudando a que gracias a las características de la herencia se puediera reutilizar código u organizar objetos de manera no tan rebundante y bien estructurada.

- ¿Qué desafíos enfrentaste y cómo los superaste?

RTA: Que hubo un momento donde el código no quería funcionar ya que una de los archivos .h no aparecía registrado dentro de la carpeta del proyecto, así que tocó moverlo dentro de la carpeta y también, tocó eliminar algunas de las características iniciales del programa, ya que estas no solo impedían la depuración del mismo.

- ¿Qué aprendiste sobre el equilibrio entre diseño y eficiencia?

RTA: Que a veces, es mejor priorizar el funcionamiento del programa en vez de las multifuncionalidades ya que estas conllevan a mayor riesgo a la hora de estructurarlo y si uno se enfoca unicamente en ellas, pierde la noción de la eficiencia.