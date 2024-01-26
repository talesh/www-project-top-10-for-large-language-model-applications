## LLM09: Sobredependencia

### Descripción

La Sobredependencia puede ocurrir cuando un LLM produce información errónea y la proporciona de manera autoritaria. Aunque los LLM pueden generar contenido creativo e informativo, también pueden crear contenido que es incorrecto, inapropiado o peligroso. Esto se conoce como alucinación o confabulación. Cuando las personas o sistemas confían en esta información sin supervisión o confirmación, puede resultar en una violación de seguridad, desinformación, mala comunicación, problemas legales y daño a la reputación.

El código fuente generado por LLM puede introducir vulnerabilidades de seguridad no detectadas. Esto representa un riesgo significativo para la seguridad operativa y de las aplicaciones. Estos riesgos muestran la importancia de procesos de revisión rigurosos, con:

* Supervisión
* Mecanismos de validación continua
* Avisos sobre el riesgo

### Ejemplos Comunes de Vulnerabilidad

1. LLM proporciona información inexacta como respuesta, indicándola de manera que implica alta autoridad. El sistema en general está diseñado sin los controles y equilibrios adecuados para manejar esto y la información engaña al usuario de una manera que conduce a daños.
2. LLM sugiere código inseguro o erroneo, lo que lleva a vulnerabilidades cuando se incorpora en un sistema de software sin la supervisión o verificación adecuada.

### Estrategias de Prevención y Mitigación

1. Monitorear y revisar regularmente las salidas del LLM. Utilizar técnicas de autoconsistencia o votación para filtrar textos inconsistentes. Comparar múltiples respuestas del modelo para una sola solicitud puede ayudar a juzgar mejor la calidad y consistencia de la salida.
2. Contrastar la salida del LLM con fuentes externas confiables. Esta capa adicional de validación puede ayudar a asegurar que la información proporcionada por el modelo sea precisa y confiable.
3. Mejorar el modelo con ajustes finos o incrustaciones para mejorar la calidad de la salida. Los modelos preentrenados genéricos tienen más probabilidades de producir información inexacta en comparación con modelos ajustados en un dominio particular. Técnicas como la ingeniería de indicaciones, el ajuste eficiente de parámetros (PET), el ajuste completo del modelo y las indicaciones de cadena de pensamiento pueden emplearse para este propósito.
4. Implementar mecanismos de validación automática que puedan verificar cruzadamente la salida generada contra hechos o datos conocidos. Esto puede proporcionar una capa adicional de seguridad y mitigar los riesgos asociados con las alucinaciones.
5. Desglosar tareas complejas en subtareas manejables y asignarlas a diferentes agentes. Esto no solo ayuda a gestionar la complejidad, sino que también reduce las posibilidades de alucinaciones, ya que cada agente puede ser responsable de una tarea más pequeña.
6. Comunicar claramente los riesgos y limitaciones asociados con el uso de LLM. Esto incluye la posibilidad de inexactitudes en la información y otros riesgos. Una comunicación efectiva de los riesgos puede preparar a los usuarios para problemas potenciales y ayudarles a tomar decisiones informadas.
7. Desarrollar API e interfaces de usuario que fomenten un uso responsable y seguro de los LLM. Esto puede incluir medidas como filtros de contenido, advertencias a los usuarios sobre posibles inexactitudes y etiquetado claro del contenido generado por IA.
8. Al usar LLM en entornos de desarrollo, establecer prácticas y directrices de codificación segura para prevenir la integración de posibles vulnerabilidades.

### Ejemplos de Escenarios de Ataque

1. Una organización de noticias utiliza intensivamente un LLM para generar artículos de noticias. Un actor malicioso explota esta sobredependencia, alimentando al LLM con información engañosa y causando la difusión de desinformación.
2. La IA plagia involuntariamente contenido, lo que lleva a problemas de derechos de autor y disminución de la confianza en la organización.
3. Un equipo de desarrollo de software utiliza un sistema LLM para acelerar el proceso de codificación. La sobredependencia en las sugerencias de la IA introduce vulnerabilidades de seguridad en la aplicación debido a configuraciones predeterminadas inseguras o recomendaciones inconsistentes con prácticas de codificación segura.
4. Una empresa de desarrollo de software utiliza un LLM para asistir a los desarrolladores. El LLM sugiere una biblioteca o paquete de código inexistente, y un desarrollador, confiando en la IA, integra involuntariamente un paquete malicioso en el software de la empresa. Esto resalta la importancia de contrastar las sugerencias del LLM, especialmente cuando se involucran códigos o bibliotecas de terceros.

### Enlaces de Referencia

1. [Understanding LLM Hallucinations](https://towardsdatascience.com/llm-hallucinations-ec831dcd7786): **Towards Data Science**
2. [How Should Companies Communicate the Risks of Large Language Models to Users?](https://techpolicy.press/how-should-companies-communicate-the-risks-of-large-language-models-to-users/): **Techpolicy**
3. [A news site used AI to write articles. It was a journalistic disaster](https://www.washingtonpost.com/media/2023/01/17/cnet-ai-articles-journalism-corrections/): **Washington Post**
4. [AI Hallucinations: Package Risk](https://vulcan.io/blog/ai-hallucinations-package-risk): **Vulcan.io**
5. [How to Reduce the Hallucinations from Large Language Models](https://thenewstack.io/how-to-reduce-the-hallucinations-from-large-language-models/): **The New Stack**
6. [Practical Steps to Reduce Hallucination](https://newsletter.victordibia.com/p/practical-steps-to-reduce-hallucination): **Victor Debia**
