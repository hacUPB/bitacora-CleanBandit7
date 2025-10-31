# RETO UNIDAD 3

### **Requisitos de la aplicación**

1. **Generación de esferas:** utiliza bucles anidados para generar posiciones de esferas en una cuadrícula tridimensional. Las posiciones deben almacenarse en un vector de `ofVec3f`.
2. **Interacción con el ratón:** implementa la funcionalidad para seleccionar una esfera con el ratón. Al seleccionar una esfera, debes mostrar sus coordenadas en pantalla.
3. **Interacción con el teclado:** implementa controles básicos para modificar la separación entre esferas, la amplitud de sus posiciones en el eje Z, y otros parámetros visuales.
4. **Visualización:** utiliza una cámara 3D (`ofEasyCam`) para permitir la exploración de la escena desde diferentes ángulos.

1. **Generación de esferas:** utiliza bucles anidados para generar posiciones de esferas en una cuadrícula tridimensional. Las posiciones deben almacenarse en un vector de `ofVec3f`.
2. **Interacción con el ratón:** implementa la funcionalidad para seleccionar una esfera con el ratón. Al seleccionar una esfera, debes mostrar sus coordenadas en pantalla.
3. **Interacción con el teclado:** implementa controles básicos para modificar la separación entre esferas, la amplitud de sus posiciones en el eje Z, y otros parámetros visuales.
4. **Visualización:** utiliza una cámara 3D (`ofEasyCam`) para permitir la exploración de la escena desde diferentes ángulos.

### Análisis de Memoria

Además de implementar la aplicación, debes analizar cómo y dónde se almacenan los datos en la memoria. Para ello:

1. **Investiga:** investiga cómo se gestionan los vectores de `ofVec3f` en C++. ¿Dónde se almacenan? ¿En qué parte de la memoria se guardan los objetos y cómo se gestionan?
2. **Experimenta:** utiliza el depurador de Visual Studio para examinar la memoria de la aplicación en tiempo de ejecución. Observa en qué parte de la memoria se encuentran los objetos (`stack`, `heap`, memoria global).
3. **Documenta:** documenta tus hallazgos en un informe breve, explicando qué descubriste sobre la gestión de la memoria en tu aplicación.


**SOLUCIÓN:**

1. Código:

```C++
//ofApp.h
#pragma once
#include "ofMain.h"

class ofApp : public ofBaseApp {
public:
	void setup();
	void update();
	void draw();

	void keyPressed(int key);
	void mousePressed(int x, int y, int button);

	void convertMouseToRay(int mouseX, int mouseY, glm::vec3 & rayStart, glm::vec3 & rayEnd);
	bool rayIntersectsSphere(const glm::vec3 & rayStart, const glm::vec3 & rayDir,
		const glm::vec3 & sphereCenter, float sphereRadius,
		glm::vec3 & intersectionPoint);

	// Cámara
	ofEasyCam cam;

	// Posiciones de las esferas
	vector<glm::vec3> spherePositions;

	// Parámetros
	int xStep, yStep;
	float distDiv, amplitud;
	float sphereRadius;

	// Selección
	bool sphereSelected;
	glm::vec3 selectedSpherePos;
};
```

```C++
//ofApp.cpp

#include "ofApp.h"

//--------------------------------------------------------------
void ofApp::setup() {
	ofBackground(200);
	ofSetFrameRate(60);

	xStep = 20;
	yStep = 20;
	distDiv = 50.0f;
	amplitud = 150.0f;
	sphereRadius = 5.0f;

	sphereSelected = false;

	// Generar cuadrícula inicial
	for (int x = -ofGetWidth() / 2; x < ofGetWidth() / 2; x += xStep) {
		for (int y = -ofGetHeight() / 2; y < ofGetHeight() / 2; y += yStep) {
			float z = cos(ofDist(x, y, 0, 0) / distDiv) * amplitud;
			spherePositions.push_back(glm::vec3(x, y, z));
		}
	}
}

//--------------------------------------------------------------
void ofApp::update() {
	spherePositions.clear();
	for (int x = -ofGetWidth() / 2; x < ofGetWidth() / 2; x += xStep) {
		for (int y = -ofGetHeight() / 2; y < ofGetHeight() / 2; y += yStep) {
			float z = cos(ofDist(x, y, 0, 0) / distDiv) * amplitud;
			spherePositions.push_back(glm::vec3(x, y, z));
		}
	}
}

//--------------------------------------------------------------
void ofApp::draw() {
	cam.begin();

	ofSetColor(255, 150, 0);
	for (auto & pos : spherePositions) {
		if (sphereSelected && pos == selectedSpherePos) {
			ofSetColor(0, 255, 0); // esfera seleccionada en verde
			ofDrawSphere(pos, sphereRadius * 1.5);
			ofSetColor(255, 150, 0);
		} else {
			ofDrawSphere(pos, sphereRadius);
		}
	}

	cam.end();

	// HUD
	ofSetColor(0);
	ofDrawBitmapString("FPS: " + ofToString(ofGetFrameRate()), 20, 20);
	ofDrawBitmapString("Step: " + ofToString(xStep), 20, 40);
	ofDrawBitmapString("DistDiv: " + ofToString(distDiv), 20, 60);
	ofDrawBitmapString("Amplitud: " + ofToString(amplitud), 20, 80);

	if (sphereSelected) {
		ofDrawBitmapString("Seleccionada: " + ofToString(selectedSpherePos.x) + ", " + ofToString(selectedSpherePos.y) + ", " + ofToString(selectedSpherePos.z),
			20, 100);
	}
}

//--------------------------------------------------------------
void ofApp::keyPressed(int key) {
	if (key == OF_KEY_UP) amplitud += 10;
	if (key == OF_KEY_DOWN) amplitud -= 10;
	if (key == OF_KEY_RIGHT) distDiv += 2;
	if (key == OF_KEY_LEFT) distDiv -= 2;
	if (key == '+') {
		xStep += 2;
		yStep += 2;
	}
	if (key == '-') {
		xStep -= 2;
		yStep -= 2;
	}
}

//--------------------------------------------------------------
void ofApp::mousePressed(int x, int y, int button) {
	glm::vec3 rayStart, rayEnd;
	convertMouseToRay(x, y, rayStart, rayEnd);

	sphereSelected = false;
	for (auto & pos : spherePositions) {
		glm::vec3 intersectionPoint;
		if (rayIntersectsSphere(rayStart, rayEnd - rayStart, pos, sphereRadius, intersectionPoint)) {
			sphereSelected = true;
			selectedSpherePos = pos;
			break;
		}
	}
}

//--------------------------------------------------------------
void ofApp::convertMouseToRay(int mouseX, int mouseY, glm::vec3 & rayStart, glm::vec3 & rayEnd) {
	glm::mat4 modelview = cam.getModelViewMatrix();
	glm::mat4 projection = cam.getProjectionMatrix();
	ofRectangle viewport = ofGetCurrentViewport();

	float x = 2.0f * (mouseX - viewport.x) / viewport.width - 1.0f;
	float y = 1.0f - 2.0f * (mouseY - viewport.y) / viewport.height;

	glm::vec4 rayStartNDC(x, y, -1.0f, 1.0f);
	glm::vec4 rayEndNDC(x, y, 1.0f, 1.0f);

	glm::vec4 rayStartWorld = glm::inverse(projection * modelview) * rayStartNDC;
	glm::vec4 rayEndWorld = glm::inverse(projection * modelview) * rayEndNDC;

	rayStartWorld /= rayStartWorld.w;
	rayEndWorld /= rayEndWorld.w;

	rayStart = glm::vec3(rayStartWorld);
	rayEnd = glm::vec3(rayEndWorld);
}

//--------------------------------------------------------------
bool ofApp::rayIntersectsSphere(const glm::vec3 & rayStart, const glm::vec3 & rayDir,
	const glm::vec3 & sphereCenter, float sphereRadius,
	glm::vec3 & intersectionPoint) {
	glm::vec3 oc = rayStart - sphereCenter;

	float a = glm::dot(rayDir, rayDir);
	float b = 2.0f * glm::dot(oc, rayDir);
	float c = glm::dot(oc, oc) - sphereRadius * sphereRadius;

	float discriminant = b * b - 4 * a * c;
	if (discriminant < 0) return false;

	float t = (-b - sqrt(discriminant)) / (2.0f * a);
	intersectionPoint = rayStart + t * rayDir;
	return true;
}
```



2. Funcionamiento:

 1. Memoria de Programa: Todo el código fuente escrito en los archivos ofApp.cpp, ofApp.h y main.cpp se almacena en la sección de memoria reservada para el programa. Esta parte contiene las instrucciones ejecutables y no se modifica en tiempo de ejecución.

 2. Memoria Estática y Global: Dentro de la clase ofApp, se declaran variables como xStep, yStep, distDiv, amplitud y sphereRadius. Estas variables se almacenan en la sección de datos de la memoria, ya que son atributos de la clase y se crean cuando la aplicación inicia.
 De igual manera, variables booleanas como sphereSelected y el vector selectedSpherePos forman parte de esta memoria mientras la aplicación está activa.

 3.Memoria Dinámica (Heap): El contenedor vector<glm::vec3> spherePositions utiliza memoria dinámica (heap). Cada vez que se hace un push_back dentro del setup() o update(), el vector va reservando memoria adicional para almacenar las posiciones de las esferas. Cuando se llama a spherePositions.clear(), se libera el contenido pero la memoria reservada puede no reducirse inmediatamente (queda lista para reutilizarse). También, la función std::make_shared<ofApp>() en main.cpp reserva memoria dinámica para el objeto principal de la aplicación, garantizando su existencia mientras corre el programa y liberándola automáticamente al terminar gracias al uso de punteros inteligentes (shared_ptr).

 4. Memoria de Pila (Stack): Variables locales declaradas dentro de funciones como rayStart, rayEnd, rayStartNDC, rayEndNDC, o el cálculo de valores como z en los bucles, se almacenan en la pila (stack). Estas variables son temporales y se eliminan automáticamente al salir del ámbito de la función.

 5. Recursos Gráficos y Cámara: La clase ofEasyCam cam maneja internamente estructuras de OpenGL para la proyección y vista en 3D. Estos recursos gráficos se gestionan principalmente en memoria de GPU, aunque las referencias y configuraciones (como matrices de proyección y modelView) viven en memoria del CPU.



3. Link Video de Prueba: 
https://youtube.com/shorts/iQcNKTBNYTA?feature=share
