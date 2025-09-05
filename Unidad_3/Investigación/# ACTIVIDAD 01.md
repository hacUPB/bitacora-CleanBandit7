# ACTIVIDAD 01

Tras generar el proceso, en la sección "ofApp.cpp" se modifica el código de manera que quede así":

```C++
#include "ofApp.h"

//--------------------------------------------------------------
void ofApp::setup(){
    ofBackground(0);
}

//--------------------------------------------------------------
void ofApp::update(){

}

//--------------------------------------------------------------
void ofApp::draw(){
    ofSetColor(255);
    ofDrawCircle(ofGetMouseX(), ofGetMouseY(), 20);
}

```

**1. ¿Cuál es el resultado que se obtiene al ejecutar este programa?**

RTA: Cuando se ejecuta el programa tras realizar esta modificación, el console app permite mover un círculo blanco (gracias a la parte del código: "ofSetColor(255);") en la pantalla que es de color negro ("ofBackground(0);"), esto haciendo uso del mouse gracias a la parte del código "ofDrawCircle(ofGetMouseX(), ofGetMouseY(), 20);", misma que permite determinar el radio del círculo.