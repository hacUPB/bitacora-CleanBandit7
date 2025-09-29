# ACTIVIDAD 03

**Objetivo:** entender cómo se implementan las abstracciones del encapsulamiento, herencia y polimorfismo a nivel interno.

### Profundizando en el encapsulamiento

Modificadores de acceso: private, protected, public. Control de acceso: implementado por el compilador, no por restricciones en tiempo de ejecución.

Crear una clase con diferentes niveles de acceso:

```C++
class AccessControl {
private:
    int privateVar;
protected:
    int protectedVar;
public:
    int publicVar;
    AccessControl() : privateVar(1), protectedVar(2), publicVar(3) {}
};
```
​
Intentar acceder a los miembros desde una función externa:
```C++
int main() {
    AccessControl ac;
    ac.publicVar = 10; // Válido
    // ac.protectedVar = 20; // Error de compilación
    // ac.privateVar = 30; // Error de compilación
    return 0;
}
​```
Prompt para ChatGPT: ¿Cómo implementa el compilador el encapsulamiento en C++? Si los miembros privados aún ocupan espacio en el objeto, ¿Qué impide que se acceda a ellos desde fuera de la clase?

Objetivo: el objetivo de este experimento es demostrar cómo se pueden violar las restricciones de acceso a los miembros privados de una clase en C++ utilizando técnicas de bajo nivel como la aritmética de punteros y reinterpret_cast. Se ilustrará cómo es posible acceder a los datos privados de un objeto desde fuera de la clase, lo que rompe el principio de encapsulamiento.
Considera los siguientes pasos:
Definición de la clase: primero, define una clase con miembros privados para observar el acceso a esos miembros desde fuera de la clase.

```C++
#include <iostream>

class MyClass {
private:
    int secret1;
    float secret2;
    char secret3;

public:
    MyClass(int s1, float s2, char s3) : secret1(s1), secret2(s2), secret3(s3) {}

    void printMembers() const {
        std::cout << "secret1: " << secret1 << "\n";
        std::cout << "secret2: " << secret2 << "\n";
        std::cout << "secret3: " << secret3 << "\n";
    }
};
​
Intento de acceso ilegal: verifica que no se puede acceder a los miembros privados directamente utilizando el compilador:
int main() {
    MyClass obj(42, 3.14f, 'A');
    // Esta línea causará un error de compilación
    std::cout << obj.secret1 << std::endl;

    obj.printMembers();  // Método público para mostrar los valores
    return 0;
}
​```
El código anterior intentará acceder directamente al miembro privado secret1, lo que resultará en un error de compilación.
Acceso a miembros privados usando reinterpret_cast: ahora, observa cómo violar el encapsulamiento utilizando reinterpret_cast y la aritmética de punteros:

```C++
int main() {
    MyClass obj(42, 3.14f, 'A');

    // Usando reinterpret_cast para violar el encapsulamiento
    int* ptrInt = reinterpret_cast<int*>(&obj);
    float* ptrFloat = reinterpret_cast<float*>(ptrInt + 1);
    char* ptrChar = reinterpret_cast<char*>(ptrFloat + 1);

    // Accediendo y mostrando los valores privados
    std::cout << "Accediendo directamente a los miembros privados:\n";
    std::cout << "secret1: " << *ptrInt << "\n";       // Accede a secret1
    std::cout << "secret2: " << *ptrFloat << "\n";     // Accede a secret2
    std::cout << "secret3: " << *ptrChar << "\n";      // Accede a secret3

    return 0;
}
```
Ahora reflexiona:

- ¿Qué es el encapsulamiento y cuál es su propósito en la programación orientada a objetos?

RTA: Es el mecanismo que oculta los detalles internos de una clase y solo expone lo necesario. Su propósito es proteger los datos y mantener la coherencia del objeto.

- ¿Por qué es importante proteger los datos de una clase y restringir el acceso desde fuera de la misma?

RTA: Porque evita modificaciones indebidas, reduce errores y asegura que el objeto solo se manipule de la forma prevista.

- ¿Qué significa reinterpret_cast y cómo afecta la seguridad del programa?

RTA: Es una conversión de tipo forzada en C++ que trata un bloque de memoria como si fuera de otro tipo. Afecta la seguridad porque permite saltarse las reglas del lenguaje y acceder a datos de forma insegura.

- ¿Por qué crees que se pudo acceder a los miembros privados de MyClass en este experimento, a pesar de que el compilador normalmente lo impediría?

RTA: Porque en memoria los datos privados están presentes como cualquier otro, y el compilador solo impide el acceso directo a nivel de código, no a nivel físico en memoria.

- ¿Cuáles podrían ser las consecuencias de utilizar técnicas como las mostradas en este experimento en un programa real?

RTA: Inestabilidad, corrupción de datos, vulnerabilidades de seguridad y comportamientos indefinidos difíciles de depurar.

- ¿Qué implicaciones tiene este experimento sobre la confianza en las barreras de encapsulamiento que proporciona C++?

RTA: Muestra que el encapsulamiento en C++ es una convención lógica impuesta por el compilador, pero no una barrera absoluta, por lo que la seguridad depende también de la disciplina del programador.

**Encapsulamiento:**

Al crear la clase con miembros private, protected y public, confirmé que el encapsulamiento lo controla el compilador: aunque los atributos privados ocupan memoria en el objeto, el compilador impide el acceso directo desde fuera.
El experimento con reinterpret_cast demostró que esas restricciones pueden romperse a bajo nivel. Esto refuerza que el encapsulamiento en C++ es más una convención de seguridad lógica que una barrera real en memoria.

    - Propósito: proteger los datos de accesos indebidos y mantener la integridad del objeto.

    - Riesgo: usar conversiones forzadas puede vulnerar esa seguridad y causar errores o comportamientos peligrosos en programas reales.

### Herencia y la Relación en Memoria

- Layout de memoria: ¿Cómo los objetos derivados contienen los datos de las clases base?
- Desplazamiento en memoria: los atributos de la clase base preceden a los de la clase derivada.

Considera los siguientes pasos:

1. Crear clases con herencia:

```C++
class Base {
public:
    int baseVar;
};
class Derived : public Base {
public:
    int derivedVar;
};
```

1. Analizar las direcciones de memoria:

```C++
Derived d;
std::cout << "Dirección de d: " << &d << std::endl;
std::cout << "Dirección de d.baseVar: " << &(d.baseVar) << std::endl;
std::cout << "Dirección de d.derivedVar: " << &(d.derivedVar) << std::endl;
```

- ¿Cómo se organizan los atributos en memoria?

RTA: Los atributos de la clase base se almacenan primero, seguidos de los de la clase derivada. Así, baseVar aparece antes que derivedVar en la memoria del objeto d.

- ¿Qué sucede si agregamos más niveles de herencia?

RTA: Cada nivel de herencia agrega sus propios atributos de forma secuencial en memoria, después de los de la(s) clase(s) base. El objeto final contiene un bloque continuo con todos los atributos en orden jerárquico.

- Prompt para ChatGPT: explícame cómo se organiza en memoria un objeto de una clase derivada en C++. ¿Cómo se almacenan los atributos de la clase base y de la derivada?

**Herencia:**

Al analizar Base y Derived, observé que los atributos de la clase base se almacenan primero en memoria, seguidos por los de la derivada. Con más niveles de herencia, la memoria se organiza de forma secuencial: cada bloque de atributos de la base va antes que los nuevos de la clase derivada. Esto garantiza que un objeto derivado pueda usarse como su base sin perder consistencia en memoria.

### Polimorfismo y Vtables en detalle

- Polimorfismo: permite usar una interfaz común para diferentes tipos de objetos.
- Implementación: uso de vtables para resolver métodos virtuales.

Considera los siguientes pasos:

1. Crear una jerarquía polimórfica:

```cpp
class Animal {
public:
    virtual void makeSound() {
        std::cout << "Some generic sound" << std::endl;
    }
};
class Dog : public Animal {
public:
    void makeSound() override {
        std::cout << "Bark" << std::endl;
    }
};
class Cat : public Animal {
public:
    void makeSound() override {
        std::cout << "Meow" << std::endl;
    }
};
```

2. Usar punteros de la clase base:

```C++
Animal* animals[] = { new Dog(), new Cat() };
for (Animal* animal : animals) {
    animal->makeSound();
}
```

3. Analizar con un depurador: observa cómo se resuelven las llamadas a makeSound() en tiempo de ejecución.

- ¿Cómo utiliza el programa las vtables para el polimorfismo?

RTA: Cada objeto polimórfico contiene un puntero oculto a su propia vtable. Cuando se llama a makeSound(), el programa consulta la vtable correspondiente al tipo dinámico del objeto (Dog o Cat) y ejecuta la función que ahí está registrada, no la de la clase base.

- ¿Cuál es el impacto en el rendimiento?

RTA: La llamada a métodos virtuales introduce un ligero costo adicional: en lugar de saltar directo al método, se necesita una búsqueda en la vtable. Sin embargo, este costo es mínimo frente a la flexibilidad que se gana.

- Prompt para ChatGPT: ¿Cómo funciona el polimorfismo en C++ a nivel interno? Explica cómo se utilizan las vtables para resolver métodos virtuales en una jerarquía de herencia.

RTA: Internamente, el compilador genera una vtable para cada clase que tenga métodos virtuales. Cada objeto guarda un puntero a la vtable de su clase. Cuando se invoca un método virtual, se usa ese puntero para buscar y ejecutar la función correspondiente.

4. Reflexión Individual:
- ¿Cómo se implementan internamente el encapsulamiento, la herencia y el polimorfismo?

RTA:
    - Encapsulamiento: a nivel de compilador, se imponen restricciones de acceso, aunque en memoria todos los datos están presentes.

    - Herencia: los atributos de la clase base se incluyen directamente en el objeto derivado de forma secuencial.

    - Polimorfismo: se logra con las vtables y punteros a ellas, que permiten seleccionar el método correcto en tiempo de ejecución.

- Análisis: ventajas y desventajas en términos de eficiencia y complejidad.

    - **Ventajas:** mayor flexibilidad, reutilización de código, y capacidad de trabajar con jerarquías complejas de manera uniforme.

    - **Desventajas:** llamadas virtuales ligeramente más lentas, más uso de memoria (por vtables y punteros), y mayor complejidad al depurar o razonar sobre el flujo real de ejecución.