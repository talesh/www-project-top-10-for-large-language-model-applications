## LLM05: Vulnerabilidades en la Cadena de Suministro

### Descripción

La cadena de suministro (supply-chain) en los LLM puede ser vulnerable, afectando la integridad de los datos de entrenamiento, los modelos de ML y las plataformas de despliegue. Estas vulnerabilidades pueden llevar a resultados sesgados, brechas de seguridad o incluso fallas completas del sistema. Tradicionalmente, las vulnerabilidades se centran en los componentes de software, pero el Aprendizaje Automático extiende esto con los modelos preentrenados y los datos de entrenamiento suministrados por terceros, susceptibles a ataques de manipulación y envenenamiento.

Finalmente, las extensiones de Plugins LLM pueden traer sus propias vulnerabilidades. Estas se describen en [LLM07 - Diseño Inseguro de Plugin](InsecurePluginDesign.md), que cubre la escritura de Plugins LLM y proporciona información útil para evaluar plugins de terceros.

### Ejemplos Comunes de Vulnerabilidad

1. Vulnerabilidades tradicionales en paquetes de terceros, incluyendo componentes obsoletos o en desuso.
2. Uso de un modelo preentrenado vulnerable para el fine-tuning.
3. Uso de datos de crowdsourcing envenenados para el entrenamiento.
4. Utilizar modelos obsoletos o en desuso que ya no se mantienen conduce a problemas de seguridad.
5. Términos y condiciones poco claros y políticas de privacidad de datos de los operadores del modelo llevan a que los datos sensibles de la aplicación se utilicen para el entrenamiento del modelo y la subsiguiente exposición de información sensible. Esto también puede aplicarse a riesgos derivados del uso de material con derechos de autor por parte del proveedor del modelo.

### Estrategias de Prevención y Mitigación

1. Evaluar cuidadosamente las fuentes de datos y proveedores, incluyendo los Términos y Condiciones y sus políticas de privacidad, utilizando solo proveedores de confianza. Asegurar que se disponga de seguridad adecuada y auditada de forma independiente y que las políticas del operador del modelo se alineen con sus políticas de protección de datos, es decir, que sus datos no se utilicen para entrenar sus modelos; de manera similar, buscar garantías y mitigaciones legales contra el uso de material con derechos de autor por parte de los mantenedores del modelo.
2. Utilizar solo plugins de reputación y asegurarse de que han sido probados para los requisitos de su aplicación. LLM-Insecure Plugin Design proporciona información sobre los aspectos de LLM del diseño inseguro de plugins que debe probar para mitigar riesgos al usar plugins de terceros.
3. Entender y aplicar las mitigaciones encontradas en el Top Diez de OWASP [A06:2021 – Componentes Vulnerables y Desactualizados](https://owasp.org/Top10/A06_2021-Vulnerable_and_Outdated_Components/). Esto incluye escaneo de vulnerabilidades, gestión y parcheo de componentes. Para entornos de desarrollo con acceso a datos sensibles, aplicar estos controles también en esos entornos.
4. Mantener un inventario actualizado de componentes usando un Bill of Materials de Software (SBOM) para asegurar que tenga un inventario actualizado, preciso y firmado, evitando la manipulación de paquetes desplegados. Los SBOMs pueden ser utilizados para detectar y alertar rápidamente sobre nuevas vulnerabilidades de día cero.
5. Al momento de escribir, los SBOMs no cubren modelos, sus artefactos y conjuntos de datos. Si su aplicación LLM utiliza su propio modelo, debe usar las mejores prácticas de MLOps y plataformas que ofrezcan repositorios de modelos seguros con seguimiento de datos, modelos y experimentos.
6. También debe usar la firma de modelos y código al utilizar modelos y proveedores externos.
7. La detección de anomalías y las pruebas de robustez adversaria en modelos y datos suministrados pueden ayudar a detectar manipulación y envenenamiento, como se discute en [Envenenamiento de Datos de Entrenamiento](https://github.com/OWASP/www-project-top-10-for-large-language-model-applications/blob/main/1_0_vulns/Training_Data_Poisoning.md); idealmente, esto debería ser parte de los pipelines de MLOps; sin embargo, estas son técnicas emergentes y pueden ser más fáciles de implementar como parte de ejercicios de equipo rojo.
8. Implementar un monitoreo suficiente para cubrir escaneo de vulnerabilidades de componentes y entornos, uso de plugins no autorizados y componentes desactualizados, incluyendo el modelo y sus artefactos.
9. Implementar una política de parcheo para mitigar componentes vulnerables o desactualizados. Asegurar que la aplicación dependa de una versión mantenida de APIs y del modelo subyacente.
10. Revisar y auditar regularmente la Seguridad y Acceso de los proveedores, asegurando que no haya cambios en su postura de seguridad o Términos y Condiciones.

### Ejemplos de Escenarios de Ataque

1. Un atacante explota una biblioteca de Python vulnerable para comprometer un sistema. Esto ocurrió en la primera brecha de datos de Open AI.
2. Un atacante proporciona un plugin LLM para buscar vuelos, generando enlaces falsos que conducen a estafar a los usuarios.
3. Un atacante explota el registro de paquetes PyPi para engañar a los desarrolladores de modelos a descargar un paquete comprometido y exfiltrar datos o escalar privilegios en un entorno de desarrollo de modelos. Este fue un ataque real.
4. Un atacante envenena un modelo preentrenado de acceso público especializado en análisis económico e investigación social para crear una puerta trasera que genera desinformación y noticias falsas. Lo despliegan en un mercado de modelos (por ejemplo, Hugging Face) para que las víctimas lo utilicen.
5. Un atacante envenena conjuntos de datos de acceso público para ayudar a crear una puerta trasera al ajustar modelos. La puerta trasera favorece sutilmente a ciertas empresas en diferentes mercados.
6. Un empleado comprometido de un proveedor (desarrollador externo, empresa de hosting, etc.) exfiltra datos, modelos o códigos robando propiedad intelectual.
7. Un operador LLM cambia sus Términos y Condiciones y Política de Privacidad para requerir una exclusión explícita del uso de datos de la aplicación para el entrenamiento del modelo, lo que lleva a la memorización de datos sensibles.

### Enlaces de Referencia

1. [ChatGPT Data Breach Confirmed as Security Firm Warns of Vulnerable Component Exploitation](https://www.securityweek.com/chatgpt-data-breach-confirmed-as-security-firm-warns-of-vulnerable-component-exploitation/): **Security Week**
2. [Plugin review process](https://platform.openai.com/docs/plugins/review): **OpenAI**
3. [Compromised PyTorch-nightly dependency chain](https://pytorch.org/blog/compromised-nightly-dependency/): **Pytorch**
4. [PoisonGPT: How we hid a lobotomized LLM on Hugging Face to spread fake news](https://blog.mithrilsecurity.io/poisongpt-how-we-hid-a-lobotomized-llm-on-hugging-face-to-spread-fake-news/): **Mithril Security**
5. [Army looking at the possibility of 'AI BOMs](https://defensescoop.com/2023/05/25/army-looking-at-the-possibility-of-ai-boms-bill-of-materials/): **Defense Scoop**
6. [Failure Modes in Machine Learning](https://learn.microsoft.com/en-us/security/engineering/failure-modes-in-machine-learning): **Microsoft**
7. [ML Supply Chain Compromise](https://atlas.mitre.org/techniques/AML.T0010/): **MITRE ATLAS**
8. [Transferability in Machine Learning: from Phenomena to Black-Box Attacks using Adversarial Samples](https://arxiv.org/pdf/1605.07277.pdf): **Arxiv White Paper**
9. [BadNets: Identifying Vulnerabilities in the Machine Learning Model Supply Chain](https://arxiv.org/abs/1708.06733): **Arxiv White Paper**
10. [VirusTotal Poisoning](https://atlas.mitre.org/studies/AML.CS0002): **MITRE ATLAS**
