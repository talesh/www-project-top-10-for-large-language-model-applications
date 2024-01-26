# OWASP Top 10 para LLM
### Versión 1.1
Publicado: 16 de Octubre de 2023

## Introducción

El frenesí de interés en los Modelos de Lenguaje de Gran Escala (LLMs) tras el lanzamiento de chatbots pre-entrenados para el mercado masivo a finales de 2022 ha sido notable. Las empresas, ansiosas por aprovechar el potencial de los LLMs, los están integrando rápidamente en sus operaciones y ofertas orientadas al cliente. Sin embargo, la velocidad vertiginosa con la que se están adoptando los LLMs ha superado el establecimiento de protocolos de seguridad integrales, dejando muchas aplicaciones vulnerables a problemas de alto riesgo.

La ausencia de un recurso unificado que aborde estas preocupaciones de seguridad en los LLMs era evidente. Los desarrolladores, no familiarizados con los riesgos específicos asociados con los LLMs, se encontraban con recursos dispersos y la misión de OWASP parecía encajar perfectamente para ayudar a impulsar una adopción más segura de esta tecnología.

### ¿A quién va dirigido?
Nuestra audiencia principal son los desarrolladores, científicos de datos y expertos en seguridad encargados de diseñar y construir aplicaciones y complementos que aprovechan las tecnologías LLM. Nuestro objetivo es proporcionar orientación de seguridad práctica, accionable y concisa para ayudar a estos profesionales a navegar por el terreno complejo y en constante evolución de la seguridad de las aplicaciones LLM.

### La Creación de la Lista
Crear la lista OWASP Top 10 para Aplicaciones LLM fue una tarea significativa, construida sobre la experiencia colectiva de un equipo internacional de casi 500 expertos con más de 125 colaboradores activos. Nuestros colaboradores provienen de diversos antecedentes, incluyendo empresas de IA, empresas de seguridad, ISVs, hiperescaladores en la nube, proveedores de hardware y el ámbito académico.

Durante un mes, realizamos lluvias de ideas y propusimos vulnerabilidades potenciales, con miembros del equipo redactando 43 amenazas distintas. A través de múltiples rondas de votación, refinamos estas propuestas a una lista concisa de las diez vulnerabilidades más críticas. Subequipos dedicados examinaron cada vulnerabilidad y la sometieron a revisión pública, asegurando la lista final más completa y accionable.

Cada una de estas vulnerabilidades, junto con ejemplos, consejos de prevención, escenarios de ataque y referencias, fue además escudriñada y refinada por subequipos dedicados y sometida a revisión pública, asegurando la lista final más completa y accionable.

### Relación con otras Listas OWASP Top 10
Aunque nuestra lista comparte ADN con tipos de vulnerabilidades encontradas en otras listas OWASP Top 10, no nos limitamos a reiterar estas vulnerabilidades. En su lugar, profundizamos en las implicaciones únicas que estas vulnerabilidades tienen cuando se encuentran en aplicaciones que utilizan LLMs.

Nuestro objetivo es cerrar la brecha entre los principios generales de seguridad de aplicaciones y los desafíos específicos que plantean los LLMs. Esto incluye explorar cómo las vulnerabilidades convencionales pueden plantear diferentes riesgos o podrían ser explotadas de maneras novedosas dentro de los LLMs, así como cómo las estrategias de remediación tradicionales deben adaptarse para aplicaciones que utilizan LLMs.

### Acerca de la Versión 1.1
Aunque nuestra lista comparte ADN con tipos de vulnerabilidades encontradas en otras listas OWASP Top 10, no nos limitamos a reiterar estas vulnerabilidades. En cambio, profundizamos en las implicaciones únicas de estas vulnerabilidades cuando se encuentran en aplicaciones que utilizan LLMs. Nuestro objetivo es cerrar la brecha entre los principios generales de seguridad de aplicaciones y los desafíos específicos que plantean los LLMs.

Los objetivos del grupo incluyen explorar cómo las vulnerabilidades convencionales pueden plantear diferentes riesgos o ser explotadas de maneras novedosas dentro de los LLMs y cómo los desarrolladores deben adaptar las estrategias tradicionales de remediación para aplicaciones que utilizan LLMs.

### El Futuro
La versión 1.1 de la lista no será la última. Esperamos actualizarla periódicamente para mantener el ritmo con el estado de la industria. Trabajaremos con la comunidad más amplia para impulsar el estado del arte y crear más materiales educativos para una variedad de usos. También buscamos colaborar con organismos de normalización y gobiernos en temas de seguridad de IA. Te invitamos a unirte a nuestro grupo y contribuir.



### Steve Wilson
Project Lead, OWASP Top 10 for LLM Applications
[https://www.linkedin.com/in/wilsonsd](https://www.linkedin.com/in/wilsonsd/)    
Twitter/X: @virtualsteve


### Ads Dawson
v1.1 Release Lead & Vulnerability Entries Lead, OWASP Top 10 for LLM Applications
[https://www.linkedin.com/in/adamdawson0](https://www.linkedin.com/in/adamdawson0/) 
GitHub: @GangGreenTemperTatum



## About this Translation

**Translators**

- **Manuel S. Lemos**  
[https://www.linkedin.com/in/manuelslemos/](https://www.linkedin.com/in/manuelslemos/)  


En la creación de esta traducción, decidimos conscientemente emplear solo traductores humanos, reconociendo la naturaleza excepcionalmente técnica y crítica del OWASP Top Ten para LLMs. Los traductores mencionados anteriormente no solo poseen una profunda comprensión del contenido original, sino también la fluidez necesaria para hacer de esta traducción un éxito.

Talesh Seeparsan
Translations Lead, OWASP Top 10 for LLM Applications
[https://www.linkedin.com/in/talesh/](https://www.linkedin.com/in/talesh/)  



## ﻿OWASP Top 10 for Large Language Model Applications

### LLM01: Inyección de Prompt
Las entradas astutas pueden manipular un Modelo de Lenguaje de Gran Escala, causando acciones no intencionadas. Las inyecciones directas sobrescriben los prompts del sistema, mientras que las indirectas manipulan entradas de fuentes externas.

### LLM02: Manejo Inseguro de Salidas
Esta vulnerabilidad ocurre cuando una salida del LLM se acepta sin escrutinio, exponiendo sistemas de backend. El mal uso puede llevar a consecuencias graves como XSS, CSRF, SSRF, escalada de privilegios o ejecución remota de código.

### LLM03: Envenenamiento de los Datos de Entrenamiento
Esto ocurre cuando los datos de entrenamiento de un LLM son manipulados, introduciendo vulnerabilidades o sesgos que comprometen la seguridad, la efectividad o el comportamiento ético. Las fuentes incluyen Common Crawl, WebText, OpenWebText y libros.

### LLM04: Denegación de Servicio en Modelos
Los atacantes provocan operaciones que consumen muchos recursos en Modelos de Lenguaje de Gran Escala, llevando a la degradación del servicio o altos costos. La vulnerabilidad se magnifica debido a la naturaleza intensiva en recursos de los LLM y la imprevisibilidad de las entradas de los usuarios.

### LLM05: Vulnerabilidades en la Cadena de Suministro
El ciclo de vida de la aplicación LLM puede verse comprometido por componentes o servicios vulnerables, llevando a ataques de seguridad. Usar conjuntos de datos de terceros, modelos preentrenados y plugins puede añadir vulnerabilidades.

### LLM06: Divulgación de Información Sensible
Los LLM pueden revelar datos confidenciales en sus respuestas, llevando a acceso no autorizado a datos, violaciones de privacidad y brechas de seguridad. Es crucial implementar la sanitización de datos y políticas estrictas de usuarios para mitigar esto.

### LLM07: Diseño Inseguro de Plugin
Los plugins de LLM pueden tener entradas inseguras y control de acceso insuficiente. Esta falta de control de la aplicación los hace más fáciles de explotar y puede resultar en consecuencias como la ejecución remota de código.

### LLM08: Responsabilidad Excesiva
Los sistemas basados en LLM pueden emprender acciones que llevan a consecuencias no intencionadas. El problema surge de la funcionalidad excesiva, permisos o autonomía otorgados a los sistemas basados en LLM.

### LLM09: Sobredependencia
Sistemas o personas que dependen excesivamente de los LLM sin supervisión pueden enfrentarse a desinformación, malentendidos, problemas legales y vulnerabilidades de seguridad debido a contenido incorrecto o inapropiado generado por LLM.

### LLM10: Robo de Modelo
Esto implica el acceso no autorizado, copia o exfiltración de modelos LLM propietarios. El impacto incluye pérdidas económicas, ventaja competitiva comprometida y acceso potencial a información sensible.
