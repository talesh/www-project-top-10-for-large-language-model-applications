## LLM10: Robo de Modelos

### Descripción

Esta entrada se refiere al acceso no autorizado y exfiltración de modelos de LLM por actores maliciosos o APTs. Esto surge cuando los modelos de LLM propietarios (siendo un activo valioso), son comprometidos, robados físicamente, copiados o se extraen pesos y parámetros para crear un equivalente funcional. El impacto del robo de modelos de LLM puede incluir pérdida económica y de reputación de marca, degradación de la ventaja competitiva, uso no autorizado del modelo o acceso no autorizado a información sensible contenida en el modelo.

El robo de LLM representa una preocupación de seguridad significativa a medida que los modelos de lenguaje se vuelven cada vez más poderosos y prevalentes. Las organizaciones e investigadores deben priorizar medidas de seguridad robustas para proteger sus modelos de LLM, asegurando la confidencialidad e integridad de su propiedad intelectual. Emplear un marco de seguridad integral que incluya controles de acceso, encriptación y monitoreo continuo es crucial para mitigar los riesgos asociados con el robo de modelos de LLM y proteger los intereses tanto de individuos como de organizaciones que dependen del LLM.

### Ejemplos Comunes de Vulnerabilidad

1. Un atacante explota una vulnerabilidad en la infraestructura de una empresa para obtener acceso no autorizado a su repositorio de modelos de LLM a través de una mala configuración en sus ajustes de seguridad de red o aplicación.
2. Un escenario de amenaza interna donde un empleado descontento (insider) filtra modelos o artefactos relacionados.
3. Un atacante consulta la API del modelo usando entradas cuidadosamente elaboradas y técnicas de inyección de prompts para recopilar un número suficiente de salidas para crear un clon del modelo (shadown model). 
4. Un ciberdelincuente es capaz de eludir las técnicas de filtrado de entradas del LLM para realizar un ataque de canal lateral y, en última instancia, recolectar información de pesos y arquitectura del modelo a un recurso controlado remotamente.
5. El vector de ataque para la extracción del modelo implica consultar el LLM con un gran número de prompts sobre un tema particular. Las salidas del LLM pueden luego usarse para ajustar otro modelo. Sin embargo, hay algunas cosas a tener en cuenta sobre este ataque:
   - El atacante debe generar un gran número de prompts dirigidos. Si los prompts no son lo suficientemente específicos, las salidas del LLM serán inútiles.
   - Las salidas de los LLM a veces pueden contener respuestas alucinadas, lo que significa que el atacante no podrá extraer el modelo completo ya que algunas de las salidas pueden ser sin sentido.
     - No es posible replicar un LLM al 100% a través de la extracción del modelo. Sin embargo, el atacante podrá replicar un modelo parcial.
6. El vector de ataque para la **_replicación funcional del modelo_** implica usar el modelo objetivo a través de prompts para generar datos de entrenamiento sintéticos (un enfoque llamado "autoinstrucción") para luego usarlo y ajustar otro modelo fundacional para producir un equivalente funcional. Esto elude las limitaciones de la extracción basada en consultas tradicionales utilizada en el Ejemplo 5 y se ha utilizado con éxito en investigaciones de uso de un LLM para entrenar otro LLM. Aunque en el contexto de esta investigación, la replicación del modelo no es un ataque. El enfoque podría ser utilizado por un atacante para replicar un modelo propietario con una API pública.

El uso de un modelo robado, como un "shadow model", puede usarse para montar ataques adversarios incluyendo acceso no autorizado a información sensible contenida en el modelo o experimentar sin ser detectados con entradas adversarias para seguir montando inyecciones de prompts avanzadas.

### Estrategias de Prevención y Mitigación

1. Implementar controles de acceso fuertes (por ejemplo, RBAC y regla de mínimo privilegio) y mecanismos de autenticación fuertes para limitar el acceso no autorizado a repositorios de modelos de LLM y entornos de entrenamiento.
   1. Esto es especialmente cierto para los tres primeros ejemplos comunes, que podrían causar esta vulnerabilidad debido a amenazas internas, mala configuración y/o controles de seguridad débiles sobre la infraestructura que alberga modelos de LLM, pesos y arquitectura en la que un actor malicioso podría infiltrarse desde dentro o fuera del entorno.
   2. El seguimiento de la gestión de proveedores, la verificación y las vulnerabilidades de dependencia son temas importantes para prevenir explotaciones de ataques a la cadena de suministro (supply-chain attacks).
2. Restringir el acceso del LLM a recursos de red, servicios internos y APIs.
   1. Esto es particularmente cierto para todos los ejemplos comunes, ya que cubre el riesgo y las amenazas internas, pero también controla finalmente a qué tiene acceso la aplicación LLM y, por lo tanto, podría ser un mecanismo o paso de prevención para evitar ataques por un canal lateral.
3. Utilizar un Inventario Centralizado (Registry ML Model) para modelos utilizados en producción. Tener un registro centralizado de modelos evita el acceso no autorizado a Modelos de ML mediante controles de acceso, autenticación y capacidades de monitoreo/registro que son buenas bases para la gobernanza. Tener un repositorio centralizado también es beneficioso para recopilar datos sobre algoritmos utilizados por los modelos con fines de cumplimiento, evaluaciones de riesgo y mitigación de riesgos.
4. Monitorear y auditar regularmente los registros de acceso y las actividades relacionadas con los repositorios de modelos de LLM para detectar y responder rápidamente a cualquier comportamiento sospechoso o no autorizado.
5. Automatizar la implementación de MLOps con gobernanza y flujos de trabajo de seguimiento y aprobación para reforzar los controles de acceso y despliegue dentro de la infraestructura.
6. Implementar controles y estrategias de mitigación para mitigar y/o reducir el riesgo de técnicas de inyección de prompts que causan ataques de canal lateral.
7. Limitar la tasa de llamadas a la API (Rate Limiting API) donde sea aplicable y/o filtros para reducir el riesgo de exfiltración de datos de las aplicaciones LLM, o implementar técnicas para detectar (por ejemplo, DLP) la actividad de extracción desde otros sistemas de monitoreo.
8. Implementar entrenamiento en robustez adversaria para ayudar a detectar consultas de extracción y reforzar las medidas de seguridad física.
9. Implementar un marco de marcado de agua en las etapas de incrustación y detección del ciclo de vida de los LLM.

### Ejemplos de Escenarios de Ataque

1. Un atacante explota una vulnerabilidad en la infraestructura de una empresa para obtener acceso no autorizado a su repositorio de modelos de LLM. El atacante procede a exfiltrar modelos valiosos de LLM y los utiliza para lanzar un servicio de procesamiento de lenguaje competidor o extraer información sensible, causando un daño financiero significativo a la empresa original.
2. Un empleado (insider) filtra modelos o artefactos relacionados. La exposición pública de este escenario aumenta el conocimiento de los atacantes para ataques adversarios de caja gris o, alternativamente, roba directamente la propiedad disponible.
3. Un atacante consulta la API con entradas cuidadosamente seleccionadas y recopila un número suficiente de salidas para crear un shadow model.
4. Una falla en el control de seguridad dentro de la cadena de suministro conduce a filtraciones de datos de información de modelo propietaria.
5. Un ciberdelicuente elude las técnicas de filtrado de entradas y preámbulos del LLM para realizar un ataque de canal lateral y recuperar información del modelo a un recurso controlado de forma remota bajo su control.

### Enlaces de Referencia

1. [Meta’s powerful AI language model has leaked online](https://www.theverge.com/2023/3/8/23629362/meta-ai-language-model-llama-leak-online-misuse): **The Verge**
2. [Runaway LLaMA | How Meta's LLaMA NLP model leaked](https://www.deeplearning.ai/the-batch/how-metas-llama-nlp-model-leaked/): **Deep Learning Blog**
3. [AML.TA0000 ML Model Access](https://atlas.mitre.org/tactics/AML.TA0000): **MITRE ATLAS**
4. [I Know What You See](https://arxiv.org/pdf/1803.05847.pdf): **Arxiv White Paper**
5. [D-DAE: Defense-Penetrating Model Extraction Attacks](https://www.computer.org/csdl/proceedings-article/sp/2023/933600a432/1He7YbsiH4c): **Computer.org**
6. [A Comprehensive Defense Framework Against Model Extraction Attacks](https://ieeexplore.ieee.org/document/10080996): **IEEE**
7. [Alpaca: A Strong, Replicable Instruction-Following Model](https://crfm.stanford.edu/2023/03/13/alpaca.html): **Stanford Center on Research for Foundation Models (CRFM)**
8. [How Watermarking Can Help Mitigate The Potential Risks Of LLMs?](https://www.kdnuggets.com/2023/03/watermarking-help-mitigate-potential-risks-llms.html): **KD Nuggets**
