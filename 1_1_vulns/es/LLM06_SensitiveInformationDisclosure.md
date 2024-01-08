## LLM06: Divulgación de Información Sensible

### Descripción

Las aplicaciones LLM tienen el potencial de revelar información sensible, algoritmos propios o detalles confidenciales a través de su salida. Esto puede resultar en acceso no autorizado a datos sensibles, propiedad intelectual, violaciones de privacidad y otras brechas de seguridad. Es importante que los consumidores de aplicaciones LLM estén conscientes de cómo interactuar de manera segura con los LLM y reconozcan los riesgos asociados con la introducción involuntaria de datos sensibles que posteriormente pueden ser devueltos por el LLM en la salida en otro lugar.

Para mitigar este riesgo, las aplicaciones LLM deben realizar una adecuada sanitización de datos para evitar que los datos del usuario entren en los datos del modelo de entrenamiento. Los propietarios de aplicaciones LLM también deben tener políticas adecuadas de Términos de Uso disponibles para hacer conscientes a los consumidores de cómo se procesan sus datos y la capacidad de optar por no incluir sus datos en el modelo de entrenamiento.

La interacción entre el consumidor y la aplicación LLM forma un límite de confianza bidireccional, donde no podemos confiar inherentemente en la entrada del cliente al LLM o en la salida del LLM al cliente. Es importante tener en cuenta que esta vulnerabilidad asume que ciertos requisitos previos están fuera del alcance, como ejercicios de modelado de amenazas, aseguramiento de la infraestructura y sandboxing adecuado. Agregar restricciones dentro del sistema de prompts sobre los tipos de datos que el LLM debería devolver puede proporcionar cierta mitigación contra la divulgación de información sensible, pero la naturaleza impredecible de los LLM significa que tales restricciones no siempre serán respetadas y podrían ser eludidas a través de la inyección de prompts u otros vectores.

### Ejemplos Comunes de Vulnerabilidad

1. Filtrado incompleto o inadecuado de información sensible en las respuestas del LLM.
2. Sobreajuste o memorización de datos sensibles en el proceso de entrenamiento del LLM.
3. Divulgación no intencionada de información confidencial debido a malinterpretaciones del LLM, falta de métodos de depuración de datos o errores.

### Estrategias de Prevención y Mitigación

1. Integrar técnicas adecuadas de sanitización y limpieza de datos para evitar que los datos del usuario entren en los datos del modelo de entrenamiento.
2. Implementar métodos robustos de validación y sanitización de entradas para identificar y filtrar posibles entradas maliciosas y prevenir la contaminación del modelo.
3. Al enriquecer el modelo con datos y si se realiza un [fine-tunning](https://github.com/OWASP/www-project-top-10-for-large-language-model-applications/wiki/Definitions) del modelo: (es decir, datos alimentados al modelo antes o durante la implementación)
   1. Cualquier cosa que se considere sensible en los datos de ajuste fino tiene el potencial de ser revelada a un usuario. Por lo tanto, aplicar la regla de mínimo privilegio y no entrenar el modelo con información a la que el usuario de mayor privilegio pueda acceder y que pueda ser mostrada a un usuario de menor privilegio.
   2. El acceso a fuentes de datos externas (orquestación de datos en tiempo de ejecución) debe ser limitado.
   3. Aplicar métodos estrictos de control de acceso a fuentes de datos externas y un enfoque riguroso para mantener una cadena de suministro (supply chain) segura.


### Ejemplos de Escenarios de Ataque

1. El usuario legítimo e inadvertido A queda expuesto a ciertos datos de otros usuarios a través del LLM al interactuar con la aplicación LLM de manera no maliciosa.
2. El usuario A dirige un conjunto bien elaborado de prompts para eludir los filtros de entrada y la sanitización del LLM, lo que hace que revele información sensible (PII) sobre otros usuarios de la aplicación.
3. Datos personales, como PII, se filtran en el modelo a través de los datos de entrenamiento debido a negligencia del propio usuario o de la aplicación LLM. Este caso podría aumentar el riesgo y la probabilidad de los escenarios 1 o 2 mencionados anteriormente.

### Enlaces de Referencia

1. [AI data leak crisis: New tool prevents company secrets from being fed to ChatGPT](https://www.foxbusiness.com/politics/ai-data-leak-crisis-prevent-company-secrets-chatgpt): **Fox Business**
2. [Lessons learned from ChatGPT’s Samsung leak](https://cybernews.com/security/chatgpt-samsung-leak-explained-lessons/): **Cybernews**
3. [Cohere - Terms Of Use](https://cohere.com/terms-of-use): **Cohere**
4. [A threat modeling example](https://aivillage.org/large%20language%20models/threat-modeling-llm/): **AI Village**
5. [OWASP AI Security and Privacy Guide](https://owasp.org/www-project-ai-security-and-privacy-guide/): **OWASP AI Security & Privacy Guide**
6. [Ensuring the Security of Large Language Models](https://www.experts-exchange.com/articles/38220/Ensuring-the-Security-of-Large-Language-Models-Strategies-and-Best-Practices.html): **Experts Exchange**
