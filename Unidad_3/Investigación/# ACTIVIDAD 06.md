# ACTIVIDAD 06

El código anterior tiene un problema. ¿Puedes identificar cuál es? ¿Cómo lo solucionarías? Recuerda que deberías poder seleccionar una esfera y moverla con el mouse.

RTA: El error en el código es que en teoría, cada vez que se selecciona una esfera, se debería poder seleccionar cada esfera y poderla des-seleccionar, sin embargo, en este caso tras elegir la segunda esfera, el código no permite des-seleccionarla dejando al puntero estancado en la misma.

En este caso lo que hice para solucionar el código fue crear una clase llamada "mouseReleased" que tiene como función permitir que cuando el puntero, dirigido por el mouse esté presionando uno de los círculos, se pueda mover y que para des-seleccionarlo solo se tenga que dejar de oprimir el click del mouse.

Código agregado:

En "ofApp.h" anuncié la clase "void mouseReleased(int x, int y, int button);"

además de agregar la variable "bool isDragging;"

Ya anunciado esto, en "ofApp.cpp" puse el siguiente código:

```C++
void ofApp::mouseReleased(int x, int y, int button) {
	if (button == OF_MOUSE_BUTTON_LEFT) {
		selectedSphere = nullptr; // dejamos de mover cualquier esfera
		isDragging = false; // desactivamos arrastre
	}
}
```
Cada vez que se detecta que el mouse está entre la distancia entre el centro de la esfera y sus bordes, el bool "isDragging" se pone como true y cuando se deja de oprimir el click, se pone en false para que así, se des-seleccione.