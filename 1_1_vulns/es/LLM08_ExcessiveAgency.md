## LLM08: Responsabilidad Excesiva

### Descripción

Un sistema basado en LLM a menudo se le otorga un grado de responsabilidad por su desarrollador: la capacidad de interactuar con otros sistemas y realizar acciones en respuesta a un mensaje. La decisión sobre qué funciones invocar también puede ser delegada a un 'agente' LLM para determinarla dinámicamente en función del mensaje de entrada o de la salida del LLM.

La Responsabilidad Excesiva es la vulnerabilidad que permite realizar acciones dañinas en respuesta a salidas inesperadas/ambiguas de un LLM (independientemente de lo que esté causando el mal funcionamiento del LLM; ya sea alucinación/confabulación, inyección de mensajes directa/indirecta, plugin malicioso, mensajes benignos mal diseñados, o simplemente un modelo de bajo rendimiento). La causa raíz de la Responsabilidad Excesiva es típicamente una o más de: funcionalidad excesiva, permisos excesivos o autonomía excesiva. Esto difiere del Manejo Inseguro de Salidas, que se preocupa por el escrutinio insuficiente de las salidas del LLM.

La Responsabilidad Excesiva puede llevar a un amplio rango de impactos en el espectro de confidencialidad, integridad y disponibilidad, y depende de con qué sistemas una aplicación basada en LLM pueda interactuar.

### Ejemplos Comunes de Vulnerabilidad

1. Funcionalidad Excesiva: Un agente LLM tiene acceso a plugins que incluyen funciones que no son necesarias para la operación prevista del sistema. Por ejemplo, un desarrollador necesita otorgar a un agente LLM la capacidad de leer documentos de un repositorio, pero el plugin de terceros que eligen usar también incluye la capacidad de modificar y eliminar documentos.
2. Funcionalidad Excesiva: Un plugin que se probó durante una fase de desarrollo y se abandonó en favor de una mejor alternativa, pero el plugin original permanece disponible para el agente LLM.
3. Funcionalidad Excesiva: Un plugin LLM con funcionalidad abierta no filtra adecuadamente las instrucciones de entrada para comandos que no son necesarios para la operación prevista de la aplicación. Por ejemplo, un plugin para ejecutar un comando de shell específico no impide adecuadamente la ejecución de otros comandos de shell.
4. Permisos Excesivos: Un plugin LLM tiene permisos en otros sistemas que no son necesarios para la operación prevista de la aplicación. Por ejemplo, un plugin destinado a leer datos se conecta a un servidor de base de datos utilizando una identidad que no solo tiene permisos de SELECT, sino también de UPDATE, INSERT y DELETE.
5. Permisos Excesivos: Un plugin LLM diseñado para realizar operaciones en nombre de un usuario accede a sistemas downstream con una identidad genérica de alto privilegio. Por ejemplo, un plugin para leer el almacén de documentos del usuario actual se conecta al repositorio de documentos con una cuenta privilegiada que tiene acceso a todos los archivos de los usuarios.
6. Autonomía Excesiva: Una aplicación o plugin basado en LLM no verifica ni aprueba de forma independiente acciones de alto impacto. Por ejemplo, un plugin que permite la eliminación de documentos de un usuario realiza eliminaciones sin ninguna confirmación del usuario.

### Prevention and Mitigation Strategies

Las siguientes acciones pueden prevenir la Responsabilidad Excesiva:

1. Limitar los plugins/herramientas a los que los agentes LLM pueden llamar solo a las funciones mínimas necesarias. Por ejemplo, si un sistema basado en LLM no requiere la capacidad de obtener el contenido de una URL, entonces tal plugin no debería ofrecerse al agente LLM.
2. Limitar las funciones que se implementan en los plugins/herramientas LLM al mínimo necesario. Por ejemplo, un plugin que accede al buzón de un usuario para resumir correos electrónicos solo puede requerir la capacidad de leer correos electrónicos, por lo que el plugin no debería contener otra funcionalidad como eliminar o enviar mensajes.
3. Evitar funciones abiertas donde sea posible (por ejemplo, ejecutar un comando de shell, obtener una URL, etc.) y usar plugins/herramientas con funcionalidad más granular. Por ejemplo, una aplicación basada en LLM puede necesitar escribir alguna salida en un archivo. Si esto se implementara usando un plugin para ejecutar una función de shell, entonces el alcance de acciones indeseables es muy grande (cualquier otro comando de shell podría ejecutarse). Una alternativa más segura sería construir un plugin de escritura de archivos que solo admitiera esa funcionalidad específica.
4. Limitar los permisos que se otorgan a los plugins/herramientas LLM en otros sistemas al mínimo necesario para limitar el alcance de acciones indeseables. Por ejemplo, un agente LLM que utiliza una base de datos de productos para hacer recomendaciones de compra a un cliente podría necesitar solo acceso de lectura a una tabla de 'productos'; no debería tener acceso a otras tablas, ni la capacidad de insertar, actualizar o eliminar registros. Esto debería hacerse cumplir aplicando los permisos de base de datos adecuados para la identidad que el plugin LLM utiliza para conectarse a la base de datos.
5. Rastrear la autorización del usuario y el alcance de seguridad para asegurar que las acciones realizadas en nombre de un usuario se ejecuten en sistemas downstream en el contexto de ese usuario específico y con los mínimos privilegios necesarios. Por ejemplo, un plugin de LLM que lee el repositorio de código de un usuario debería requerir que el usuario se autentique a través de OAuth y con el alcance mínimo requerido.
6. Utilizar control humano en el proceso para requerir la aprobación de un humano para todas las acciones antes de que se realicen. Esto puede implementarse en un sistema downstream (fuera del alcance de la aplicación LLM) o dentro del propio plugin/herramienta LLM. Por ejemplo, una aplicación basada en LLM que crea y publica contenido en redes sociales en nombre de un usuario debería incluir una rutina de aprobación del usuario dentro del plugin/herramienta/API que implementa la operación de 'publicación'.
7. Implementar autorización en sistemas downstream en lugar de depender de un LLM para decidir si una acción está permitida o no. Al implementar herramientas/plugins, hacer cumplir el principio de mediación completa para que todas las solicitudes hechas a sistemas downstream a través de los plugins/herramientas sean validadas contra políticas de seguridad.

Las siguientes opciones no evitarán la Responsabilidad Excesiva, pero pueden limitar el nivel de daño causado:

1. Registrar y monitorear la actividad de los plugins/herramientas LLM y sistemas downstream para identificar dónde se están realizando acciones indeseables, y responder en consecuencia.
2. Implementar limitación de tasa para reducir el número de acciones indeseables que pueden tener lugar en un período de tiempo determinado, aumentando la oportunidad de descubrir acciones indeseables a través del monitoreo antes de que pueda ocurrir un daño significativo.

### Ejemplos de Escenarios de Ataque

Una aplicación de asistente personal basada en LLM obtiene acceso al buzón de correo de un individuo a través de un plugin para resumir el contenido de los correos electrónicos entrantes. Para lograr esta funcionalidad, el plugin de correo electrónico requiere la capacidad de leer mensajes, sin embargo, el plugin elegido por el desarrollador del sistema también contiene funciones para enviar mensajes. El LLM es vulnerable a un ataque de inyección de mensaje indirecto, en el que un correo electrónico maliciosamente diseñado engaña al LLM para que ordene al plugin de correo electrónico llamar a la función de 'enviar mensaje' para enviar spam desde el buzón del usuario. Esto podría evitarse mediante:<br><br>
  (a) eliminando la funcionalidad excesiva utilizando un plugin que solo ofrezca capacidades de lectura de correo, <br>
  (b) eliminando permisos excesivos autenticándose en el servicio de correo electrónico del usuario a través de una sesión OAuth con un alcance de solo lectura, y/o <br>
  (c) eliminando la autonomía excesiva al requerir que el usuario revise manualmente y presione 'enviar' en cada correo redactado por el plugin LLM.
Alternativamente, el daño causado podría reducirse implementando limitación de tasa en la interfaz de envío de correos.

### Enlaces de Referencia

1. [Embrace the Red: Confused Deputy Problem](https://embracethered.com/blog/posts/2023/chatgpt-cross-plugin-request-forgery-and-prompt-injection./): **Embrace The Red**
2. [NeMo-Guardrails: Interface guidelines](https://github.com/NVIDIA/NeMo-Guardrails/blob/main/docs/security/guidelines.md): **NVIDIA Github**
3. [LangChain: Human-approval for tools](https://python.langchain.com/docs/modules/agents/tools/how_to/human_approval): **Langchain Documentation**
4. [Simon Willison: Dual LLM Pattern](https://simonwillison.net/2023/Apr/25/dual-llm-pattern/): **Simon Willison**
