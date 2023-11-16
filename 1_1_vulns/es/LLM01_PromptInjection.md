LLM01: Inyección de Solicitudes


Esta vulnerabilidad ocurre cuando un atacante manipula un modelo de lenguaje a través del envío de peticiones elaboradas con el propósito de forzar el modelo a efectuar acciones indeseadas de forma inadvertida. Esto podría lograrse inhabilitando los controles del sistema de ingreso de peticiones o a través de inyección de peticiones desde sistemas externos manipulados para este fin. Esta vulnerabilidad podría conllevar filtración de datos y actos de ingeniería social entre otros problemas.


* La inyección directa de solicitudes, o jailbreaking en inglés, ocurre cuando un usuario malintencionado es capaz de inspeccionar y sobre-escribir el código del sistema por medio del cual el modelo recibe las solicitudes. Esto podría permitir que los atacantes abusen de los sistemas de backend a través de funciones inseguras y accedan a los sistemas de almacenamiento de datos que se encuentren conectados con el modelo.


* La inyección indirecta de solicitudes ocurre cuando un modelo acepta solicitudes desde fuentes externas, diferentes al sistema de ingreso de solicitudes originalmente concebido para este fin; por ejemplo, archivos y páginas web. Estas fuentes podrían llegar a ser controladas por un atacante, que podría alterar las solicitudes y secuestrar así el contexto de la conversación. En este escenario el modelo podría actuar de forma errática, permitiendo que el atacante manipule al usuario o los otros sistemas con los que el modelo interactúa.


Los resultados de un ataque de inyección de solicitudes pueden variar ampliamente, desde la obtención de información sensible hasta influir en la toma de decisiones críticas bajo la apariencia de que todo se encuentra en condiciones normales.


En el escenario de ataques más avanzados, el modelo podría ser manipulado para reproducir acciones malintencionadas o interactuar con otros sistemas del lado del usuario con los que el modelo tenga la oportunidad de interactuar. De esta manera podrían revelarse datos sensibles, uso no autorizado de plugins o actos de ingeniería social. En todos estos casos, el modelo podría servir como plataforma para que el atacante pueda sobrepasar los controles de seguridad y pasar desapercibido en toda la maniobra. Llegados a este punto, el modelo comprometido efectivamente actuaría como un agente en favor del atacante, acercándole a sus objetivos sin despertar sospechas ni alertas en los sistemas de supervisión contra intrusiones.


Ejemplos comunes de esta vulnerabilidad


1. Un usuario malintencionado fabrica una inyección directa de solicitudes que le ordena al modelo ignorar las solicitudes y/o reglas del creador de la aplicación y, en su lugar, ejecute una solicitud que retorna información privada, peligrosa o cualquier otro tipo de información no deseada.
2. Un usuario genuino utiliza un modelo para procesar el contenido de una página web, dentro de la cual se ha dispuesto previamente una inyección de solicitudes. Allí podría solicitarse información privada al usuario a través de JavaScript o Markdown, el modelo podría revelar datos del usuario al completar esta información por él.
3. Un usuario malintencionado carga en el sistema un curriculum que contiene una inyección de solicitudes indirectas. El contenido del archivo incluye instrucciones para que el modelo le informe a otros usuarios que se trata de un documento "excelente", por ejemplo que el candidato a quien corresponde este curriculum es un buen candidato para un cierto puesto de trabajo. Un usuario de la compañía que ha abierto esta posición de trabajo utiliza el modelo para evaluar posibles candidatos podría obtener información alterada que beneficie al usuario malintencionado.
4. Un usuario genuino instala un plugin que se conecta a un sitio de comercio electrónico. Al visitar un sitio web infectado con una inyección de solicitudes a este plugin podría derivar en compras o transacciones no autorizadas.
5. Una instrucción malintencionada incrustada en el contenido de un sitio web visitado por un usuario incauto podría explotar otros plugins instalados en el navegador del usuario con el fin de estafarle.


Cómo prevenir este ataque


Los ataques de inyección de solicitudes son posibles debido a la naturaleza de los modelos de lenguaje. Los cuales no distinguen las instrucciones de los datos externos, sino que juntos se convierten en un solo dato de entrada para el modelo. Debido a que los modelos utilizan lenguaje natural, estos asumen que la información ingresada por el usuario contiene las dos; por lo tanto no existe una forma de prevención "a prueba de todo", aunque las siguientes medidas ayudarán a mitigar el impacto de la inyección de solicitudes si llegase a suceder:


1. Asegurarse de que existe control y restricción al acceso del modelo a los sistemas de backend. Agregar al modelo tokens de acceso propios para las APIs de funcionalidad extendida como plugins, acceso a datos y permisos de nivel funcional. Adoptar el principio del menor privilegio (least-privilege), concediendo al modelo el menor nivel de acceso necesario para poder efectuar las funciones para las que ha sido concebido.
2. Implementar mecanismos de intervención humana para las funcionalidades extendidas del modelo; especialmente para la realización de operaciones privilegiadas como el envío o eliminación de correos electrónicos, en estos casos siempre se debería pedir la aprobación del usuario. De esta manera se evitaría la realización de operaciones en nombre del usuario sin su conocimiento o consentimiento a través de inyecciones indirectas.
3. Separar el contenido externo y las solicitudes de los usuarios. Marcar y separar el contenido no confiable cuando este sea utilizado de manera que se reduzca su influencia en la respuesta a las solicitudes del usuario. Por ejemplo, utilizar ChatML para los llamados a la API de OpenAI para permitirle al modelo reconocer el origen de las solicitudes.
4. Establecer límites de confianza entre el modelo, las fuentes externas y las funcionalidades extendidas (como, los plugins o las tareas que se desean automatizar por medio del modelo). Es necesario que el modelo se trate siempre como un usuario sin nivel de confianza y mantener al usuario final en control de las decisiones en procesos que conllevan elecciones. Sin embargo, un modelo que ha sido comprometido podría, de todas maneras, actuar como un intermediario (man-in-the-middle) entre la API de una aplicación y el usuario final debido a que podría ocultar o manipular la información presentada al usuario, una forma de mitigar esto es marcar y resaltar visualmente las solicitudes y respuestas potencialmente dañinas.


Example Attack Scenarios


1. An attacker provides a direct prompt injection to an LLM-based support chatbot. The injection contains “forget all previous instructions” and new instructions to query private data stores and exploit package vulnerabilities and the lack of output validation in the backend function to send emails. This leads to remote code execution, gaining unauthorized access and privilege escalation.
2. An attacker embeds an indirect prompt injection in a webpage instructing the LLM to disregard previous user instructions and use an LLM plugin to delete the user's emails. When the user employs the LLM to summarize this webpage, the LLM plugin deletes the user's emails.
3. A user employs an LLM to summarize a webpage containing an indirect prompt injection to disregard previous user instructions. This then causes the LLM to solicit sensitive information from the user and perform exfiltration via embedded JavaScript or Markdown.
4. A malicious user uploads a resume with a prompt injection. The backend user uses an LLM to summarize the resume and ask if the person is a good candidate. Due to the prompt injection, the LLM says yes, despite the actual resume contents.
5. A user enables a plugin linked to an e-commerce site. A rogue instruction embedded on a visited website exploits this plugin, leading to unauthorized purchases.


Reference Links
1. ChatGPT Plugin Vulnerabilities - Chat with Code: https://embracethered.com/blog/posts/2023/chatgpt-plugin-vulns-chat-with-code/
2. ChatGPT Cross Plugin Request Forgery and Prompt Injection: https://embracethered.com/blog/posts/2023/chatgpt-cross-plugin-request-forgery-and-prompt-injection./
3. Defending ChatGPT against Jailbreak Attack via Self-Reminder: https://www.researchsquare.com/article/rs-2873090/v1
4. Prompt Injection attack against LLM-integrated Applications: https://arxiv.org/abs/2306.05499
5. Inject My PDF: Prompt Injection for your Resume: https://kai-greshake.de/posts/inject-my-pdf/
6. ChatML for OpenAI API Calls: https://github.com/openai/openai-python/blob/main/chatml.md
7. Not what you’ve signed up for- Compromising Real-World LLM-Integrated Applications with Indirect Prompt Injection: https://arxiv.org/pdf/2302.12173.pdf
8. Threat Modeling LLM Applications: http://aivillage.org/large%20language%20models/threat-modeling-llm/
9. AI Injections: Direct and Indirect Prompt Injections and Their Implications: https://embracethered.com/blog/posts/2023/ai-injections-direct-and-indirect-prompt-injection-basics/




