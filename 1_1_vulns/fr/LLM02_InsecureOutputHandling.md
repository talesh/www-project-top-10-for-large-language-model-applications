## LLM02: Gestion non sécurisée de l'output


### Description

La gestion non sécurisée de l'output fait spécifiquement référence à des lacunes lors de la validation, l'assainissement et la gestion des outputs générés par un grand modèle de langage, avant qu'ils ne soient transmis vers d'autres composants et systèmes. Étant donné que le contenu généré par un LLM peut être contrôlé par un prompt d'input, ce comportement est comparable à offrir aux utilisateurs un accès indirect à des fonctionnalités supplémentaires.

La gestion non sécurisée de l'output diffère de la Confiance Excessive (LLM09) en ce qu'elle traite des outputs générés par les LLMs avant qu'ils ne soient transmis en aval, alors que la Confiance Excessive se concentre sur des préoccupations plus générales concernant la dépendance excessive à l'exactitude et à la pertinence des outputs des LLMs.

L'exploitation réussie d'une vulnérabilité de gestion non sécurisée des outputs peut entraîner des XSS et des CSRF dans les navigateurs web ainsi que des SSRF, des escalades de privilèges ou des exécutions de code à distance sur les systèmes de backend.

Les conditions suivantes peuvent augmenter l'impact de cette vulnérabilité :
* L'application accorde au LLM des privilèges supérieurs à ceux prévus pour les utilisateurs finaux, permettant une escalade de privilèges ou une exécution de code à distance.
* L'application est vulnérable aux attaques par injection de prompt indirecte, qui pourraient permettre à un attaquant d'obtenir un accès privilégié à l'environnement d'un utilisateur cible.
* Les plugins tiers ne valident pas correctement les entrées.


### Exemples communs de vulnérabilité

1. L'output du LLM est inséré directement dans un shell de système ou une fonction similaire comme exec ou eval, entraînant une exécution de code à distance.
2. Du JavaScript ou Markdown est généré par le LLM et envoyé à un utilisateur. Le code est ensuite interprété par le navigateur, produisant un XSS.

### Stratégies de prévention et d'atténuation

1. Considérer le modèle comme tout autre utilisateur, adopter une approche de confiance zéro et appliquer une validation correcte des inputs sur les réponses provenant du LLM vers les fonctions backend.
2. Suivre les directives OWASP ASVS (Application Security Verification Standard) pour garantir une validation et un assainissement efficace de l'input.
3. Encoder l'output du modèle avant de le passer aux utilisateurs afin de réduire l'exécution de code indésirable par JavaScript ou Markdown. OWASP ASVS fournit des directives détaillées sur l'encodage de l'output.

### Exemples de scenarios d'attaque

1. Une application utilise un plugin LLM pour générer des réponses pour une fonctionnalité de chatbot. Le plugin offre également un certain nombre de fonctions administratives accessibles à un autre LLM privilégié. Le LLM généraliste transmet directement sa réponse au plugin, sans validation appropriée de l'output, ce qui cause l'arrêt du plugin pour maintenance.

2. Un utilisateur emploie un outil de résumé de sites web basé sur un LLM pour générer un sommaire concis d'un article. Le site web comprend une injection de prompt qui ordonne au LLM de capturer du contenu sensible à partir du site web ou de la conversation de l'utilisateur. Une fois les informations sensibles obtenues, le LLM peut encoder les données et les envoyer vers un serveur contrôlé par un attaquant, sans aucune validation ou filtrage de l'output.

3. Un LLM permet aux utilisateurs de créer des requêtes SQL pour une base de données backend via une fonctionnalité de chat. Un utilisateur demande de supprimer toutes les tables de la base de données. Si la requête créée par le LLM n'est pas examinée attentivement, alors toutes les tables de la base de données seront supprimées.

4. Une application web utilise un LLM pour générer du contenu à partir de prompts textuels d'utilisateurs, sans assainissement de l'output. Un attaquant peut soumettre un prompt conçu pour que le LLM renvoie une charge utile JavaScript non assainie, entraînant un XSS lorsqu'elle est executée sur le navigateur d'une victime. La validation insuffisante des prompts a permis cette attaque.

### Références

1. [Arbitrary Code Execution](https://security.snyk.io/vuln/SNYK-PYTHON-LANGCHAIN-5411357): **Snyk Security Blog**
2. [ChatGPT Plugin Exploit Explained: From Prompt Injection to Accessing Private Data](https://embracethered.com/blog/posts/2023/chatgpt-cross-plugin-request-forgery-and-prompt-injection./): **Embrace The Red**
3. [New prompt injection attack on ChatGPT web version. Markdown images can steal your chat data.](https://systemweakness.com/new-prompt-injection-attack-on-chatgpt-web-version-ef717492c5c2?gi=8daec85e2116): **System Weakness**
4. [Don’t blindly trust LLM responses. Threats to chatbots](https://embracethered.com/blog/posts/2023/ai-injections-threats-context-matters/): **Embrace The Red**
5. [Threat Modeling LLM Applications](https://aivillage.org/large%20language%20models/threat-modeling-llm/): **AI Village**
6. [OWASP ASVS - 5 Validation, Sanitization and Encoding](https://owasp-aasvs4.readthedocs.io/en/latest/V5.html#validation-sanitization-and-encoding): **OWASP AASVS**
