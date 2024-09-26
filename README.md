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

Una vez caracterizadas las partes componentes principales del proyecto, se esquematiza la conexión entre ellas:

<img src="https://github.com/salovel/PIANOCONMEMORIA/blob/main/IMG_8395.JPG" alt="Diagrama de flujo" width="750px">


##Implementación


##Evidencias


##Conclusiones


##Referencias
