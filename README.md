#Piano con leds y memoria de secuencias

##Introducción

En este proyecto se realizó el diseño y la implementación del prototipo de un piano de una octava con las siete notas de la escala natural, el cual cuenta tmbién con siete leds, estando cada uno asociado a una nota. Para la implementación del prototipo se usó una FPGA BlackIce 40hx4 programada con verilog. Adicionalmente, el prototipo cuenta con la posibilidad de reproducir una secuencia de notas almacenada en un archivo que se puede modificar libremente. El propósito del dispositivo consiste en reproducir la secuencia para que posteriormente el usuario intente replicarla tocando él mismo las teclas del prototipo.

##Objetivos

###Objetivo general

Implementar un prototipo de un piano que facilite el aprendizaje y entendimiento musical básico del usuario, superando los retos de diseño e implementacipon que supone llevar a cabo dicha tarea.

###Objetivos específicos

- Desarrollar los archivos necesarios para obtener un prototipo fucional

- Poner en práctica los conocimientos sobre la electróica digital para solucionar un problema

- Integrar distitos conceptos como memorias, lógica secuencial, booleana y y bases numéricas en un artefacto

- Fusionar la música y la electrónica en un dispositivo funcional


##Ideación

La idea surgió a partir de querer implementar un dispositivo capaz de reproducir canciones o secuencias musicales, de modo que se activaran unas luces de forma sincronizada con el ritmo y la melodía de la secuencia o canción reproducida. La idea fue descartada por sus limitaciones a nivel práctico, por lo que se optó por implementar un prototipo de piano que, como se mencionó anteriormente, sea capaz de facilitar el entendimiento musical básica del usuario, usando los mismos conceptos de la idea original pero esta vez con un concepto diferente.

El prototipo opera de manera que cada nota está asociada a un led y a su vez, cada nota es activada por uno de los siete distintos pulsadores.

##Diseño

Para el diseño del dispositivo, se requirió en primer lugar, dividirlo en varias partes:

- Generador de frecuencias: Genera las notas, basándose en la frecuencia característica de cada una

- Botones o pulsadores: Hacen la función de tecla, en este caso, son 7 botoes, uno para cada nota.

- Leds: Cada led se asocia a una nota, facilitando la diferenciación entre una nota y otra a nivel visual.

- Memoria: Su función es almacenar la secuencia que será reproducida por el dispositivo.

- Bocina: La bocina se encarga de reproducir las notas a través de ondas mecánicas.

- Amplificador: El amplificador se encarga de enviar una señal lo suficientemente fuerte a la bocina para que esta pueda reproducir los sonidos.

Una vez caracterizadas las partes componentes principales del proyecto, se esquematiza la conexión entre ellas:

<img src="https://github.com/salovel/PIANOCONMEMORIA/blob/main/IMG_8395.JPG" alt="Diagrama de flujo" width="750px">

En el diagrama anterior se encuentran esquematizados todos los componentes del proyecto, y es a partir de él que se procede a desarrollar la lógica detrás del funcionamiento del mismo y la implementación a nivel de código. 

En primer lugar y antes de seguir con la explicación detallada de los archivos y los códigos, hay que comprender la lógica bajo la cual se sustenta el proyecto, la cual consta de los siguientes pasos:

1. Espera: El usuario debe presionar el botón de inicio para que el dispositivo lea y reproduzca la secuencia guardada.

2. Inicio del ciclo: El dispositivo recibe la orden y comienza el ciclo de reproducción.

3. Reproducción: Una vez inicia la lectura de la secuencia, se reproducen los sonidos, mientras los leds son encendidos de acuerdo a la nota que se reproduce al instante, mostrando el patrón de la secuencia.

4. Finalización: Una vez el dispositivo ha leído los datos de la secuencia, queda en espera para nuevamente ser accionado y reproducir la secuencia.

   Dado que los leds y la bocina no suponen una gran demanda de corriente, todo el circuito se puede alimentar a través de la tarjeta FPGA.

##Implementación

Para la implementación del prototipo, en primer lugar se realizaron las conexiones correspondientes de la FPGA, la bocina, los leds, los botones y el amplificador. El resultado final de las coexiones se aprecia en la siguiente imagen:

<img src="https://raw.githubusercontent.com/salovel/PIANOCONMEMORIA/refs/heads/main/IMG_8394.JPEG" alt="Diagrama de flujo" width="750px">

En la imagen se pueden observar todos los componentes del dispositivo y sus respectivas conexiones en las protoboards, siendo en una de estas donde se encuentran ubicados los botoes y los leds, y en otra, el amplificador y la bocina.

Ya logradas las coexiones y conceptualizada la lógica general del proyecto, se establece de forma jerárquica qué archivos se van a requerir para la implementación del proyecto. La jerarquía de los archivos se aprecia gráficamente en la siguiente figura:

##Evidencias


##Conclusiones


##Referencias

