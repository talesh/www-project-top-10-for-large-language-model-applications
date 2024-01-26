## LLM04: Denegación de Servicio en Modelos

### Descripción

Un atacante interactúa con un LLM de una manera que consume una cantidad excepcionalmente alta de recursos, lo que resulta en una disminución en la calidad del servicio tanto para ellos como para otros usuarios, así como en la posible generación de altos costos de recursos. Además, una preocupación de seguridad emergente es la posibilidad de que un atacante interfiera o manipule la ventana de contexto de un LLM. Este problema se está volviendo más crítico debido al creciente uso de LLM en diversas aplicaciones, su intensiva utilización de recursos, la imprevisibilidad de la entrada del usuario y una falta de conciencia general entre los desarrolladores sobre esta vulnerabilidad. En los LLM, la ventana de contexto representa la longitud máxima de texto que el modelo puede manejar, cubriendo tanto la entrada como la salida. Es una característica crucial de los LLM ya que dicta la complejidad de los patrones de lenguaje que el modelo puede comprender y el tamaño del texto que puede procesar en un momento dado. El tamaño de la ventana de contexto está definido por la arquitectura del modelo y puede variar entre modelos.

### Ejemplos Comunes de Vulnerabilidad

1. Realizar consultas que conducen a un uso recurrente de recursos a través de la generación de un alto volumen de tareas en una cola, por ejemplo, con LangChain o AutoGPT.
2. Enviar consultas inusualmente consumidoras de recursos que utilizan ortografía o secuencias inusuales.
3. Desbordamiento continuo de entrada: Un atacante envía un flujo de entrada al LLM que excede su ventana de contexto, causando que el modelo consuma recursos computacionales excesivos.
4. Entradas largas repetitivas: El atacante envía repetidamente entradas largas al LLM, cada una excediendo la ventana de contexto.
5. Expansión recursiva del contexto: El atacante construye una entrada que desencadena la expansión recursiva del contexto, obligando al LLM a expandir y procesar repetidamente la ventana de contexto.
6. Inundación de entrada de longitud variable: El atacante inunda al LLM con un gran volumen de entradas de longitud variable, donde cada entrada está cuidadosamente diseñada para alcanzar justo el límite de la ventana de contexto. Esta técnica tiene como objetivo explotar cualquier ineficiencia en el procesamiento de entradas de longitud variable, forzando al LLM y potencialmente causando que se vuelva irresponsivo.

### Estrategias de Prevención y Mitigación

1. Implementar validación y sanitización de entradas para garantizar que las entradas de los usuarios se adhieran a los límites definidos y filtrar cualquier contenido malicioso.
2. Limitar el uso de recursos por solicitud o paso, de modo que las solicitudes que involucren partes complejas se ejecuten más lentamente.
3. Imponer límites de tasa en la API para restringir el número de solicitudes que un usuario individual o dirección IP puede hacer en un marco de tiempo específico.
4. Limitar el número de acciones en cola y el número total de acciones en un sistema que reacciona a las respuestas del LLM.
5. Monitorear continuamente la utilización de recursos del LLM para identificar picos anormales o patrones que puedan indicar un ataque de DoS.
6. Establecer límites estrictos de entrada basados en la ventana de contexto del LLM para prevenir la sobrecarga y el agotamiento de recursos.
7. Promover la concienciación entre los desarrolladores sobre posibles vulnerabilidades de DoS en los LLM y proporcionar pautas para la implementación segura de LLM.

### Ejemplos de Escenarios de Ataque

1. Un atacante envía repetidamente múltiples solicitudes difíciles y costosas a un modelo alojado, lo que lleva a un peor servicio para otros usuarios y a un aumento en las facturas de recursos para el anfitrión.
2. Un fragmento de texto en una página web se encuentra mientras una herramienta impulsada por LLM está recopilando información para responder a una consulta benigna. Esto lleva a que la herramienta realice muchas más solicitudes de páginas web, resultando en un gran consumo de recursos.
3. Un atacante bombardea continuamente al LLM con entradas que exceden su ventana de contexto. El atacante puede usar scripts automáticos o herramientas para enviar un alto volumen de entradas, abrumando las capacidades de procesamiento del LLM. Como resultado, el LLM consume recursos computacionales excesivos, lo que lleva a una desaceleración significativa o completa falta de respuesta del sistema.
4. Un atacante envía una serie de entradas secuenciales al LLM, con cada entrada diseñada para estar justo por debajo del límite de la ventana de contexto. Al enviar repetidamente estas entradas, el atacante busca agotar la capacidad disponible de la ventana de contexto. A medida que el LLM lucha por procesar cada entrada dentro de su ventana de contexto, los recursos del sistema se ven tensionados, lo que potencialmente resulta en un rendimiento degradado o una denegación completa del servicio.
5. Un atacante aprovecha los mecanismos recursivos del LLM para desencadenar repetidamente la expansión del contexto. Al elaborar entradas que explotan el comportamiento recursivo del LLM, el atacante obliga al modelo a expandir y procesar repetidamente la ventana de contexto, consumiendo recursos computacionales significativos. Este ataque tensiona el sistema y puede llevar a una condición de DoS, haciendo que el LLM no responda o causando su caída.
6. Un atacante inunda al LLM con un gran volumen de entradas de longitud variable, cuidadosamente elaboradas para acercarse o alcanzar el límite de la ventana de contexto. Al abrumar al LLM con entradas de longitudes variables, el atacante busca explotar cualquier ineficiencia en el procesamiento de entradas de longitud variable. Esta inundación de entradas pone una carga excesiva en los recursos del LLM, lo que potencialmente causa una degradación del rendimiento e impide la capacidad del sistema para responder a solicitudes legítimas.
7. Aunque los ataques de DoS comúnmente buscan abrumar los recursos del sistema, también pueden explotar otros aspectos del comportamiento del sistema, como las limitaciones de la API. Por ejemplo, en un reciente incidente de seguridad de Sourcegraph, el actor malicioso empleó un token de acceso de administrador filtrado para alterar los límites de tasa de la API, lo que potencialmente causó interrupciones del servicio al permitir niveles anormales de volúmenes de solicitudes.


### Enlaces de Referencia

1. [LangChain max_iterations](https://twitter.com/hwchase17/status/1608467493877579777): **hwchase17 on Twitter**
2. [Sponge Examples: Energy-Latency Attacks on Neural Networks](https://arxiv.org/abs/2006.03463): **Arxiv White Paper**
3. [OWASP DOS Attack](https://owasp.org/www-community/attacks/Denial_of_Service): **OWASP**
4. [Learning From Machines: Know Thy Context](https://lukebechtel.com/blog/lfm-know-thy-context): **Luke Bechtel**
5. [Sourcegraph Security Incident on API Limits Manipulation and DoS Attack ](https://about.sourcegraph.com/blog/security-update-august-2023): **Sourcegraph**
