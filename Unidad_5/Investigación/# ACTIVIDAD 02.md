# ACTIVIDAD 02

### Exploración de métodos virtuales

**Objetivo:** comprender el impacto de los métodos virtuales en la memoria y el rendimiento.

Considera los siguientes pasos:

1. Crea una jerarquía de clases con métodos virtuales:

```C++
class Base {
public:
    virtual void display() {
        std::cout << "Base display" << std::endl;
    }
};

class Derived : public Base {
public:
    void display() override {
        std::cout << "Derived display" << std::endl;
    }
};
```

2. Analiza la vtable. ¿En qué parte de la memoria se encuentran las vtable de cada objeto?

```C++
Base b;
Derived d;
std::cout << "Vtable de Base: " << *(void**)&b << std::endl;
std::cout << "Vtable de Derived: " << *(void**)&d << std::endl;
```
- ¿Cómo afecta la presencia de métodos virtuales al tamaño del objeto?

RTA: 

    - Si una clase pasa de no tener virtuales a tener al menos una función virtual, el tamaño del objeto normalmente aumenta en el tamaño de un puntero (vptr).

        a. En sistemas 64-bit típicos: sizeof(objeto) += 8 bytes.

        b. En sistemas 32-bit típicos: sizeof(objeto) += 4 bytes.
    
    - Si la clase tiene otros miembros, el vptr se suma al tamaño y luego se aplica alineamiento/espaciado normal.

    - Múltiple herencia o herencia virtual pueden añadir más de un vptr por objeto (ej: cada subobjeto de la clase base puede tener su propio vptr), por lo que en esos casos el incremento puede ser mayor.

- ¿Qué papel juegan las vtables en el polimorfismo?

RTA:
    - **Desempeño de llamada virtual:** cuando se hace "base_ptr->display();" el compilador genera código que:

        1. lee el vptr desde el objeto (base_ptr),

        2. indexa la entrada correspondiente en la vtable,

        3. hace una llamada indirecta al puntero de función allí almacenado.

    - Esto permite llamar a la implementación apropiada según el tipo dinámico del objeto (polimorfismo en tiempo de ejecución).
    
    - **Consecuencias:**

        - Llamadas virtuales implican indirección (coste de cargar vptr y hacer llamada indirecta) — ligeramente más lentas que llamadas directas.

        - Las funciones virtuales suelen impedir ciertas optimizaciones (p. ej. inlining) a menos que el compilador pueda demostrar el tipo concreto (devirtualization).

        - Permite dynamic_cast y otras rutinas RTTI: la información de tipo (type_info) normalmente se relaciona con la vtable (p. ej. puntero a type_info dentro de la vtable).

### Uso de punteros y referencias

Objetivo: explorar cómo los punteros y referencias afectan la gestión de la memoria y la llamada a métodos.

Considera estos pasos:

1. Implementar una clase con punteros a funciones:

```C++
class FunctionPointerExample {
public:
    void (*funcPtr)();
    static void staticFunction() {
        std::cout << "Static function called" << std::endl;
    }
    void assignFunction() {
        funcPtr = staticFunction;
    }
};
```

2. Analizar el impacto en memoria:

- Observar si el tamaño de la instancia cambia al usar punteros a funciones.

- Verificar cómo se almacenan estos punteros.

RTA: Al revisar el tamaño del objeto con sizeof(FunctionPointerExample), noté que:

 - El único espacio extra ocupado en la instancia corresponde al puntero a función (funcPtr). En un sistema de 64 bits, este puntero ocupa 8 bytes (o 4 bytes en 32 bits).

    - No hay tabla adicional como en el caso de las vtables.

    - El puntero está almacenado dentro del objeto, y simplemente guarda la dirección de una función global o estática.

    - Esto significa que cada instancia tiene su propia copia del puntero, y puede apuntar a distintas funciones si así se decide en tiempo de ejecución.

3. Reflexión Guiada:

    Reflexionando, me di cuenta de que los punteros a funciones y las vtables cumplen un propósito similar: ambos permiten despacho indirecto de funciones. Sin embargo, hay diferencias importantes:

        - Puntero a función:

            a. Se asigna manualmente.

            b. Ocupa un espacio explícito dentro de cada objeto (aumenta su tamaño).

            c. No requiere que la clase tenga métodos virtuales.

        - Vtable:

            a. Es gestionada automáticamente por el compilador al usar métodos virtuales.

            b. Está almacenada en memoria estática y compartida entre todas las instancias de una clase.

            c. Cada objeto solo guarda un puntero a la vtable (el vptr).

    En otras palabras, las vtables son como una “infraestructura automática” para el polimorfismo, mientras que los punteros a funciones son más manuales y flexibles.

    Sobre el efecto en el rendimiento:

        - En términos de rendimiento exclusivamente:

            - El puntero a función requiere solo una indirección: leer la dirección del puntero y llamar la función.

            - El llamado virtual con vtable también requiere una indirección, pero con un paso intermedio: buscar la función dentro de la vtable.

        - En la práctica, ambos son muy rápidos, pero las vtables permiten mayor organización a escala (polimorfismo en grandes jerarquías), mientras que los punteros a funciones son más ligeros en estructuras pequeñas o en casos específicos como callbacks.

    Diferencia entre punteros a funciones y punteros a métodos miembro:

        Una última diferencia que exploré es entre punteros a funciones normales y punteros a métodos miembro:

            - Los punteros a funciones normales/estáticas son simples direcciones en memoria.

            - Los punteros a métodos miembro son más complejos porque deben considerar el objeto (this) sobre el cual se invocan. Por eso su representación interna puede ser más grande y menos directa que un simple puntero a función.

        Esto afecta al tamaño de los objetos solo si se guardan estos punteros como atributos. Y en cuanto al rendimiento, los punteros a métodos miembro tienden a ser un poco más costosos, pero siguen siendo eficientes.

    Conclusión Final:

     - La práctica me ayudó a comparar dos mecanismos de C++ que a primera vista parecen similares, pero que cumplen roles diferentes. Los punteros a funciones ofrecen flexibilidad a nivel bajo, mientras que las vtables representan una solución estandarizada y automática para el polimorfismo. Ambos afectan la memoria y el rendimiento de formas distintas, y entender esas diferencias me ayuda a decidir cuál usar según el diseño de una aplicación.

4. Reflexión individual:

    - ¿Dónde residen los datos y métodos de una clase en la memoria?

    RTA:

        - Los atributos de un objeto (incluyendo punteros como funcPtr o el vptr de una clase con virtuales) residen en el heap o en la stack, dependiendo de cómo se instancie el objeto. Cada objeto tiene su propia copia de esos datos.

        - En cambio, los métodos (ya sean normales, estáticos o virtuales) no se copian en cada objeto; el código de las funciones está en la sección de código (text segment) del programa.

        - Cuando se usan vtables o punteros a funciones, lo que se guarda dentro del objeto es solo una dirección (un puntero) hacia esa función ya existente en la sección de código.

    - ¿Cómo interactúan las diferentes partes en tiempo de ejecución?

    RTA: En ejecución, cuando se llama un método:

        - El programa busca la dirección de la función.

        - Si es un método normal → llamada directa.

        - Si es virtual → se accede primero al vptr del objeto, y luego a la vtable para encontrar la dirección de la función.

        - Si es un puntero a función → se toma directamente la dirección almacenada en el atributo y se llama.

Una vez se obtiene la dirección, se salta al código correspondiente en la sección de texto.
Esta interacción muestra cómo el objeto, el puntero y el código trabajan juntos para habilitar flexibilidad en tiempo de ejecución.

    - Conclusión: cómo esta comprensión afecta el diseño de sistemas.

    RTA: Entender dónde se ubican los datos y cómo se enlazan las funciones me ayuda a diseñar sistemas más conscientes del uso de memoria y del costo en rendimiento. Por ejemplo:

        - Si un programa necesita millones de objetos, debo cuidar no añadir punteros innecesarios que inflen el tamaño de cada instancia.

        - Si necesito polimorfismo flexible, las vtables son convenientes porque automatizan el proceso, aunque consuman un poco más de memoria y añadan una indirección.

        - Si necesito callbacks ligeros o específicos, usar punteros a funciones puede ser más eficiente.

    En conclusión, esta práctica me permitió ver que detrás de lo “abstracto” en C++ hay un diseño muy concreto en la memoria, y conocerlo me ayuda a tomar mejores decisiones para crear sistemas más eficientes y escalables.