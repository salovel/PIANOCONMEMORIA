# Piano con leds y memoria de secuencias

## Introducción

En este proyecto se realizó el diseño y la implementación del prototipo de un piano de una octava con las siete notas de la escala natural, el cual cuenta tmbién con siete leds, estando cada uno asociado a una nota. Para la implementación del prototipo se usó una FPGA BlackIce 40hx4 programada con verilog. Adicionalmente, el prototipo cuenta con la posibilidad de reproducir una secuencia de notas almacenada en un archivo que se puede modificar libremente. El propósito del dispositivo consiste en reproducir la secuencia para que posteriormente el usuario intente replicarla tocando él mismo las teclas del prototipo.

## Objetivos

### Objetivo general

Implementar un prototipo de un piano que facilite el aprendizaje y entendimiento musical básico del usuario, superando los retos de diseño e implementacipon que supone llevar a cabo dicha tarea.

### Objetivos específicos

- Desarrollar los archivos necesarios para obtener un prototipo fucional

- Poner en práctica los conocimientos sobre la electróica digital para solucionar un problema

- Integrar distitos conceptos como memorias, lógica secuencial, booleana y y bases numéricas en un artefacto

- Fusionar la música y la electrónica en un dispositivo funcional


## Ideación

La idea surgió a partir de querer implementar un dispositivo capaz de reproducir canciones o secuencias musicales, de modo que se activaran unas luces de forma sincronizada con el ritmo y la melodía de la secuencia o canción reproducida. La idea fue descartada por sus limitaciones a nivel práctico, por lo que se optó por implementar un prototipo de piano que, como se mencionó anteriormente, sea capaz de facilitar el entendimiento musical básica del usuario, usando los mismos conceptos de la idea original pero esta vez con un concepto diferente.

El prototipo opera de manera que cada nota está asociada a un led y a su vez, cada nota es activada por uno de los siete distintos pulsadores.

## Diseño

Para el diseño del dispositivo, se requirió en primer lugar, dividirlo en varias partes:

- Generador de frecuencias: Genera las notas, basándose en la frecuencia característica de cada una

- Botones o pulsadores: Hacen la función de tecla, en este caso, son 7 botoes, uno para cada nota.

- Leds: Cada led se asocia a una nota, facilitando la diferenciación entre una nota y otra a nivel visual.

- Memoria: Su función es almacenar la secuencia que será reproducida por el dispositivo.

- Bocina: La bocina se encarga de reproducir las notas a través de ondas mecánicas.

- Amplificador: El amplificador se encarga de enviar una señal lo suficientemente fuerte a la bocina para que esta pueda reproducir los sonidos.

Una vez caracterizadas las partes componentes principales del proyecto, se esquematiza la conexión entre ellas:

<img src="https://github.com/salovel/PIANOCONMEMORIA/blob/main/PROYECTO%20FINAL%20DIGITAL%201.jpg" alt="Diagrama de flujo" width="750px">

En el diagrama anterior se encuentran esquematizados todos los componentes del proyecto, y es a partir de él que se procede a desarrollar la lógica detrás del funcionamiento del mismo y la implementación a nivel de código. 

En primer lugar y antes de seguir con la explicación detallada de los archivos y los códigos, hay que comprender la lógica bajo la cual se sustenta el proyecto, la cual consta de los siguientes pasos:

1. Espera: El usuario debe presionar el botón de inicio para que el dispositivo lea y reproduzca la secuencia guardada.

2. Inicio del ciclo: El dispositivo recibe la orden y comienza el ciclo de reproducción.

3. Reproducción: Una vez inicia la lectura de la secuencia, se reproducen los sonidos, mientras los leds son encendidos de acuerdo a la nota que se reproduce al instante, mostrando el patrón de la secuencia.

4. Finalización: Una vez el dispositivo ha leído los datos de la secuencia, queda en espera para nuevamente ser accionado y reproducir la secuencia.

   Dado que los leds y la bocina no suponen una gran demanda de corriente, todo el circuito se puede alimentar a través de la tarjeta FPGA.


## Implementación

Para la implementación del prototipo, en primer lugar se realizaron las conexiones correspondientes de la FPGA, la bocina, los leds, los botones y el amplificador. El resultado final de las coexiones se aprecia en la siguiente imagen:

<img src="https://raw.githubusercontent.com/salovel/PIANOCONMEMORIA/refs/heads/main/IMG_8394.JPEG" alt="Diagrama de flujo" width="750px">

En la imagen se pueden observar todos los componentes del dispositivo y sus respectivas conexiones en las protoboards, siendo en una de estas donde se encuentran ubicados los botoes y los leds, y en otra, el amplificador y la bocina.

Ya logradas las coexiones y conceptualizada la lógica general del proyecto, se establece de forma jerárquica qué archivos se van a requerir para la implementación del proyecto. La jerarquía de los archivos se aprecia gráficamente en la siguiente figura:

<img src="https://github.com/salovel/PIANOCONMEMORIA/blob/main/Captura%20de%20pantalla%202024-09-27%20004754.png" width="750px">

A continuación se explicará a detalle la función de cada uno de los archivos y los códigos que componen a cada uno.

### [Archivo top.v](https://github.com/salovel/PIANOCONMEMORIA/blob/main/top.v "Archivo top.v")

Este es el archivo principal, que coordina y conecta los demás archivos. En primer lugar, ntegra los otros tres archivos Verilog para utilizar los módulos definidos en ellos; [clk10hz](https://github.com/salovel/PIANOCONMEMORIA/blob/main/clk10hz.v "clk10hz"), [counter8bits](https://github.com/salovel/PIANOCONMEMORIA/blob/main/counter8bits.v "counter8bits"), [dual_port_ram](https://github.com/salovel/PIANOCONMEMORIA/blob/main/dual_port_ram.v "dual_port_ram") y [gen_freq](https://github.com/salovel/PIANOCONMEMORIA/blob/main/gen_freq.v "gen_freq"). A continuación se describe su funcionalidad principal.

#### Entradas y salidas

La información fluye a través del top.v, por lo que se requiere que en él se definan las entradas y las salidas. Las principales entradas y salidas del sistema son:

- clk: La señal de reloj principal del sistema.

- btn: Un botón que, cuando es presionado, inicia un ciclo de lectura de la memoria.

- btn_in: Son los siete botones de entrada, asociados cada uno a una de las siete notas de la escala natural.

- sounds: Las salidas de audio que llegan al amplificador para posteriormente ser enviadas a la bocina.

  #### Generación de reloj lento
  Utiliza el módulo clk10hz para generar una señal de reloj clk2 más lenta a partir del reloj principal. Este nuevo reloj se usa para controlar la velocidad de lectura de la memoria y, por lo tanto, el tempo de la secuencia de notas.

  #### Lectura de memoria
  Lee datos secuencialmente desde la memoria RAM dual_port_ram utilizando un contador runner como dirección. El contador se incrementa en cada ciclo del reloj lento clk2.

  #### Procesamiento y generación de sonido
Combina los datos leídos de la memoria con el estado de los botones de entrada btn_in para generar señales de control gen_in. Estas señales se envían al módulo gen_freq para generar las salidas de audio sounds correspondientes.

#### Visualización de leds
  Al mismo tiempo que se ejecuta la generación de sonido,  el valor de las señales de control gen_in van las salidas de los LEDs leds, proporcionando una representación visual de la secuencia de notas o del estado del sistema.

  #### Control del ciclo
  Implementa la lógica para iniciar el ciclo de lectura de la memoria en respuesta de si está pulsado el botón btn.

### [Archivo clk10hz.v](https://github.com/salovel/PIANOCONMEMORIA/blob/main/clk10hz.v "Archivo clk10hz.v")

Este archivo se encarga de la tarea de generar una señal de reloj lenta a partir del reloj principal de la FPGA, el cual es de 25 MHz. Esta señal entra al módulo top.v

#### [Archivo dual_port_ram.v](https://github.com/salovel/PIANOCONMEMORIA/blob/main/dual_port_ram.v "Archivo dual_port_ram.v")

  Este módulo implementa una memoria RAM de doble puerto, lo que significa que permite acceder a dos direcciones de memoria diferentes de forma simultánea, una para lectura y otra para escritura. A pesar de que en el proyecto no se requiere hacer uso de todas las funciones que ofrece la memoria de doble puerto como la función de escritura, sí se usa su función básica de memoria de acceso rápido.


### [Archivo gen_freq.v](https://github.com/salovel/PIANOCONMEMORIA/blob/main/gen_freq.v "Archivo gen_freq.v")

En este archivo se dan las órdenes para generar las frecuencias de cada una de las notas. Se producen las notas musicales según la lectura de la memoria y según los botones que sean pulsados, que va de btn0 a btn6.

#### Entradas
- input wire clk: Esta es laseñal de reloj de la FPGA, la cual opera a 25 MHz, a partir de esta señal se controla la generación de las señales de audio.

- input wire btn0, btn1, ... btn6: Son las entradas de los botones, que indican qué nota musical se debe generar. Cada botó está asociado a una nota distinta: btn0=C, btn1=D, btn2=E, btn3=F, btn4=G, btn5=A, btn6=B.

#### Salidas
reg [15:0] contador_C, contador_D, ... contador_B: Se declaran contadores de 16 bits para cada nota musical. Estos contadores se utilizarán para dividir la frecuencia del reloj y generar las señales de audio.
reg estado_salida_C, estado_salida_D, ... estado_salida_B: Se declaran registros para almacenar el estado de cada salida de audio (0 o 1), que determinará si la nota correspondiente está sonando o no.

#### Generación de las señales de audio
Para cada uno de los botones btn0 a btn6, se aplica la siguiente lógica: con if(~btnX) se ejecuta la siguiente línea de código si el botón correspondiente está presionado. Dado que los botones están trabajando con lógica negativa, el botón presionado significa que está a nivel bajo. Con if (contador_X >= DIV_X) se ordena que si el contador asociado a la nota ha alcanzado el valor del divisor correspondiente, se reinicie el contador y se invierta el estado de la salida de audio (estado_salida_X). Con else contador_X <= contador_X + 1 se logra que si el contador no ha alcanzado el divisor, se incremente en 1. Finalmente se tiene que else contador_X <= 0 hace que si el botón no está presionado, se reinicie el contador asociado a esa nota.

#### Asignación de salidas
la línea salida_C = estado_salida_C; ... salida_B = estado_salida_B logra que las salidas de audio se asignen directamente a los valores almacenados en los registros de estado correspondientes.


### Simulación de memoria

Haciendo uso de la implementación de un archivo testbench, se comprueba el funcionamiento de la memoria, lo cual genera un GTKwave en donde se ve cómo cambian las salidas según las variaciones del clock utilizado en el diseño.

<img src="https://github.com/salovel/PIANOCONMEMORIA/blob/main/tbproyecto.png" width="750px">

### Diagrama de flujo

Dado que varios de los procesos ocurridos durante la ejecución en un ciclo o mientras el usuario pulsa los botones pueden presentarse de forma paralela, resulta útil graficar el funcionamiento lógico de todo el dispositivo:

<img src="https://github.com/salovel/PIANOCONMEMORIA/blob/main/_Diagrama%20de%20flujo.jpeg" width="1000px">

En este diagrama de flujo se condensa el proceso y funcionamiento general del dispositivo.

### Archivos adicionales necesarios

#### [Archivo top.pcf](https://github.com/salovel/PIANOCONMEMORIA/blob/main/top.pcf) "Archivo Archivo top.pcf")
En este archivo se guarda la información que setea los pines de la tarjeta FPGA y les asigna una salida o entrada.

#### [Archivo file.mem](https://github.com/salovel/PIANOCONMEMORIA/blob/main/file.mem "Archivo file.mem")
En este archivo se almacena la secuencia que será leída por el dispositivo para su posterior reproducción.

El RTL del archivo top.v se encuentra a continuación:

<img src="https://github.com/salovel/PIANOCONMEMORIA/blob/main/topv.png" width="750px">

Finalmente, el dispositivo se puede ver en funcionamiento en el siguiente video: https://youtu.be/Tw-GfQIO8_8. En este video se aprecia cómo reproduce la secuencia una vez es presionado el botón de inicio para, una vez terminado el ciclo de lectura, permitir al usuario presionar los botones para que intente replicar la secuencia reproducida. Nótese que en esta prueba, los leds mantienen encendidos y son apagados cuando se accionan.




## Conclusiones

- A lo largo del desarrollo del proyecto, se hizo evidente que el mismo funcionaría más eficientemente al establecer una jerarquía entre los módulos, teniendo un módulo superior a los demás. Esto facilita el procesamiento de entradas y salidas para el desarrollador.

- El principal reto a la hora de implementar un dispositivo que materializa una idea es poder relacionar todos los archivos y que su base sea la lógica inicial del proyecto, ya que un solo concepto o proceso puede suponer varias líneas de código para el tratamiento de entradas y salidas que conectan varios módulos del proyecto.

- Las mejoras a un proyecto de estas características se deben hacer gradualmente, yendo de lo general a lo específico. Así se obtiene en primer lugar un dispositivo funcional sin errores necesariamente pero imperfecto, y a través de la prueba y error, las ideas de mejora que van surgiendo pueden intentar ser implementadas poco a poco.

- Tener los conceptos claros suele ser en muchos casos el único paso necesario para resolver un problema pequeño pero importante, cuya resolución permite avanzar en el desarrollo del proyecto.





