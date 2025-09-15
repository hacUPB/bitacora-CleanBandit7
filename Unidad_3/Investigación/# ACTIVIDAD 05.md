# ACTIVIDAD 05

En la unidad anterior introdujimos el concepto de puntero. Ahora vamos a profundizar en este concepto de manera práctica.

El siguiente ejemplo se supone (en la actividad que sigue vas a corregir un error) que te permite seleccionar una espera y moverla con el mouse.

Modifica el archivo "ofApp.h" de la siguiente manera:

```C++
#pragma once

#include "ofMain.h"


class Sphere {
public:
    Sphere(float x, float y, float radius);
    void draw();
    void update(float x, float y);
    float getX();
    float getY();
    float getRadius();

private:
    float x, y;
    float radius;
    ofColor color;
};

class ofApp : public ofBaseApp{

    public:
        void setup();
        void update();
        void draw();

        void mouseMoved(int x, int y );
        void mousePressed(int x, int y, int button);

    private:

        vector<Sphere*> spheres;
        Sphere* selectedSphere;
};
```

Y el archivo "ofApp.cpp" así:

```C++
#include "ofApp.h"

Sphere::Sphere(float x, float y, float radius) : x(x), y(y), radius(radius) {
    color = ofColor(ofRandom(255), ofRandom(255), ofRandom(255));
}

void Sphere::draw() {
    ofSetColor(color);
    ofDrawCircle(x, y, radius);
}

void Sphere::update(float x, float y) {
    this->x = x;
    this->y = y;
}

float Sphere::getRadius() {
    return radius;
}

float Sphere::getX() {
    return x;
}

float Sphere::getY() {
    return y;
}

//--------------------------------------------------------------
void ofApp::setup(){
    ofBackground(0);

    for (int i = 0; i < 5; i++) {
        float x = ofRandomWidth();
        float y = ofRandomHeight();
        float radius = ofRandom(20, 50);
        spheres.push_back(new Sphere(x, y, radius));
    }
    selectedSphere = nullptr;

}

//--------------------------------------------------------------
void ofApp::update(){
    if (selectedSphere != nullptr) {
        selectedSphere->update(ofGetMouseX(), ofGetMouseY());
    }
}

//--------------------------------------------------------------
void ofApp::draw(){
    for (auto sphere : spheres) {
        sphere->draw();
    }
}


//--------------------------------------------------------------
void ofApp::mouseMoved(int x, int y ){

}

//--------------------------------------------------------------
void ofApp::mousePressed(int x, int y, int button){

    if(button == OF_MOUSE_BUTTON_LEFT){
        for (auto sphere : spheres) {
            float distance = ofDist(x, y, sphere->getX(), sphere->getY());
            if (distance < sphere->getRadius()) {

                selectedSphere = sphere;
                break;
            }
        }
    }
}
```
*¿Cuál es la definición de un puntero?

RTA: Un puntero es un objeto cuyo "contenido" es la ubicación en la RAM de otro objeto y desde el cual, se puede modificar el contenido del otro objeto sin tener que posicionarse sobre el mismo necesariamente.

- ¿Dónde está el puntero?

RTA: En selectedSphere ya que en el código indica que este objeto es el que contiene la dirección de la esfera que se seleccione, por eso al inicio en la clase "setup()" aparece como "selectedSphere = nullptr;", ya que no tiene la dirección de ningún objeto asignada.

- ¿Cómo se inicializa el puntero?

RTA: Clickeando sobre una esfera.

- ¿Para qué se está usando el puntero?

RTA: Para seleccionar las esferas que se encuentran en pantalla y poder moverlas sin manipular directamente cada una, solo sus variables.

- ¿Qué es exactamente lo que está almacenado en el puntero?

RTA: El puntero almacena la posición en X y Y de la esfera seleccionada.