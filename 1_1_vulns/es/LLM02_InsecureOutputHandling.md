## LLM02: Manejo Inseguro de Salidas

### Descripción

El Manejo Inseguro de Salidas se refiere específicamente a la validación, sanitización y manejo insuficientes de las salidas generadas por modelos de lenguaje grandes antes de que sean pasadas a otros componentes y sistemas aguas abajo. Dado que el contenido generado por LLM puede ser controlado por entradas de prompt, este comportamiento es similar a proporcionar a los usuarios acceso indirecto a funcionalidades adicionales.

El Manejo Inseguro de Salidas difiere de la Sobredependencia en que se ocupa de las salidas generadas por LLM antes de que sean pasadas aguas abajo, mientras que la Sobredependencia se centra en preocupaciones más amplias en torno a la dependencia excesiva de la precisión y la adecuación de las salidas de LLM.

La explotación exitosa de una vulnerabilidad de Manejo Inseguro de Salidas puede resultar en XSS y CSRF en navegadores web, así como SSRF, escalada de privilegios o ejecución remota de código en sistemas de backend.

Las siguientes condiciones pueden aumentar el impacto de esta vulnerabilidad:
* La aplicación otorga al LLM privilegios más allá de lo que se pretende para los usuarios finales, lo que permite la escalada de privilegios o la ejecución remota de código.
* La aplicación es vulnerable a ataques indirectos de inyección de prompts, lo que podría permitir a un atacante obtener acceso privilegiado al entorno de un usuario objetivo.
* Los plugins de terceros no validan adecuadamente las entradas.

### Ejemplos Comunes de Vulnerabilidad

1. La salida del LLM se introduce directamente en un shell del sistema o en una función similar como exec o eval, lo que resulta en la ejecución remota de código.
2. JavaScript o Markdown es generado por el LLM y devuelto a un usuario. El código es entonces interpretado por el navegador, resultando en un ataque de tipo XSS (Cross-Site-Scripting).

### Estrategias de Prevención y Mitigación

1. Tratar el modelo como cualquier otro usuario, adoptando un enfoque de cero confianza y aplicando una validación de entrada adecuada en las respuestas provenientes del modelo para funciones de backend.
2. Seguir las pautas de OWASP ASVS (Estándar de Verificación de Seguridad de Aplicaciones) para garantizar una validación de entrada y una sanitización efectivas.
3. Codificar la salida del modelo de vuelta a los usuarios para mitigar la ejecución de código no deseado por JavaScript o Markdown. OWASP ASVS proporciona una guía detallada sobre la codificación de salidas.

### Ejemplos de Escenarios de Ataque

1. Una aplicación utiliza un plugin LLM para generar respuestas para una función de chatbot. El plugin también ofrece una serie de funciones administrativas accesibles a otro LLM privilegiado. El LLM de propósito general pasa directamente su respuesta, sin una validación de salida adecuada, al plugin, causando que el plugin se cierre para mantenimiento.
2. Un usuario utiliza una herramienta de resumen de sitios web impulsada por un LLM para generar un resumen conciso de un artículo. El sitio web incluye una inyección de prompt instruyendo al LLM para capturar contenido sensible ya sea del sitio web o de la conversación del usuario. Desde allí, el LLM puede codificar los datos sensibles y enviarlos, sin ninguna validación o filtrado de salida, a un servidor controlado por el atacante.
3. Un LLM permite a los usuarios elaborar consultas SQL para una base de datos backend a través de una función similar a un chat. Un usuario solicita una consulta para eliminar todas las tablas de la base de datos. Si la consulta elaborada por el LLM no se escudriña, entonces todas las tablas de la base de datos serán eliminadas.
4. Una aplicación web utiliza un LLM para generar contenido a partir de prompts de texto del usuario sin sanitización de salida. Un atacante podría enviar un prompt diseñado para que el LLM devuelva un payload de JavaScript no sanitizado, lo que lleva a un ataque XSS cuando se renderiza en el navegador de una víctima. La insuficiente validación de prompts habilitó este ataque.

### Enlaces de Referencia

1. [Arbitrary Code Execution](https://security.snyk.io/vuln/SNYK-PYTHON-LANGCHAIN-5411357): **Snyk Security Blog**
2. [ChatGPT Plugin Exploit Explained: From Prompt Injection to Accessing Private Data](https://embracethered.com/blog/posts/2023/chatgpt-cross-plugin-request-forgery-and-prompt-injection./): **Embrace The Red**
3. [New prompt injection attack on ChatGPT web version. Markdown images can steal your chat data.](https://systemweakness.com/new-prompt-injection-attack-on-chatgpt-web-version-ef717492c5c2?gi=8daec85e2116): **System Weakness**
4. [Don’t blindly trust LLM responses. Threats to chatbots](https://embracethered.com/blog/posts/2023/ai-injections-threats-context-matters/): **Embrace The Red**
5. [Threat Modeling LLM Applications](https://aivillage.org/large%20language%20models/threat-modeling-llm/): **AI Village**
6. [OWASP ASVS - 5 Validation, Sanitization and Encoding](https://owasp-aasvs4.readthedocs.io/en/latest/V5.html#validation-sanitization-and-encoding): **OWASP AASVS**
