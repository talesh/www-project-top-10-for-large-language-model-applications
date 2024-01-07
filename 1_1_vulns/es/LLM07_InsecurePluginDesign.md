## LLM07: Diseño Inseguro de Plugins

### Descripción

Los plugins de LLM son extensiones que, una vez habilitadas, son llamadas automáticamente por el modelo durante las interacciones con los usuarios. La plataforma de integración del modelo los impulsa, y la aplicación puede no tener control sobre la ejecución, especialmente cuando el modelo está alojado por otra parte. Además, es probable que los plugins implementen entradas de texto libre del modelo sin validación o verificación de tipo para lidiar con limitaciones de tamaño de contexto. Esto permite a un atacante potencial construir una solicitud maliciosa al plugin, lo que podría resultar en una amplia gama de comportamientos no deseados, incluida la ejecución remota de código.

El daño de las entradas maliciosas a menudo depende de controles de acceso insuficientes y del fracaso en rastrear la autorización a través de los plugins. El control de acceso inadecuado permite que un plugin confíe ciegamente en otros plugins y asuma que el usuario final proporcionó las entradas. Dicho control de acceso inadecuado puede permitir que las entradas maliciosas tengan consecuencias dañinas que van desde la exfiltración de datos, la ejecución remota de código y la escalada de privilegios.

Este elemento se enfoca en la creación de plugins de LLM en lugar de plugins de terceros, los cuales son cubiertos por las Vulnerabilidades en la Cadena de Suministro de LLM (LLM-Supply-Chain-Vulnerabilities cover).

### Ejemplos Comunes de Vulnerabilidad

1. Un plugin acepta todos los parámetros en un único campo de texto en lugar de parámetros de entrada distintos.
2. Un plugin acepta cadenas de configuración en lugar de parámetros que pueden sobrescribir la configuración completa.
3. Un plugin acepta sentencias SQL crudas o declaraciones de programación en lugar de parámetros.
4. La autenticación se realiza sin autorización explícita para un plugin en particular.
5. Un plugin trata todo el contenido de LLM como si fuera creado enteramente por el usuario y realiza cualquier acción solicitada sin requerir autorización adicional.

### Estrategias de Prevención y Mitigación

1. Los plugins deben cumplir una entrada parametrizada estricta siempre que sea posible e incluir verificaciones de tipo y rango en las entradas. Cuando esto no sea posible, se debe introducir una segunda capa de llamadas tipificadas, analizando las solicitudes y aplicando validación y saneamiento. Cuando se deba aceptar una entrada libre debido a la semántica de la aplicación, se debe inspeccionar cuidadosamente para asegurar que no se estén llamando métodos potencialmente dañinos.
2. Los desarrolladores de plugins deben aplicar las recomendaciones de OWASP en ASVS (Estándar de Verificación de Seguridad de Aplicaciones) para asegurar una validación y saneamiento adecuados de las entradas.
3. Los plugins deben ser inspeccionados y probados exhaustivamente para garantizar una validación adecuada. Utilizar análisis de Seguridad de Aplicaciones Estáticas (SAST) y pruebas de aplicaciones Dinámicas e Interactivas (DAST, IAST) en los pipelines de desarrollo.
4. Los plugins deben ser diseñados para minimizar el impacto de la explotación de cualquier parámetro de entrada inseguro siguiendo las Pautas de Control de Acceso de OWASP ASVS. Esto incluye el control de acceso de mínimo privilegio, exponiendo la menor funcionalidad posible mientras aún se realiza su función deseada.
5. Los plugins deben usar identidades de autenticación apropiadas, como OAuth2, para aplicar autorización y control de acceso efectivos. Además, las claves de API deben usarse para proporcionar contexto para decisiones de autorización personalizadas que reflejen la ruta del plugin en lugar del usuario interactivo por defecto.
6. Requerir autorización y confirmación manual del usuario para cualquier acción realizada por plugins sensibles.
7. Los plugins son, típicamente, APIs REST, por lo que los desarrolladores deben aplicar las recomendaciones encontradas en OWASP Top 10 Riesgos de Seguridad de API – 2023 para minimizar vulnerabilidades genéricas.

### Ejemplos de Escenarios de Ataque

1. Un plugin acepta una URL base e instruye al LLM para combinar la URL con una consulta para obtener pronósticos del tiempo que se incluyen al manejar la solicitud del usuario. Un usuario malicioso puede crear una solicitud de tal manera que la URL apunte a un dominio que controlan, lo que les permite inyectar su propio contenido en el sistema LLM a través de su dominio.
2. Un plugin acepta una entrada de formulario libre en un único campo que no valida. Un atacante suministra cargas útiles cuidadosamente elaboradas para realizar reconocimiento a partir de mensajes de error. Luego explota vulnerabilidades conocidas de terceros para ejecutar código y realizar exfiltración de datos o escalada de privilegios.
3. Un plugin utilizado para recuperar incrustaciones de una tienda de vectores acepta parámetros de configuración como una cadena de conexión sin ninguna validación. Esto permite a un atacante experimentar y acceder a otras tiendas de vectores cambiando nombres o parámetros de host y exfiltrar incrustaciones a las que no deberían tener acceso.
4. Un plugin acepta cláusulas WHERE de SQL como filtros avanzados, que luego se añaden al filtrado de SQL. Esto permite a un atacante realizar un ataque de SQL.
5. Un atacante utiliza la inyección indirecta de mensajes para explotar un plugin inseguro de gestión de código sin validación de entrada y control de acceso débil para transferir la propiedad del repositorio y bloquear al usuario de sus repositorios.

### Enlaces de Referencia

1. [OpenAI ChatGPT Plugins](https://platform.openai.com/docs/plugins/introduction): **ChatGPT Developer’s Guide**
2. [OpenAI ChatGPT Plugins - Plugin Flow](https://platform.openai.com/docs/plugins/introduction/plugin-flow): **OpenAI Documentation**
3. [OpenAI ChatGPT Plugins - Authentication](https://platform.openai.com/docs/plugins/authentication/service-level): **OpenAI Documentation**
4. [OpenAI Semantic Search Plugin Sample](https://github.com/openai/chatgpt-retrieval-plugin): **OpenAI Github**
5. [Plugin Vulnerabilities: Visit a Website and Have Your Source Code Stolen](https://embracethered.com/blog/posts/2023/chatgpt-plugin-vulns-chat-with-code/): **Embrace The Red**
6. [ChatGPT Plugin Exploit Explained: From Prompt Injection to Accessing Private Data](https://embracethered.com/blog/posts/2023/chatgpt-cross-plugin-request-forgery-and-prompt-injection./): **Embrace The Red**
7. [OWASP ASVS - 5 Validation, Sanitization and Encoding](https://owasp-aasvs4.readthedocs.io/en/latest/V5.html#validation-sanitization-and-encoding): **OWASP AASVS**
8. [OWASP ASVS 4.1 General Access Control Design](https://owasp-aasvs4.readthedocs.io/en/latest/V4.1.html#general-access-control-design): **OWASP AASVS**
9. [OWASP Top 10 API Security Risks – 2023](https://owasp.org/API-Security/editions/2023/en/0x11-t10/): **OWASP**
