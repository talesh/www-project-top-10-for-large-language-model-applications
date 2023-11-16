Lista Top 10 de OWASP para Grandes Modelos de Lenguaje (LLM)
Versión 1.0 
Fecha de Publicación: 1 de Agosto de 2023




El auge en el interés por los Grandes Modelos de Lenguaje (LLMs por sus siglas en Inglés), seguido por un masivo mercado de robots conversacionales, o chatbots, a finales del 2022 ha sido notable. Las organizaciones, en busca de aprovechar el potencial de los Grandes Modelos de Lenguaje, han venido integrándolos rápidamente en sus operaciones y en el relacionamiento con sus clientes. Sin embargo, el acelerado ritmo con el que los Grandes Modelos de Lenguaje están siendo adoptados sobrepasa la velocidad con la que se han podido establecer protocolos de seguridad exhaustivos; por lo muchas aplicaciones podrían contener problemas asociados a altos riesgos de seguridad de la información.


La ausencia de recursos unificados para tratar estas preocupaciones de seguridad en Grandes Modelos de Lenguaje era evidente. Los desarrolladores de software, al no estar familiarizados con los riesgos específicos asociados con los Grandes Modelos de Lenguaje, se encontraban dispersos alrededor de esta materia, lo cual es un problema que se encuentra claramente dentro de la misión de OWASP de orientar una adopción más segura de esta tecnología.
¿A quien se encuentra dirigido este documento?
Principalmente desarrolladores, científicos de datos y expertos en seguridad encargados del diseño de aplicaciones e integraciones soportadas en tecnologías de Grandes Modelos de Lenguaje. Nuestro objetivo es poner a disposición de estos profesionales una orientación en seguridad que sea práctica, concreta y funcional; de manera que se puedan enfocar correctamente en el complejo y creciente terreno de la seguridad en los Grandes Modelos de Lenguaje.


La elaboración de esta lista
La creación de la lista Top 10 de OWASP para Grandes Modelos de Lenguaje (LLM) fue una tarea demandante que se logró a partir de la experiencia colectiva de un equipo internacional de cerca de 500 expertos, dentro de los cuales hubo 125 colaboradores directos. Los participantes provinieron de diversos campos; dentro de los que se puede incluir a compañías de Inteligencia Artificial, seguridad, distribuidores de software, proveedores de computación en la nube, fabricantes de hardware y la academia.


En el lapso de un mes, el equipo formuló y propuso un listado de hasta 43 diferentes amenazas. A través de múltiples rondas de votación estas propuestas fueron refinadas para obtener una lista concreta con las diez vulnerabilidades más críticas que se identificaron. Posteriormente, estas vulnerabilidades fueron analizadas más a fondo y refinadas por parte de equipos más pequeños enfocados en cada una de ellas, para luego ser sometidas a revisión pública con el fin de asegurar un resultado integral y útil.






Relación con otras listas OWASP Top 10


A pesar de que esta lista comparte su esencia con las vulnerabilidades encontradas en otras listas OWASP Top 10, esta lista no se trata simplemente de reiterar las vulnerabilidades de esas listas. Al contrario, el equipo ahondó en las implicaciones particulares que estas vulnerabilidades podrían tener en caso de encontrarse en aplicaciones que utilizan Grandes Modelos de Lenguaje.


Nuestro objetivo es generar un puente de entendimiento sobre la brecha que existe entre la aplicación general de los principios de seguridad y los desafíos específicos que plantea el uso de Grandes Modelos de Lenguaje. Esto incluye una labor de indagación acerca de cómo las vulnerabilidades convencionales podrían representar nuevos riesgos o ser explotadas a través de nuevos mecanismos en el entorno de los Grandes Modelos de Lenguaje. Adicionalmente, hemos analizado cómo las estrategias de enmendación tradicionales deben ser adaptadas a aquellas aplicaciones que utilizan Grandes Modelos de Lenguaje.


El futuro


Esta primera versión de la lista no será la última. Esperamos actualizarla periódicamente a fin de mantener el ritmo con el que avanza la industria. Trabajaremos con la comunidad a fin de que el estado del arte evolucione y para crear más herramientas educativas para una gama más amplia de usos. También buscamos la colaboración con organizaciones de estandarización y con gobiernos en materia de seguridad para la Inteligencia Artificial. Aquellos que se encuentren interesados son bienvenidos a unirse a nuestro equipo y trabajar colaborativamente.


Steve Wilson
Líder de Proyecto, Lista OWASP Top 10 para Grandes Modelos de Lenguaje y Aplicaciones de Inteligencia Artificial
Twitter/X: @virtualsteve






Lista OWASP Top 10 para Grandes Modelos de Lenguaje


LLM01: Inyección de Solicitudes
Manipulación de Grandes Modelos de Lenguaje a través de ingreso de información elaborada y viciada que puede causar comportamientos no esperados. En este caso pueden existir inyecciones directas, que sobre-escriben las solicitudes del sistema; así como inyecciones indirectas, que manipulan las solicitudes a través de mecanismos externos.


LLM02: Manejo Inseguro de la Información de Salida
Esto ocurre cuando la información de salida de un Modelo de Lenguaje es entregada de forma desprevenida, exponiendo los sistemas del backend. Una implementación inadecuada puede acarrear riesgos severos como Cross-Site Scripting, Cross-Site Request Forgery, Server-Side Request Forgery, escalamiento de privilegios o ejecución remota de código.


LLM03: Alteración de los datos de entrenamiento
Esto sucede cuando los datos de entrenamiento del modelo de lenguaje son manipulados para introducir vulnerabilidades o sesgos indeseados que podrían comprometer la seguridad, la efectividad o el comportamiento ético del modelo. Algunas fuentes podrían ser el rastreo común, texto tomado de la web, texto abierto tomado de la web y libros.


LLM04: Denegación del servicio del modelo
Los atacantes podrían inyectar operaciones altamente demandantes en los modelos de lenguaje, causando degradación del servicio o elevados costos de procesamiento. Esta vulnerabilidad podría tener un impacto aumentado debido a la naturaleza de los procesos altamente demandantes de los modelos de lenguaje y la imposibilidad de predecir la información que ingresarán los usuarios.


LLM05: Vulnerabilidades de la cadena de suministro
El ciclo de vida de las aplicaciones basadas en modelos de lenguaje puede verse afectado por componentes o servicios vulnerables, llevando a posibles ataques de seguridad. El uso de conjuntos de datos externos, modelos previamente entrenados y plugins podría agregar vulnerabilidades al modelo.


LLM06: Revelación de información sensible
Los modelos de lenguaje podrían revelar información confidencial inadvertidamente como parte de las respuestas generadas dentro de ellos, lo cual conlleva acceso no autorizado a los datos, violaciones de privacidad y brechas de seguridad. Es imperativo implementar mecanismos de sanitización de los datos y políticas estrictas que mitiguen esta situación.


LLM07: Diseño inseguro de los plugins
Los plugins de los modelos de lenguaje podrían incluir ingreso de datos inseguro o un control de acceso insuficiente. Esta insuficiencia en el control del código de la aplicación podría facilitar futuros exploits y consecuencias como la ejecución de código remoto.


LLM08: Funcionalidad excesiva
Los sistemas basados en modelos de lenguaje podrían efectuar operaciones con resultados no intencionados. Este problema podría derivarse especialmente de rutinas y funcionalidades innecesariamente complejas o extensas, así como de permisos de acceso o niveles de autonomía concedidos innecesariamente a los sistemas basados en modelos de lenguaje.


LLM09: Exceso de confianza
Aquellos sistemas o personas que depositan un alto nivel de confianza en los modelos de lenguaje sin supervisión de los resultados o aseguramiento de la calidad podrían enfrentar desinformación, incomunicación, problemas de seguridad e, inclusive, consecuencias legales debido a la generación incorrecta o inapropiada de contenido por parte de los modelos de lenguaje.


LLM10: Secuestro o robo del modelo
Se refiere al acceso no autorizado, la copia o la apropiación irregular del modelo. El impacto podría incluir pérdidas económicas, compromiso de las ventajas competitivas y el acceso potencial a información sensible.




