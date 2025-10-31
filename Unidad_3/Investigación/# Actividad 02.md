# Actividad 02

De nuevo una actividad grupal en la cual escribiremos juntos nuestra primera aplicación y analizaremos las diferentes partes que la componen.

- Genera un proyecto con el generador de proyectos de **`openframeworks`**.
- Abre el proyecto en Visual Studio.
- Modifica el archivo `ofApp.h` así:

```C++

#pragma once

#include "ofMain.h"

class ofApp : public ofBaseApp{

    public:
        void setup();
        void update();
        void draw();

        void mouseMoved(int x, int y );
        void mousePressed(int x, int y, int button);

    private:

        vector<ofVec2f> particles;
        ofColor particleColor;

};

```

- Ahora modifica el archivo ofApp.cpp así:

```C++

#include "ofApp.h"

//--------------------------------------------------------------
void ofApp::setup(){
    ofBackground(0);
    particleColor = ofColor::white;
}

//--------------------------------------------------------------
void ofApp::update(){

}

//--------------------------------------------------------------
void ofApp::draw(){
    for(auto &pos: particles){
        ofSetColor(particleColor);
        ofDrawCircle(pos.x, pos.y, 50);
    }
}

//--------------------------------------------------------------
void ofApp::mouseMoved(int x, int y ){
    particles.push_back(ofVec2f(x, y));
    if (particles.size() > 100) {
        particles.erase(particles.begin());
    }
}

//--------------------------------------------------------------
void ofApp::mousePressed(int x, int y, int button){
    particleColor = ofColor(ofRandom(255), ofRandom(255), ofRandom(255));
}

```

Analicemos juntos este código:

**1. ¿Qué fue lo que incluimos en el archivo .h?**

RTA: En el archivo .h se incluyó la declaración de las clases que utiliza el algoritmo y las variables que se requieren para poner a funcionar esas clases. En una analogía, en el .h se pone la "lista de herramientas" que voy a requerir y en el .cpp es la sección donde le doy uso a esas herramientas al asignarles valores.

**2. ¿Cómo funciona la aplicación?**

RTA: En este caso, al ejecutar el programa la aplicación funciona abriendo una pantalla en negro que detecta el cursor del mouse constantemente de tal forma que en cada posición en la que se encuentra este, genera un vector de esferas de color blanco y si mueves el cursor, las esferas se generan como si se tratara de una brocha que deja un rastro. Sin embargo, cuando el vector genera 100 esferas, a partir de la siguiente se va borrando el rastro, es decir, se van borrando las esferas más antiguas para generar "cupo" para las nuevas esferas que se generen.

**3. ¿Qué hace la función mouseMoved?**

RTA: Permite que cuando el mouse haya sido movido, se generen hasta max 100 esferas y que de ahí, se borren las primeras esferas que conforman al vector.

**4. ¿Qué hace la función mousePressed?**

RTA: Permite que el color de las esferas cambie de color a un color random.

**5. ¿Qué hace la función setup?**

RTA: Establece el color del background y el color predeterminado de las esferas, es decir, el inicial.

**6. ¿Qué hace la función update?**

RTA: Permite que los datos de los vectores se actualicen cada vez que se mueve el mouse y se ejecuta el programa.

**7. ¿Qué hace la función draw?**

RTA: Genera el color de las esferas, establece su radio y que cuando se mueva el mouse, se muevan en la posición del mismo.

