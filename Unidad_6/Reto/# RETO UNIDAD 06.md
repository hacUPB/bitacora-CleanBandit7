# RETO UNIDAD 06

### Sesión 3: revisión de la teoría y caso de estudio

En esta sesión de trabajo por fuera de aula continuarás el proceso de análisis y experimentación.

## **Reto**

Desarrolla un proyecto de arte generativo interactivo en tiempo real. Diferente, lo más que puedas al caso de estudio.

### Requisitos

- Utilizando **C++** y **openFrameworks**.
- Aplica el patrón de diseño **Observer**.
- Aplica el patrón de diseño **Factory**.
- Aplica el patrón de diseño **State**.
- Realiza pruebas desde el inicio del desarrollo para garantizar el correcto funcionamiento de la aplicación.

### Evidencias de los resultados de aprendizaje

<aside>
⚠️

**MUY IMPORTANTE** 
¿Recuerdas los resultados de aprendizaje específicos (RAE) de este curso?

- RAE1: construyo aplicaciones interactivas aplicando patrones y estrategias que permitan alcanzar los requisitos funcionales y no funcionales establecidos. Se espera que llegues a un nivel resolutivo.
- RAE2: aplico pruebas de las partes y del todo de un software siguiendo metodologías, técnicas y estándares de la industria para garantizar el correcto funcionamiento de las aplicaciones. Se espera que llegues a un nivel autónomo.
</aside>

El RAE1 lo evidenciarás con:

- La construcción de la aplicación que propone el reto.
- La explicación de para qué y cómo implementaste cada patrón.
- El código fuente de tu aplicación.
- Un link a un video que muestre en funcionamiento la aplicación.

El RAE2 lo evidenciarás con:

- Explica y muestra cómo probaste cada patrón.
- Explica y muestra cómo probaste toda la aplicación.

## SOLUCIÓN:

- Primer Código Funcional:

    ofApp.h:

    ```C++
    #pragma once
    #include "ofMain.h"
    #include <string>
    #include <vector>


    // Patrón OBSERVER
    class Observer {
    public:
        virtual void onNotify(const std::string & event) = 0;
    };

    class Subject {
    public:
        void addObserver(Observer * observer);
        void removeObserver(Observer * observer);

    protected:
        void notify(const std::string & event);

    private:
        std::vector<Observer *> observers;
    };


    // Adelanto de la clase Particle
    class Particle;


    // Patrón STATE: Estados para las estaciones
    class State {
    public:
        virtual void update(Particle * particle) = 0;
        virtual void onEnter(Particle * particle) { }
        virtual void onExit(Particle * particle) { }
        virtual ~State() = default;
    };

    class SummerState;
    class AutumnState;
    class WinterState;
    class SpringState;

    // Clase Particle (Observer)
    class Particle : public Observer {
    public:
        Particle();
        ~Particle();

        void update();
        void draw();
        void onNotify(const std::string & event) override;
        void setState(State * newState);

        ofVec2f position;
        ofVec2f velocity;
        float size;
        ofColor color;

    private:
        State * state;
    };


    // 🧩 Patrón FACTORY - Creador de partículas
    class ParticleFactory {
    public:
        static Particle * createParticle();
    };

    // Clase principal de la app
    class ofApp : public ofBaseApp, public Subject {
    public:
        void setup();
        void update();
        void draw();
        void keyPressed(int key);
        void mousePressed(int x, int y, int button);
        void exit(); // para limpiar memoria

    private:
        std::vector<Particle *> particles;
    };
    ```
    ofApp.cpp:

    ```C++
    #include "ofApp.h"

    //--------------------------------------------------------------
    // Subject (Observer pattern)
    //--------------------------------------------------------------
    void Subject::addObserver(Observer * observer) {
        observers.push_back(observer);
    }

    void Subject::removeObserver(Observer * observer) {
        observers.erase(std::remove(observers.begin(), observers.end(), observer), observers.end());
    }

    void Subject::notify(const std::string & event) {
        for (Observer * observer : observers) {
            observer->onNotify(event);
        }
    }

    //--------------------------------------------------------------
    // Estados (State Pattern)
    //--------------------------------------------------------------
    class SummerState : public State {
    public:
        void update(Particle * particle) override;
        void onEnter(Particle * particle) override;
    };

    class AutumnState : public State {
    public:
        void update(Particle * particle) override;
        void onEnter(Particle * particle) override;
    };

    class WinterState : public State {
    public:
        void update(Particle * particle) override;
        void onEnter(Particle * particle) override;
    };

    class SpringState : public State {
    public:
        void update(Particle * particle) override;
        void onEnter(Particle * particle) override;
    };

    //--------------------------------------------------------------
    // Particle
    //--------------------------------------------------------------
    Particle::Particle() {
        position = ofVec2f(ofRandomWidth(), ofRandomHeight());
        velocity = ofVec2f(ofRandom(-1, 1), ofRandom(-1, 1));
        size = ofRandom(4, 8);
        color = ofColor::yellow;
        state = new SummerState();
    }

    Particle::~Particle() {
        delete state;
    }

    void Particle::setState(State * newState) {
        if (state != nullptr) {
            state->onExit(this);
            delete state;
        }
        state = newState;
        if (state != nullptr) {
            state->onEnter(this);
        }
    }

    void Particle::update() {
        if (state != nullptr) {
            state->update(this);
        }
    }

    void Particle::draw() {
        ofSetColor(color);
        ofDrawCircle(position, size);
    }

    void Particle::onNotify(const std::string & event) {
        if (event == "summer")
            setState(new SummerState());
        else if (event == "autumn")
            setState(new AutumnState());
        else if (event == "winter")
            setState(new WinterState());
        else if (event == "spring")
            setState(new SpringState());
    }

    //--------------------------------------------------------------
    // Comportamientos por estado
    //--------------------------------------------------------------
    void SummerState::onEnter(Particle * particle) {
        particle->color = ofColor::yellow;
        particle->size = ofRandom(4, 8);
    }

    void SummerState::update(Particle * particle) {
        // Movimiento rápido y aleatorio
        particle->position += particle->velocity * 3.0;
        if (particle->position.x < 0 || particle->position.x > ofGetWidth()) particle->velocity.x *= -1;
        if (particle->position.y < 0 || particle->position.y > ofGetHeight()) particle->velocity.y *= -1;
    }

    void AutumnState::onEnter(Particle * particle) {
        particle->color = ofColor(165, 42, 42); // Café
    }

    void AutumnState::update(Particle * particle) {
        // Caída hacia abajo
        particle->position.y += 2.5;
        if (particle->position.y > ofGetHeight()) particle->position.y = 0;
    }

    void WinterState::onEnter(Particle * particle) {
        particle->color = ofColor::white;
        particle->velocity = ofVec2f(0, 0);
    }

    void WinterState::update(Particle * particle) {
        // Quietas (sin movimiento)
    }

    void SpringState::onEnter(Particle * particle) {
        particle->color = ofColor(255, 105, 180); // Rosado
        particle->size = ofRandom(10, 15); // Partículas más grandes
    }

    void SpringState::update(Particle * particle) {
        // Movimiento moderado
        particle->position += ofVec2f(ofRandom(-1.5, 1.5), ofRandom(-1.5, 1.5));
    }

    //--------------------------------------------------------------
    // Factory
    //--------------------------------------------------------------
    Particle * ParticleFactory::createParticle() {
        Particle * p = new Particle();
        return p;
    }

    //--------------------------------------------------------------
    // ofApp
    //--------------------------------------------------------------
    void ofApp::setup() {
        ofBackground(0);
    }

    void ofApp::update() {
        for (Particle * p : particles) {
            p->update();
        }
    }

    void ofApp::draw() {
        for (Particle * p : particles) {
            p->draw();
        }

        ofSetColor(255);
        ofDrawBitmapString("Presiona V (verano), O (otoño), I (invierno), P (primavera)", 20, 20);
    }

    void ofApp::keyPressed(int key) {
        if (key == 'v' || key == 'V')
            notify("summer");
        else if (key == 'o' || key == 'O')
            notify("autumn");
        else if (key == 'i' || key == 'I')
            notify("winter");
        else if (key == 'p' || key == 'P')
            notify("spring");
    }

    void ofApp::mousePressed(int x, int y, int button) {
        Particle * p = ParticleFactory::createParticle();
        p->position = ofVec2f(x, y);
        particles.push_back(p);
        addObserver(p);
    }

    void ofApp::exit() {
        // Limpieza de memoria
        for (Particle * p : particles) {
            delete p;
        }
        particles.clear();
    }
    ```

Por ahora, el código es funcional más sin embargo, le quiero cambiar de que cuando se clickee, se genere de a una partícula y que más bien, cuando se oprima cualquiera de los botones de los estados, se generen varias partículas  con las características pertenecientes a cada uno. Además, me gustaría que cuando se oprima la I de invierno, las partículas no se desplazen automáticamente sino que se generen específicamente siguiendo el cursor del mouse y queden pausadas ahí.
Otros aspectos a mejorar es que cuando se cambia de estado, al retornar a verano después de cambiar a invierno, las partículas no se mueven sino que se quedan estáticas y que cuando está en primavera, las partículas vibran pero no quiero eso, me gustaría que más bien, se muevan con poca rapidez y que se generen partículas más grandes.
Finalmente, que cuando está en estado de otoño, las partículas caigan y se queden acumuladas en el fondo de la pantalla.


**EVIDENCIAS:**

![alt text](<../Evidencias/Captura de pantalla 2025-10-08 174919.png>)

![alt text](<../Evidencias/Captura de pantalla 2025-10-08 174931.png>)

![alt text](<../Evidencias/Captura de pantalla 2025-10-08 174943.png>)

![alt text](<../Evidencias/Captura de pantalla 2025-10-08 174951.png>)


**ANOTACIONES:**

- En este caso, la máquina de estados funciona, permitiendo que cada vez que se ejecuta una acción de cambio (en este caso, que se oprime un botón), se cambia a uno de los estados denotados y esto se entrelaza con el método observer ya que cuando se cambia de estado, se notifica a las partículas que se cambió de estado y estas cambian sus características y comportamiento dependieno de en qué estado están, conectando estos dos métodos con el método de fábrica ya que ahora, cuando de la interfaz que está ligada a la fábrica madre, se creen partículas, estas se van a generar con base al estado en que se encuentra el programa.



**PRUEBAS DE FUNCIONAMIENTO (CLASE CLEAR PARA BORRAR PARTÍCULAS CUANDO SE OPRIMA LA TECLA 'D')**

En el código actual, funcionan de manera adecuada todas las funciones propuestas al inicio del reto, lo único que le hace falta y que quise agregar después de probar el programa es la adición de una función que permita borrar las partículas cuando el usuario lo desee y de paso, probarlo en el código actual para ver su correcto funcionamiento:


**CÓDIGO ACTUAL**

ofAApp.h

```C++
#pragma once
#include "ofMain.h"
#include <memory>
#include <vector>

// ==================== OBSERVER ====================
class ParticleObserver {
public:
	virtual void onStateChange(char newState) = 0;
};

// ==================== PARTICLE ====================
class Particle : public ParticleObserver {
public:
	ofVec2f pos, vel;
	ofColor color;
	float size;
	bool stopped = false; // Para invierno

	Particle(ofVec2f p, ofVec2f v, ofColor c, float s)
		: pos(p)
		, vel(v)
		, color(c)
		, size(s) { }

	void update() {
		if (!stopped) pos += vel;
		// Rebotar en los bordes
		if (pos.x < 0 || pos.x > ofGetWidth()) vel.x *= -1;
		if (pos.y < 0 || pos.y > ofGetHeight()) vel.y *= -1;
	}

	void draw() {
		ofSetColor(color);
		ofDrawCircle(pos, size);
	}

	// Cambios de comportamiento según el estado
	void onStateChange(char newState) override {
		switch (newState) {
		case 'V': // Verano
			color = ofColor::yellow;
			vel = ofVec2f(ofRandom(-4, 4), ofRandom(-4, 4));
			stopped = false;
			break;
		case 'O': // Otoño
			color = ofColor(139, 69, 19); // café
			vel = ofVec2f(0, ofRandom(1, 3)); // caen lentamente
			stopped = false;
			break;
		case 'I': // Invierno
			color = ofColor::white;
			vel = ofVec2f(0, 0); // quietas
			stopped = true;
			break;
		case 'P': // Primavera
			color = ofColor(255, 182, 193); // rosado
			vel = ofVec2f(ofRandom(-1, 1), ofRandom(-1, 1)); // movimiento suave
			size = ofRandom(8, 15);
			stopped = false;
			break;
		}
	}
};

// ==================== FACTORY ====================
class ParticleFactory {
public:
	static std::shared_ptr<Particle> createParticle(char currentState, ofVec2f pos) {
		switch (currentState) {
		case 'V': // Verano
			return std::make_shared<Particle>(pos, ofVec2f(ofRandom(-4, 4), ofRandom(-4, 4)), ofColor::yellow, ofRandom(4, 8));
		case 'O': // Otoño
			return std::make_shared<Particle>(pos, ofVec2f(0, ofRandom(1, 3)), ofColor(139, 69, 19), ofRandom(4, 8));
		case 'I': // Invierno
			return std::make_shared<Particle>(pos, ofVec2f(0, 0), ofColor::white, ofRandom(4, 8));
		case 'P': // Primavera
			return std::make_shared<Particle>(pos, ofVec2f(ofRandom(-1, 1), ofRandom(-1, 1)), ofColor(255, 182, 193), ofRandom(8, 15));
		default:
			return std::make_shared<Particle>(pos, ofVec2f(0, 0), ofColor::gray, 5);
		}
	}
};

// ==================== STATE MACHINE ====================
class SeasonState {
public:
	virtual void handleInput(char key) = 0;
	virtual char getStateChar() = 0;
};

class SeasonManager : public SeasonState {
private:
	char currentState = 'V';

public:
	std::vector<ParticleObserver *> observers;

	void addObserver(ParticleObserver * o) { observers.push_back(o); }

	void notifyObservers() {
		for (auto * o : observers)
			o->onStateChange(currentState);
	}

	void handleInput(char key) override {
		if (key == 'V' || key == 'O' || key == 'I' || key == 'P') {
			currentState = key;
			notifyObservers();
		}
	}

	char getStateChar() override { return currentState; }
};

// ==================== OFAPP ====================
class ofApp : public ofBaseApp {
public:
	std::vector<std::shared_ptr<Particle>> particles;
	SeasonManager season;

	void setup();
	void update();
	void draw();
	void keyPressed(int key);
};
```

ofApp.cpp

```C++
#include "ofApp.h"

void ofApp::setup() {
	ofBackground(0);
}

void ofApp::update() {
	// Comportamiento especial para invierno: seguir el mouse
	if (season.getStateChar() == 'I') {
		// Crear partículas que sigan al mouse
		if (ofGetFrameNum() % 10 == 0) { // cada 10 frames para no saturar
			ofVec2f pos(ofGetMouseX() + ofRandom(-5, 5), ofGetMouseY() + ofRandom(-5, 5));
			auto p = ParticleFactory::createParticle('I', pos);
			season.addObserver(p.get());
			particles.push_back(p);
		}
	}

	// Actualizar partículas
	for (auto & p : particles) {
		p->update();

		// En otoño, detenerlas al tocar el fondo
		if (season.getStateChar() == 'O' && p->pos.y >= ofGetHeight() - p->size) {
			p->vel.set(0, 0);
			p->pos.y = ofGetHeight() - p->size;
		}
	}
}

void ofApp::draw() {
	for (auto & p : particles)
		p->draw();

	ofSetColor(255);
	ofDrawBitmapString("Presiona V (Verano), O (Otono), I (Invierno), P (Primavera)", 20, 20);
}

void ofApp::keyPressed(int key) {
	season.handleInput(toupper(key));

	// Generar partículas según el estado actual
	char state = season.getStateChar();
	if (state != 'I') { // en invierno no generamos por tecla, sino automático
		for (int i = 0; i < 20; i++) {
			ofVec2f pos(ofRandom(ofGetWidth()), ofRandom(ofGetHeight()));
			auto p = ParticleFactory::createParticle(state, pos);
			season.addObserver(p.get());
			particles.push_back(p);
		}
	}
}
```

**Tras tantear en el código y realizar pruebas para ver de qué manera podría abordar la función de borrar la última partícula generada, se obtuvieron los siguientes cambios:**

- Se agregó una nueva clase llamada "particleRemover" que encapsula la responsabilidad de eliminar la última partícula generada que utiliza un método estático llamado "removeLast" que recibe una refe al vector de partículas "Particles" y si no está vacío, elimina el último elemento con "pop_back()":


Representación en código:

```C++
class ParticleRemover {
public:
	static void removeLast(std::vector<std::shared_ptr<Particle>>& particles) {
		if (!particles.empty()) {
			particles.pop_back();
		}
	}
};
```

- Se integró ofApp::keyPressed(int key) lo cual permite que cada vez que se oprima la tecla 'C' se elimine la última partícula generada llamando al método estático removeLast de ParticleRemover.

Representación en código:
```C++
if (toupper(key) == 'C') {
	ParticleRemover::removeLast(particles);
}
```

- En este caso, no fue necesario modificar las clases Particle, SeasonManager ni ParticleFactory ya que estas clases se encargan únicamente de la creación y el comportamiento de las partículas, no de su eliminación.


**CÓDIGO FINAL**

ofApp.h

```C++
#pragma once
#include "ofMain.h"
#include <memory>
#include <vector>

// ==================== OBSERVER ====================
class ParticleObserver {
public:
	virtual void onStateChange(char newState) = 0;
};

// ==================== PARTICLE ====================
class Particle : public ParticleObserver {
public:
	ofVec2f pos, vel;
	ofColor color;
	float size;
	bool stopped = false; // Para invierno

	Particle(ofVec2f p, ofVec2f v, ofColor c, float s)
		: pos(p)
		, vel(v)
		, color(c)
		, size(s) { }

	void update() {
		if (!stopped) pos += vel;

		// Rebotar en los bordes
		if (pos.x < 0 || pos.x > ofGetWidth()) vel.x *= -1;
		if (pos.y < 0 || pos.y > ofGetHeight()) vel.y *= -1;
	}

	void draw() {
		ofSetColor(color);
		ofDrawCircle(pos, size);
	}

	// Cambios de comportamiento según el estado
	void onStateChange(char newState) override {
		switch (newState) {
		case 'V': // Verano
			color = ofColor::yellow;
			vel = ofVec2f(ofRandom(-4, 4), ofRandom(-4, 4));
			stopped = false;
			break;
		case 'O': // Otoño
			color = ofColor(139, 69, 19); // café
			vel = ofVec2f(0, ofRandom(1, 3)); // caen lentamente
			stopped = false;
			break;
		case 'I': // Invierno
			color = ofColor::white;
			vel = ofVec2f(0, 0); // quietas
			stopped = true;
			break;
		case 'P': // Primavera
			color = ofColor(255, 182, 193); // rosado
			vel = ofVec2f(ofRandom(-1, 1), ofRandom(-1, 1)); // movimiento suave
			size = ofRandom(8, 15);
			stopped = false;
			break;
		}
	}
};

// ==================== FACTORY ====================
class ParticleFactory {
public:
	static std::shared_ptr<Particle> createParticle(char currentState, ofVec2f pos) {
		switch (currentState) {
		case 'V': // Verano
			return std::make_shared<Particle>(pos, ofVec2f(ofRandom(-4, 4), ofRandom(-4, 4)), ofColor::yellow, ofRandom(4, 8));
		case 'O': // Otoño
			return std::make_shared<Particle>(pos, ofVec2f(0, ofRandom(1, 3)), ofColor(139, 69, 19), ofRandom(4, 8));
		case 'I': // Invierno
			return std::make_shared<Particle>(pos, ofVec2f(0, 0), ofColor::white, ofRandom(4, 8));
		case 'P': // Primavera
			return std::make_shared<Particle>(pos, ofVec2f(ofRandom(-1, 1), ofRandom(-1, 1)), ofColor(255, 182, 193), ofRandom(8, 15));
		default:
			return std::make_shared<Particle>(pos, ofVec2f(0, 0), ofColor::gray, 5);
		}
	}
};

// ==================== STATE MACHINE ====================
class SeasonState {
public:
	virtual void handleInput(char key) = 0;
	virtual char getStateChar() = 0;
};

class SeasonManager : public SeasonState {
private:
	char currentState = 'V';

public:
	std::vector<ParticleObserver *> observers;

	void addObserver(ParticleObserver * o) { observers.push_back(o); }

	void notifyObservers() {
		for (auto * o : observers)
			o->onStateChange(currentState);
	}

	void handleInput(char key) override {
		if (key == 'V' || key == 'O' || key == 'I' || key == 'P') {
			currentState = key;
			notifyObservers();
		}
	}

	char getStateChar() override { return currentState; }
};

// ==================== OFAPP ====================
class ofApp : public ofBaseApp {
public:
	std::vector<std::shared_ptr<Particle>> particles;
	SeasonManager season;

	void setup();
	void update();
	void draw();
	void keyPressed(int key);

private:
	void removeLastParticle(); // 👈 Nueva función
};
```

ofApp.cpp
```C++
#include "ofApp.h"

void ofApp::setup() {
	ofBackground(0);
}

void ofApp::update() {
	// Comportamiento especial para invierno: seguir el mouse
	if (season.getStateChar() == 'I') {
		// Crear partículas que sigan al mouse
		if (ofGetFrameNum() % 10 == 0) { // cada 10 frames para no saturar
			ofVec2f pos(ofGetMouseX() + ofRandom(-5, 5), ofGetMouseY() + ofRandom(-5, 5));
			auto p = ParticleFactory::createParticle('I', pos);
			season.addObserver(p.get());
			particles.push_back(p);
		}
	}

	// Actualizar partículas
	for (auto & p : particles) {
		p->update();

		// En otoño, detenerlas al tocar el fondo
		if (season.getStateChar() == 'O' && p->pos.y >= ofGetHeight() - p->size) {
			p->vel.set(0, 0);
			p->pos.y = ofGetHeight() - p->size;
		}
	}
}

void ofApp::draw() {
	for (auto & p : particles)
		p->draw();

	ofSetColor(255);
	ofDrawBitmapString("Presiona V (Verano), O (Otono), I (Invierno), P (Primavera)", 20, 20);
	ofDrawBitmapString("Presiona C para borrar la última partícula", 20, 40);
}

// 👇 Nueva función: elimina la última partícula creada
void ofApp::removeLastParticle() {
	if (!particles.empty()) {
		particles.pop_back();
	}
}

void ofApp::keyPressed(int key) {
	char pressed = toupper(key);
	season.handleInput(pressed);

	// Generar partículas según el estado actual
	char state = season.getStateChar();

	if (pressed == 'C') { // 👈 Si se presiona C
		removeLastParticle();
		return;
	}

	if (state != 'I') { // en invierno no generamos por tecla, sino automático
		for (int i = 0; i < 20; i++) {
			ofVec2f pos(ofRandom(ofGetWidth()), ofRandom(ofGetHeight()));
			auto p = ParticleFactory::createParticle(state, pos);
			season.addObserver(p.get());
			particles.push_back(p);
		}
	}
}
```

**LINK AL VIDEO DE FUNCIONAMIENTO DE LA APLICACIÓN**

https://youtu.be/L__kVmTdDbc