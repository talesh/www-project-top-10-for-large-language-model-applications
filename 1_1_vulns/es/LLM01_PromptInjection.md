## LLM01: Inyección de Prompt

### Descripción

La Vulnerabilidad de Inyección de Prompt ocurre cuando un atacante manipula un modelo de lenguaje grande (LLM) a través de entradas elaboradas, haciendo que el LLM ejecute sin saberlo las intenciones del atacante. Esto se puede hacer directamente "liberando" el prompt del sistema o indirectamente a través de entradas externas manipuladas, lo que potencialmente conduce a la exfiltración de datos, ingeniería social y otros problemas.

* **Inyecciones Directas de Prompt**, también conocidas como "jailbreaking", ocurren cuando un usuario malicioso sobrescribe o revela el prompt *sistema* subyacente. Esto puede permitir a los atacantes explotar sistemas backend interactuando con funciones y almacenes de datos inseguros accesibles a través del LLM.
* **Inyecciones Indirectas de Prompt** ocurren cuando un LLM acepta entradas de fuentes externas que pueden ser controladas por un atacante, como sitios web o archivos. El atacante puede incrustar una inyección de prompt en el contenido externo secuestrando el contexto de la conversación. Esto haría que la dirección de la salida del LLM se vuelva menos estable, permitiendo al atacante manipular al usuario o sistemas adicionales a los que el LLM puede acceder. Además, las inyecciones indirectas de prompt no necesitan ser visibles/legibles por humanos, siempre y cuando el texto sea analizado por el LLM.

Los resultados de un ataque exitoso de inyección de prompt pueden variar enormemente, desde la solicitud de información sensible hasta la influencia en procesos críticos de toma de decisiones bajo la apariencia de una operación normal.

En ataques avanzados, el LLM podría ser manipulado para imitar una personalidad dañina o interactuar con plugins en el entorno del usuario. Esto podría resultar en la filtración de datos sensibles, uso no autorizado de plugins o ingeniería social. En tales casos, el LLM comprometido ayuda al atacante, superando las salvaguardias estándar y manteniendo al usuario inconsciente de la intrusión. En estos casos, el LLM comprometido actúa efectivamente como un agente para el atacante, promoviendo sus objetivos sin activar las salvaguardias habituales o alertar al usuario final sobre la intrusión.

### Ejemplos Comunes de Vulnerabilidad

1. Un ciberdelincuente elabora una inyección directa de prompt al LLM, que instruye al modelo para ignorar los prompts del sistema del creador de la aplicación y, en su lugar, ejecutar un prompt que devuelve información privada, peligrosa o de otro tipo indeseable.
2. Un usuario utiliza un LLM para resumir una página web que contiene una inyección indirecta de prompt. Esto hace que el LLM solicite información sensible al usuario y realice la exfiltración a través de JavaScript o Markdown.
3. Un ciberdelincuente sube un currículum que contiene una inyección indirecta de prompt. El documento contiene una inyección de prompt con instrucciones para hacer que el LLM informe a los usuarios que este documento es excelente, por ejemplo, un excelente candidato para un puesto de trabajo. Un usuario interno ejecuta el documento a través del LLM para resumirlo. La salida del LLM indica que este es un excelente documento.
4. Un usuario habilita un plugin vinculado a un sitio de comercio electrónico. Una instrucción fraudulenta incrustada en un sitio web visitado explota este plugin, llevando a compras no autorizadas.
5. Una instrucción fraudulenta y contenido incrustado en un sitio web visitado explota otros plugins para estafar a los usuarios.

### Estrategias de Prevención y Mitigación

Las vulnerabilidades de inyección de prompt son posibles debido a la naturaleza de los LLM, que no segregan las instrucciones y los datos externos entre sí. Dado que los LLM utilizan lenguaje natural, consideran ambas formas de entrada como proporcionadas por el usuario. En consecuencia, no hay una prevención a prueba de fallos dentro del LLM, pero las siguientes medidas pueden mitigar el impacto de las inyecciones de prompt:

1. Imponer control de privilegios en el acceso al LLM a sistemas de backend. Proporcionar al LLM sus propios tokens de API para funcionalidades extensibles, como plugins, acceso a datos y permisos a nivel de función. Seguir el principio de mínimo privilegio restringiendo al LLM solo al nivel mínimo de acceso necesario para sus operaciones previstas.
2. Añadir un humano en el bucle para funcionalidades extendidas. Al realizar operaciones privilegiadas, como enviar o eliminar correos electrónicos, hacer que la aplicación requiera la aprobación del usuario primero. Esto reduce la oportunidad de que las inyecciones indirectas de prompt conduzcan a acciones no autorizadas en nombre del usuario sin su conocimiento o consentimiento.
3. Segregar el contenido externo de los prompts del usuario. Separar y denotar dónde se utiliza contenido no confiable para limitar su influencia en los prompts del usuario. Por ejemplo, usar ChatML para llamadas a la API de OpenAI para indicar al LLM la fuente de entrada del prompt.
4. Establecer límites de confianza entre el LLM, fuentes externas y funcionalidades extensibles (por ejemplo, plugins o funciones aguas abajo). Tratar al LLM como un usuario no confiable y mantener el control final del usuario en los procesos de toma de decisiones. Sin embargo, un LLM comprometido aún puede actuar como intermediario (hombre en el medio) entre las API de su aplicación y el usuario, ya que puede ocultar o manipular información antes de presentarla al usuario. Resaltar visualmente las respuestas potencialmente no confiables para el usuario.
5. Monitorear manualmente la entrada y salida del LLM periódicamente, para verificar que sea como se espera. Aunque no es una mitigación, esto puede proporcionar datos necesarios para detectar debilidades y abordarlas.

### Ejemplos de Escenarios de Ataque

1. Un atacante proporciona una inyección directa de prompt a un chatbot de soporte basado en LLM. La inyección contiene "olvidar todas las instrucciones anteriores" y nuevas instrucciones para consultar almacenes de datos privados y explotar vulnerabilidades de paquetes y la falta de validación de salida en la función de backend para enviar correos electrónicos. Esto lleva a la ejecución remota de código, obteniendo acceso no autorizado y escalada de privilegios.
2. Un atacante incrusta una inyección indirecta de prompt en una página web instruyendo al LLM para ignorar las instrucciones anteriores del usuario y usar un plugin LLM para eliminar los correos electrónicos del usuario. Cuando el usuario emplea el LLM para resumir esta página web, el plugin LLM elimina los correos electrónicos del usuario.
3. Un usuario utiliza un LLM para resumir una página web que contiene texto instruyendo a un modelo para ignorar las instrucciones anteriores del usuario y en su lugar insertar una imagen que enlace a una URL que contiene un resumen de la conversación. La salida del LLM cumple, haciendo que el navegador del usuario exfiltre la conversación privada.
4. Un usuario malicioso sube un currículum con una inyección de prompt. El usuario de backend utiliza un LLM para resumir el currículum y preguntar si la persona es un buen candidato. Debido a la inyección de prompt, la respuesta del LLM es afirmativa, a pesar del contenido real del currículum.
5. Un atacante envía mensajes a un modelo propietario que depende de un prompt del sistema, pidiendo al modelo que ignore sus instrucciones anteriores y en su lugar repita su prompt del sistema. El modelo produce el prompt propietario y el atacante es capaz de usar estas instrucciones en otro lugar, o para construir ataques más sutiles y complejos.

### Enlaces de Referencia

1. [Prompt injection attacks against GPT-3](https://simonwillison.net/2022/Sep/12/prompt-injection/): **Simon Willison**
1. [ChatGPT Plugin Vulnerabilities - Chat with Code](https://embracethered.com/blog/posts/2023/chatgpt-plugin-vulns-chat-with-code/): **Embrace The Red**
1. [ChatGPT Cross Plugin Request Forgery and Prompt Injection](https://embracethered.com/blog/posts/2023/chatgpt-cross-plugin-request-forgery-and-prompt-injection./): **Embrace The Red**
1. [Not what you’ve signed up for: Compromising Real-World LLM-Integrated Applications with Indirect Prompt Injection](https://arxiv.org/pdf/2302.12173.pdf):  **Arxiv preprint**
1. [Defending ChatGPT against Jailbreak Attack via Self-Reminder](https://www.researchsquare.com/article/rs-2873090/v1): **Research Square**
1. [Prompt Injection attack against LLM-integrated Applications](https://arxiv.org/abs/2306.05499): **Arxiv preprint**
1. [Inject My PDF: Prompt Injection for your Resume](https://kai-greshake.de/posts/inject-my-pdf/): **Kai Greshake**
1. [ChatML for OpenAI API Calls](https://github.com/openai/openai-python/blob/main/chatml.md): **OpenAI Github**
1. [Threat Modeling LLM Applications](http://aivillage.org/large%20language%20models/threat-modeling-llm/): **AI Village**
1. [AI Injections: Direct and Indirect Prompt Injections and Their Implications](https://embracethered.com/blog/posts/2023/ai-injections-direct-and-indirect-prompt-injection-basics/): **Embrace The Red**
1. [Reducing The Impact of Prompt Injection Attacks Through Design](https://research.kudelskisecurity.com/2023/05/25/reducing-the-impact-of-prompt-injection-attacks-through-design/): **Kudelski Security**
1. [Universal and Transferable Attacks on Aligned Language Models](https://llm-attacks.org/): **LLM-Attacks.org**
1. [Indirect prompt injection](https://kai-greshake.de/posts/llm-malware/): **Kai Greshake**
1. [Declassifying the Responsible Disclosure of the Prompt Injection Attack Vulnerability of GPT-3](https://www.preamble.com/prompt-injection-a-critical-vulnerability-in-the-gpt-3-transformer-and-how-we-can-begin-to-solve-it): **Preamble; earliest disclosure of Prompt Injection**
