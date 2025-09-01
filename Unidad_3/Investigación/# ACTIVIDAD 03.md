# ACTIVIDAD 03

Analiza la aplicación anterior. ¿Qué hace cada función? ¿Qué hace cada línea de código? Realiza un experimento con la aplicación anterior. Modifica alguna parte importante de su código.

```C++
#include "ofApp.h"

//--------------------------------------------------------------
void ofApp::setup() { // Sirve como "pseudoestado" para establecer las condiciones iniciales del código, como el fondo de pantalla y el color de las particulas.
	ofBackground(0); //Establece que el fondo va a ser de color negro
	particleColor = ofColor::white; //El color predeterminado de las particulas generadas va a ser de color blanco.
}

//--------------------------------------------------------------
void ofApp::update() {
} //Sirve como clase de actualización de datos, para que cada vez que el código se ejecute, se vayan generando actualizaciones en cada uno de los objetos.

//--------------------------------------------------------------
void ofApp::draw() { // Sirve para dibujar en pantalla el vector de círculos.
	for (auto & pos : particles) {
		ofSetColor(particleColor); // Se establece como predeterminado del circulo el color establecido para las particulas
		ofDrawCircle(pos.x, pos.y, 50); //Permite generar un circulo en la posición en x y y que se establezcan pero siempre con un radio de 50 pixels.
	}
}

//--------------------------------------------------------------
void ofApp::mouseMoved(int x, int y) { //Sirve para establecer el movimiento del mouse y su relación con la dirección de vectores.
	particles.push_back(ofVec2f(x, y)); // Establece un vector en las coordenadas x y y en las que se mueva el mouse.
	if (particles.size() > 5) {
		particles.erase(particles.begin()); // Se genera un condicional que indica que si el número de particulas generadas es > 5, las primeras partículas del vector, en este caso los primeros círculos, se borren para ser reemplazados por los que se generen de últimas.
	}
}

//--------------------------------------------------------------
void ofApp::mousePressed(int x, int y, int button) { // Sirve para establecer la relación entre el click del mouse y el vector de círculos generado
	particleColor = ofColor(ofRandom(255), ofRandom(255), ofRandom(255)); // Establece que cuando en el mouse se presione el click, el color de los círculos se cambie a un color random.
}
```

- En este caso, el cambio que le hice al código fue modificar el límite de partículas que se pueden generar antes de que las primeras particulas del vector sean borradas, así el vector pasa de ser una larga secuencia de circulos a un pequeño "gusanito".
