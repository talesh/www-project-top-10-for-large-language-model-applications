## LLM01: Injection de prompt

### Description

Une vulnerabilité d'injection de prompt se produit lorsqu'un attaquant manipule un grand modèle de langage (LLM) à l'aide d'inputs spécialement conçus, ce qui conduit le LLM à exécuter à son insu les intentions de l'attaquant. Cela peut être fait directement à travers le "jailbreaking" du prompt de système ou indirectement par le biais d'inputs externes manipulés, ce qui peut potentiellement causer des problèmes de fuite de données, d'ingénierie sociale et autres.

* Une **Injection de prompt directe**, ou "jailbreaking", se produit lorsqu'un utilisateur malveillant rémplace ou révèle le prompt de système sous-jacent. Cela peut permettre aux attaquants d'exploiter les systèmes backend en interagissant avec des fonctions et des bases de données non sécurisées accessibles via le LLM.

* Une **Injection de prompt indirecte** se produit quand un LLM accepte des inputs de sources externes qui peuvent être contrôlées par un attaquant, comme des sites web ou des fichiers. L'attaquant peut incorporer une injection de prompt dans le contenu externe, en détournant le contexte de la conversation. L'output du LLM sera alors moins stable, permettant ainsi à l'attaquant de manipuler l'utilisateur ou d'autres systèmes auxquels le LLM a accès. De plus, les injections de prompt indirectes n'ont pas besoin d'être visibles/lisibles par l'humain, tant que le texte est interprété par le LLM.

Les résultats d'une attaque de prompt injection réussie peuvent considérablement varier – de la demande d'informations sensibles, à l'influence sur les processus de prise de décision majeurs sous couvert d'une opération normale.

Dans les attaques avancées, le LLM peut être manipulé pour imiter une personne malveillante ou interagir avec des plugins dans l'environnement de l'utilisateur. Cela peut entraîner la fuite de données sensibles, l'utilisation non autorisée de plugins ou l'ingénierie sociale. Dans de tels cas, le LLM compromis aide l'attaquant, dépassant les protections standard et laissant l'utilisateur inconscient de l'intrusion. Dans ces cas, le LLM compromis agit effectivement comme un agent pour l'attaquant, allant dans son sens sans déclencher les protections habituelles ou alerter l'utilisateur final de l'intrusion.

### Exemples communs de vulnérabilité

1. Un utilisateur malveillant crée une injection de prompt directe pour le LLM, qui lui ordonne d'ignorer les prompts système du créateur de l'application et d'exécuter un prompt qui renvoie des informations privées, dangereuses ou indésirables.

2. Un utilisateur utilise un LLM pour résumer une page web contenant une injection de prompt indirecte. Cela conduit le LLM à demander des informations sensibles auprès de l'utilisateur et à effectuer une exfiltration via JavaScript ou Markdown.

3. Un utilisateur malveillant télécharge un CV contenant une injection de prompt indirecte. Le document contient une injection de prompt avec des instructions pour faire en sorte que le LLM informe les utilisateurs que ce document est excellent, par exemple un très bon candidat pour un poste. Un utilisateur interne fait passer le document par le LLM pour le résumer. L'output du LLM indique que c'est un excellent document.

4. Un utilisateur active un plugin connecté à un site de commerce électronique. Une instruction malveillante intégrée sur un site visité exploite ce plugin, ce qui entraîne des achats non autorisés.

5. Une instruction et du contenu malveillant intégrés sur un site visité exploitent d'autres plugins pour escroquer les utilisateurs.


### Stratégies de prevention et d'atténuation

Les vulnerabilités de prompt injection sont possibles en raison de la nature des LLM, qui ne séparent pas les instructions et les données externes les unes des autres. Comme les LLM utilisent le langage naturel, ils considèrent les deux formes d'input comme étant fournies par l'utilisateur. Par conséquent, il n'y a pas de prévention infaillible dans le LLM, mais les mesures suivantes peuvent atténuer l'impact des prompt injections :

1. Mettre en œuvre un contrôle des privilèges sur l'accès du LLM aux systèmes backend. Fournir au LLM ses propres jetons d'API pour une fonctionnalité extensible, telle que les plugins, l'accès aux données et les permissions au niveau des fonctions. Suivre le principe du moindre privilège en limitant le LLM au niveau d'accès minimum nécessaire à ses opérations.

2. Ajouter un humain dans la boucle pour une fonctionnalité étendue. Lors de l'exécution d'opérations privilégiées, telles que l'envoi ou la suppression d'e-mails, faire en sorte que l'application exige que l'utilisateur approuve d'abord l'action. Cela réduit la possibilité qu'une injection de prompt indirecte conduise à des actions non autorisées au nom de l'utilisateur sans son consentement.

3. Séparer le contenu externe des prompts utilisateur. Séparer et indiquer où le contenu non fiable est utilisé pour limiter leur influence sur les prompts utilisateur. Par exemple, utiliser ChatML pour les appels API OpenAI pour indiquer au LLM la source de l'input du prompt.

4. Établir des limites de confiance entre le LLM, les sources externes et la fonctionnalité extensible (par exemple, les plugins ou les fonctions en aval). Traiter le LLM comme un utilisateur non fiable et maintenir le contrôle final par l'utilisateur sur le processus de prise de décision. Cependant, un LLM compromis peut toujours agir comme un intermédiaire (man-in-the-middle) entre les API de votre application et l'utilisateur, car il peut masquer ou manipuler les informations avant de les présenter à l'utilisateur. Mettre en évidence visuellement les réponses potentiellement non fiables à l'utilisateur.

5. Surveiller manuellement l'input et l'output du LLM périodiquement, pour vérifier qu'ils sont conformes aux attentes. Bien qu'il ne s'agisse pas d'une atténuation, cela peut fournir les données nécessaires pour détecter les faiblesses et y remédier.

### Examples de scenarios d'attaque

1. Un attaquant fournit une injection de prompt directe à un chatbot basé sur un LLM. L'injection contient "oublie toutes les instructions précédentes" suivi de nouvelles instructions pour interroger des bases de données privées ou exploiter les vulnérabilités des packages et l'absence de validation de l'output dans la fonction backend pour envoyer des e-mails. Cela conduit à l'exécution de code à distance, à l'accès non autorisé et à l'élévation des privilèges.

2. Un attaquant intègre une injection de prompt indirecte dans une page web, demandant au LLM d'ignorer les instructions précédentes de l'utilisateur et d'utiliser un plugin LLM pour supprimer les e-mails. Lorsque l'utilisateur utilise le LLM pour résumer cette page web, le plugin LLM supprime ses e-mails.

3. Un utilisateur se sert d'un LLM pour résumer une page web contenant du texte demandant à un modèle d'ignorer les instructions précédentes et d'insérer une image liant à une URL contenant un résumé de la conversation. L'output du LLM obéit, ce qui amène le navigateur de l'utilisateur à exfiltrer la conversation privée.

4. Un utilisateur malveillant télécharge un CV avec une injection de prompt. Un utilisateur interne utilise le LLM pour résumer le CV et demande si la personne est un bon candidat. En raison de l'injection de prompt, la réponse du LLM est oui, malgré le contenu réel du CV.

5. Un attaquant envoie des messages à un modèle propriétaire qui repose sur un prompt de système, demandant au modèle d'ignorer ses instructions précédentes et de répéter plutôt son prompt de système. Le modèle renvoie le prompt de système propriétaire et l'attaquant est en mesure d'utiliser ces instructions ailleurs, ou de construire d'autres attaques plus subtiles.

### References

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
