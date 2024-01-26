## LLM03: Envenenamiento de los Datos de Entrenamiento

### Descripción

El punto de partida de cualquier enfoque de aprendizaje automático son los datos de entrenamiento, simplemente "texto en bruto". Para ser altamente capaz (por ejemplo, tener conocimiento lingüístico y del mundo), este texto debe abarcar una amplia gama de dominios, géneros e idiomas. Un modelo de lenguaje grande utiliza redes neuronales profundas para generar salidas basadas en patrones aprendidos de los datos de entrenamiento.

El envenenamiento de los datos de entrenamiento se refiere a la manipulación de los datos previos al entrenamiento o datos involucrados en los procesos de fine-tuning o incrustación para introducir vulnerabilidades (que tienen vectores de ataque únicos y a veces compartidos), puertas traseras o sesgos que podrían comprometer la seguridad, efectividad o comportamiento ético del modelo. La información envenenada puede ser mostrada a los usuarios o crear otros riesgos como degradación del rendimiento, explotación del software subyacente y daño a la reputación. Incluso si los usuarios desconfían de la salida problemática de la IA, los riesgos permanecen, incluyendo capacidades de modelo deterioradas y daño potencial a la reputación de la marca.

- Datos previos al entrenamiento se refiere al proceso de entrenar un modelo basado en una tarea o conjunto de los datos.
- El fine-tuning implica tomar un modelo existente que ya ha sido entrenado y adaptarlo a un tema más estrecho o a un objetivo más enfocado entrenándolo con un conjunto de los datos curado. Este conjunto de los datos generalmente incluye ejemplos de entradas y salidas deseadas correspondientes.
- El proceso de incrustación es el proceso de convertir datos categóricos (a menudo texto) en una representación numérica que se puede usar para entrenar un modelo de lenguaje. El proceso de incrustación implica representar palabras o frases de los datos de texto como vectores en un espacio vectorial continuo. Los vectores se generan típicamente alimentando los datos de texto en una red neuronal que ha sido entrenada en un gran corpus de texto.

El envenenamiento de los datos se considera un ataque a la integridad porque la manipulación de los datos de entrenamiento impacta la capacidad del modelo para generar predicciones correctas. Naturalmente, las fuentes de los datos externas presentan un riesgo mayor ya que los creadores del modelo no tienen control sobre los datos ni un alto nivel de confianza de que el contenido no contenga sesgos, información falsificada o contenido inapropiado.

### Ejemplos Comunes de Vulnerabilidad

1. Un actor malicioso o una marca competidora crea intencionalmente documentos inexactos o maliciosos dirigidos a los datos de pre-entrenamiento, fine-tuning o incrustaciones de un modelo. Considere ambos vectores de ataque [Envenenamiento de los Datos de Vista Dividida](https://github.com/GangGreenTemperTatum/speaking/blob/main/dc604/hacker-summer-camp-23/Ads%20_%20Poisoning%20Web%20Training%20Datasets%20_%20Flow%20Diagram%20-%20Exploit%201%20Split-View%20Data%20Poisoning.jpeg) y [Envenenamiento de los Datos Frontrunning](https://github.com/GangGreenTemperTatum/speaking/blob/main/dc604/hacker-summer-camp-23/Ads%20_%20Poisoning%20Web%20Training%20Datasets%20_%20Flow%20Diagram%20-%20Exploit%202%20Frontrunning%20Data%20Poisoning.jpeg) para ilustraciones.
   1. El modelo víctima se entrena usando información falsificada, lo que se refleja en las salidas de los prompts de IA generativa a sus consumidores.
2. Un actor malicioso logra inyectar directamente contenido falsificado, sesgado o dañino en los procesos de entrenamiento de un modelo, que se devuelve en salidas posteriores.
3. Un usuario desprevenido está inyectando indirectamente datos sensibles o propietarios en los procesos de entrenamiento de un modelo, que se devuelve en salidas posteriores.
4. Un modelo se entrena utilizando datos que no han sido verificados por su fuente, origen o contenido en ninguno de los ejemplos de etapa de entrenamiento, lo que puede llevar a resultados erróneos si los datos están contaminados o son incorrectos.
5. El acceso no restringido a la infraestructura o el sandboxing inadecuado puede permitir que un modelo ingiera datos de entrenamiento inseguros, lo que resulta en salidas sesgadas o dañinas. Este ejemplo también está presente en cualquiera de los ejemplos de etapa de entrenamiento.
   1. En este escenario, la entrada de un usuario al modelo puede reflejarse en la salida a otro usuario (lo que lleva a una violación), o el usuario de un LLM puede recibir salidas del modelo que son inexactas, irrelevantes o dañinas dependiendo del tipo de los datos ingeridos en comparación con el caso de uso del modelo (generalmente reflejado con una tarjeta de modelo).

*Tanto si es un desarrollador, cliente o consumidor general del LLM, es importante entender las implicaciones de cómo esta vulnerabilidad podría reflejar riesgos dentro de su aplicación LLM al interactuar con un LLM no propietario para entender la legitimidad de las salidas del modelo basadas en sus procedimientos de entrenamiento. De manera similar, los desarrolladores del LLM pueden estar en riesgo tanto de ataques directos como indirectos sobre datos internos o de terceros utilizados para el fine-tuning y la incrustación (lo más común), lo que como resultado crea un riesgo para todos sus consumidores*


### Estrategias de Prevención y Mitigación

1. Verificar la cadena de suministro de los datos de entrenamiento, especialmente cuando se obtienen de fuentes externas, así como mantener atestaciones a través de la metodología "ML-BOM" (Bill of Materials de Aprendizaje Automático) y verificar las tarjetas de modelo.
2. Verificar la legitimidad correcta de las fuentes de los datos específicas y los datos contenidos obtenidos durante las etapas de pre-entrenamiento, fine-tuning y incrustación.
3. Verificar su caso de uso para el LLM y la aplicación con la que se integrará. Crear diferentes modelos a través de los datos de entrenamiento separados o fine-tuning para diferentes casos de uso para crear una salida de IA generativa más granular y precisa según su caso de uso definido.
4. Asegurar un sandboxing suficiente a través de controles de red para evitar que el modelo raspe fuentes de los datos no deseadas que podrían obstaculizar la salida del aprendizaje automático.
5. Utilizar filtros estrictos de selección o de entrada para datos de entrenamiento específicos o categorías de fuentes de los datos para controlar el volumen de los datos falsificados. Sanitización de los datos, con técnicas como la detección de anomalías estadísticas y métodos de detección de anomalías para detectar y eliminar datos adversarios de ser alimentados potencialmente en el proceso de fine-tuning.
6. Elaborar preguntas de control sobre la fuente y propiedad de los conjuntos de los datos para asegurar que el modelo no haya sido envenenado, y adoptar esta cultura en el ciclo de "MLSecOps". Consultar recursos disponibles como [El Índice de Transparencia de Modelos Fundamentales](https://crfm.stanford.edu/fmti/) o [Tabla de Clasificación de LLM Abiertos](https://huggingface.co/spaces/HuggingFaceH4/open_llm_leaderboard) como ejemplo.
7. Utilizar DVC ([Control de Versiones de los Datos](https://dvc.org/doc/user-guide/analytics)) para identificar y rastrear con precisión la parte de un conjunto de los datos que puede haber sido manipulada, eliminada o añadida y que ha llevado al envenenamiento.
8. Utilizar Base de los Datos Vectorial para añadir información suministrada por el usuario en ayuda para proteger de envenenar a otros usuarios e incluso arreglar en producción sin tener que entrenar un nuevo modelo.
9. Técnicas de robustez adversaria como el aprendizaje federado y restricciones para minimizar el efecto de valores atípicos o entrenamiento adversario para ser vigoroso contra las peores perturbaciones de los datos de entrenamiento.
   1. Un enfoque de "MLSecOps" podría ser incluir la robustez adversaria en el ciclo de vida de entrenamiento con la técnica de auto envenenamiento.
   2. Un repositorio de ejemplo de esto sería [AutoPoison](https://github.com/azshue/AutoPoison) para pruebas, incluyendo ataques como Inyecciones de Contenido (“intentando promover una marca en las respuestas del modelo”) y Ataques de Rechazo (“haciendo que el modelo siempre se niegue a responder”) que se pueden lograr con este enfoque.
10. Pruebas y Detección, midiendo la pérdida durante la etapa de entrenamiento y analizando modelos entrenados para detectar señales de un ataque de envenenamiento al analizar el comportamiento del modelo en entradas de prueba específicas.
   1. Monitoreo y alertas sobre el número de respuestas sesgadas que superan un umbral.
   2. Uso de un bucle humano para revisar respuestas y auditorías.
   3. Implementar LLMs dedicados para comparar contra consecuencias no deseadas y entrenar otros LLMs utilizando [técnicas de aprendizaje por refuerzo](https://wandb.ai/ayush-thakur/Intro-RLAIF/reports/An-Introduction-to-Training-LLMs-Using-Reinforcement-Learning-From-Human-Feedback-RLHF---VmlldzozMzYyNjcy).
   4. Realizar [ejercicios de Red Team LLM](https://www.anthropic.com/index/red-teaming-language-models-to-reduce-harms-methods-scaling-behaviors-and-lessons-learned) o [escaneos de vulnerabilidad LLM](https://github.com/leondz/garak) en las fases de prueba del ciclo de vida del LLM.

### Ejemplos de Escenarios de Ataque

1. La salida del prompt de IA generativa del LLM puede inducir a error a los usuarios de la aplicación, lo que puede llevar a opiniones sesgadas, seguidores o incluso peor, crímenes de odio, etc.
2. Si los datos de entrenamiento no se filtran y|o sanitizan correctamente, un usuario malicioso de la aplicación puede intentar influir e inyectar datos tóxicos en el modelo para que se adapte a los datos sesgados y falsos.
3. Un actor malicioso o un competidor crea intencionalmente documentos inexactos o maliciosos dirigidos a los datos de entrenamiento de un modelo en el que se está entrenando el modelo al mismo tiempo en base a entradas. El modelo víctima se entrena utilizando esta información falsificada, lo que se refleja en las salidas de los prompts de IA generativa a sus consumidores.
4. La vulnerabilidad [Inyección de Prompt](https://github.com/OWASP/www-project-top-10-for-large-language-model-applications/blob/main/1_0_vulns/PromptInjection.md) podría ser un vector de ataque para esta vulnerabilidad si no se realiza una sanitización y filtrado suficientes cuando la entrada de los clientes de la aplicación LLM se utiliza para entrenar el

### Enlaces de Referencia

1. [Stanford Research Paper:CS324](https://stanford-cs324.github.io/winter2022/lectures/data/): **Stanford Research**
2. [How data poisoning attacks corrupt machine learning models](https://www.csoonline.com/article/3613932/how-data-poisoning-attacks-corrupt-machine-learning-models.html): **CSO Online**
3. [MITRE ATLAS (framework) Tay Poisoning](https://atlas.mitre.org/studies/AML.CS0009/): **MITRE ATLAS**
4. [PoisonGPT: How we hid a lobotomized LLM on Hugging Face to spread fake news](https://blog.mithrilsecurity.io/poisongpt-how-we-hid-a-lobotomized-llm-on-hugging-face-to-spread-fake-news/): **Mithril Security**
5. [Inject My PDF: Prompt Injection for your Resume](https://kai-greshake.de/posts/inject-my-pdf/): **Kai Greshake**
6. [Backdoor Attacks on Language Models](https://towardsdatascience.com/backdoor-attacks-on-language-models-can-we-trust-our-models-weights-73108f9dcb1f): **Towards Data Science**
7. [Poisoning Language Models During Instruction](https://arxiv.org/abs/2305.00944): **Arxiv White Paper**
8. [FedMLSecurity:arXiv:2306.04959](https://arxiv.org/abs/2306.04959): **Arxiv White Paper**
9. [The poisoning of ChatGPT](https://softwarecrisis.dev/letters/the-poisoning-of-chatgpt/): **Software Crisis Blog**
10. [Poisoning Web-Scale Training Datasets - Nicholas Carlini | Stanford MLSys #75](https://www.youtube.com/watch?v=h9jf1ikcGyk): **YouTube Video**
11. [OWASP CycloneDX v1.5](https://cyclonedx.org/capabilities/mlbom/): **OWASP CycloneDX**
