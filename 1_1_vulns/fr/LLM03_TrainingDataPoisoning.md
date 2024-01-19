## LLM03: Empoisonnement des données d'entraînement

### Description

Le point de départ de toute approche de machine learning est les données d'entraînement, simplement du "texte brut". Pour être très performant (par exemple, avoir des connaissances linguistiques et du monde), ce texte doit couvrir un large éventail de domaines, de genres et de langues. Un grand modèle de langage utilise des réseaux neuronaux profonds pour générer des outputs basés sur des modèles appris à partir de données d'entraînement.

L'empoisonnement des données d'entraînement fait référence à la manipulation des données de pré-entraînement, ou des données utilisées dans les processus de fine-tuning ou d'embedding, pour introduire des vulnérabilités (qui ont toutes des vecteurs d'attaque uniques et parfois partagés), des portes dérobées ou des biais qui pourraient compromettre la sécurité, l'efficacité ou le comportement éthique du modèle. Les informations empoisonnées peuvent être présentées aux utilisateurs ou créer d'autres risques tels que la dégradation des performances, l'exploitation des logiciels downstream et les dommages à la réputation. Même si les utilisateurs se méfient de l'output problématique de l'IA, les risques restent, y compris des capacités du modèle réduites et des dommages potentiels à la réputation de la marque.

- La donnée de pré-entraînement fait référence au processus d'entraînement d'un modèle sur une tâche ou un ensemble de données.
- Le fine-tuning consiste à prendre un modèle existant qui a déjà été entraîné et à l'adapter à un sujet plus restreint ou à un objectif plus ciblé en l'entraînant sur un ensemble de données sélectionnées. Cet ensemble de données comprend généralement des exemples d'inputs et des outputs souhaitées correspondantes.
- L'embedding est le processus de conversion de données catégorielles (souvent du texte) en une représentation numérique qui peut être utilisée pour entraîner un modèle de langage. Il consiste à représenter des mots ou des phrases à partir des données textuelles sous forme de vecteurs dans un espace vectoriel continu. Les vecteurs sont généralement générés en alimentant les données textuelles dans un réseau neuronal qui a été entraîné sur un grand corpus de texte.

L'empoissonnement des données est une attaque d'intégrité car la manipulation des données d'entraînement a un impact sur la capacité du modèle à produire des prédictions correctes. Naturellement, les sources de données externes présentent un risque plus élevé, car les créateurs du modèle n'ont pas le contrôle des données ou un haut niveau de confiance dans le fait que le contenu ne contient pas de biais, d'informations falsifiées ou de contenu inapproprié.

### Exemples communs de vulnérabilités

1. Un acteur malveillant, ou une marque concurrente, crée intentionnellement des documents inexacts ou malveillants qui ciblent les données de pré-entraînement, de fine-tuning ou d'embedding d'un modèle. Considérez les vecteurs d'attaque [Split-View Data Poisoning](https://github.com/GangGreenTemperTatum/speaking/blob/main/dc604/hacker-summer-camp-23/Ads%20_%20Poisoning%20Web%20Training%20Datasets%20_%20Flow%20Diagram%20-%20Exploit%201%20Split-View%20Data%20Poisoning.jpeg) (empoisonnement par vue séparée) et [Frontrunning Poisoning](https://github.com/GangGreenTemperTatum/speaking/blob/main/dc604/hacker-summer-camp-23/Ads%20_%20Poisoning%20Web%20Training%20Datasets%20_%20Flow%20Diagram%20-%20Exploit%202%20Frontrunning%20Data%20Poisoning.jpeg) (empoisonnement par anticipation) comme des illustrations.
   1. Le modèle victime est entraîné en utilisant des informations falsifiées, qui se reflètent dans les outputs des prompts que l'IA générative renvoie à ses utilisateurs.
2. Un acteur malveillant arrive à effectuer une injection directe de contenu falsifié, biaisé ou nocif dans les processus d'entraînement d'un modèle. Ce contenu est ensuite reproduit en output par le modèle.
3. Un utilisateur non avisé injecte indirectement des données sensibles ou propriétaires dans les processus d'entraînement d'un modèle, qui sont ensuite reproduites dans les outputs du modèle.
4. Un modèle est entraîné à l'aide de données dont la source, l'origine ou le contenu ne sont pas vérifiées en aucune des phases d'entraînement, ce qui peut conduire à des résultats erronés si les données sont falsifiées ou incorrectes.
5. Un accès non restreint à l'infrastructure ou un sandboxing insuffisant peut permettre à un modèle d'ingérer des données d'entraînement non sécurisées, ce qui entraîne des outputs biaisés ou nocifs. Cet exemple peut également se présenter dans toutes les phases d'entraînement.
   1. Dans ce scenario, un input de l'utilisateur pour le modèle peut se refléter dans l'output d'un autre utilisateur (ce qui entraîne une violation), ou l'utilisateur d'un LLM peut recevoir des outputs du modèle qui sont inexacts, non pertinents ou nocifs en fonction du type de données ingérées, selon le cas d'utilisation du modèle (généralement décrit par une carte de modèle).

*Qu'il s'agisse d'un développeur, d'un client ou d'un consommateur général du LLM, il est important de comprendre les conséquences de la manière dont cette vulnérabilité pourrait refléter les risques au sein de votre application LLM, lorsqu'elle interagit avec un LLM non propriétaire, pour comprendre la légitimité des outputs du modèle en fonction de ses procédures d'entraînement. De même, les développeurs du LLM peuvent être exposés à des attaques directes et indirectes sur les données internes ou tierces utilisées pour le fine-tuning et l'embedding (le plus courant), ce qui crée un risque pour tous ses consommateurs*

### Stratégies de prévention et d'atténuation

1. Vérifier la chaîne d'approvisionnement des données d'entraînement, en particulier lorsqu'elles sont obtenues par l'extérieur, ainsi que le maintien des attestations via la méthodologie "ML-BOM" (Machine Learning Bill of Materials) et la vérification des cartes de modèle.
2. Vérifier la légitimité des sources de données ciblées et des données contenues obtenues pendant les phases de pré-entraînement, de fine-tuning et d'embedding.
3. Vérifier votre cas d'utilisation pour le LLM et l'application à laquelle il s'intègre. Créer différents modèles via des données d'entraînement séparées ou du fine-tuning pour différents cas d'utilisation afin de créer un output d'IA générative plus granulaire et précis selon le cas d'utilisation défini.
4. Garantir un sandboxing suffisant grâce à des contrôles réseau pour empêcher le modèle de scraper des sources de données non prévues qui pourraient entraver l'output du modèle de machine learning.
5. Adopter une vérification stricte ou des filtres d'input pour des données d'entraînement spécifiques ou des catégories de sources de données pour contrôler le volume de données falsifiées. L'assainissement des données, avec des techniques telles que la détection statistique des valeurs aberrantes et les méthodes de détection des anomalies, pour détecter et supprimer les données adverses qui pourraient potentiellement être injectées dans le processus de fine-tuning.
6. Élaborer des questions de contrôle détaillées sur la source et la propriété des ensembles de données pour s'assurer que le modèle n'a pas été empoisonné et adopter cette culture dans le cycle "MLSecOps". Consultez les ressources disponibles telles que [The Foundation Model Transparency Index](https://crfm.stanford.edu/fmti/) ou [Open LLM Leaderboard](https://huggingface.co/spaces/HuggingFaceH4/open_llm_leaderboard) par exemple.
7. Utiliser DVC ([Data Version Control](https://dvc.org/doc/user-guide/analytics)) pour identifier et suivre de près une partie d'un ensemble de données qui aurait pu être manipulée, supprimée ou ajoutée qui pourrait conduire à l'empoisonnement.
8 Utiliser une base de données vectorielle pour ajouter des informations fournies par l'utilisateur pour aider à protéger contre l'empoisonnement d'autres utilisateurs et même à corriger en production sans avoir à ré-entraîner un nouveau modèle.
9. Techniques de robustesse adversaire telles que l'apprentissage fédéré et contraintes pour minimiser l'effet des valeurs aberrantes ou l'entraînement adversaire pour être vigoureux contre les pires perturbations des données d'entraînement.
   1. Une approche "MLSecOps" pourrait consister à inclure la robustesse adversaire dans le cycle de vie de l'entraînement avec la technique d'empoisonnement automatique.
   2. Un exemple de cette approche est [Autopoison](https://github.com/azshue/AutoPoison), qui teste des attaques comme les *injections de contenu* ("tentative de promouvoir un nom de marque dans les réponses du modèle") et les *attaques de refus* ("faire toujours en sorte que le modèle refuse de répondre").
10. Tester et détecter, en mesurant la perte pendant la phase d'entraînement et en analysant les modèles entraînés pour détecter les signes d'une attaque d'empoisonnement en analysant le comportement du modèle sur des inputs de test spécifiques.
   1. Surveiller et alerter sur le nombre de réponses biaisées dépassant un seuil.
   2. Utiliser une boucle humaine pour examiner les réponses et l'audit.
   3. Mettre en œuvre des LLMs dédiés pour évaluer par rapport à des conséquences indésirables et entraîner d'autres LLM à l'aide de [techniques d'apprentissage par renforcement](https://wandb.ai/ayush-thakur/Intro-RLAIF/reports/An-Introduction-to-Training-LLMs-Using-Reinforcement-Learning-From-Human-Feedback-RLHF---VmlldzozMzYyNjcy).
   4. Effectuer des exercices de [red teaming](https://www.anthropic.com/index/red-teaming-language-models-to-reduce-harms-methods-scaling-behaviors-and-lessons-learned) basés sur LLM ou effectuer un scan des [vulnérabilités LLM](https://github.com/leondz/garak) pendant les phases de test du cycle de vie du LLM.

### Exemples de scenarios d'attaque

1. L'output des LLMs peut induire en erreur les utilisateurs de l'application, ce qui peut conduire à des opinions biaisés ou, pire, à des crimes de haine, etc.
2. Si les données d'entraînement ne sont pas correctement filtrées et assainies, un utilisateur malveillant de l'application peut essayer d'influencer et d'injecter des données toxiques dans le modèle pour qu'il s'adapte aux données biaisées et fausses.
3. Un acteur malveillant ou un concurrent crée intentionnellement des documents inexacts ou malveillants qui ciblent les données d'entraînement d'un modèle. Le modèle victime est entraîné en utilisant des informations falsifiées, qui se reflètent dans les outputs que l'IA générative renvoie à ses utilisateurs.
4. La vulnéralité d'injection de prompt (LLM01) peut être un vecteur d'attaque pour cette vulnérabilité si un assainissement et un filtrage insuffisants sont effectués lorsque les inputs des clients de l'application LLM sont utilisés pour entraîner le modèle. Par exemple, si des données malveillantes ou falsifiées sont entrées dans le modèle par un client dans le cadre d'une technique d'injection de prompt, cela pourrait être représenté dans les données du modèle.

### Références

1. [Stanford Research Paper:CS324](https://stanford-cs324.github.io/winter2022/lectures/data/): **Stanford Research**
2. [How data poisoning attacks corrupt machine learning models](https://www.csoonline.com/article/3613932/how-data-poisoning-attacks-corrupt-machine-learning-models.html): **CSO Online**
3. [MITRE ATLAS (framework) Tay Poisoning](https://atlas.mitre.org/studies/AML.CS0009/): **MITRE ATLAS**
4. [PoisonGPT: How we hid a lobotomized LLM on Hugging Face to spread fake news](https://blog.mithrilsecurity.io/poisongpt-how-we-hid-a-lobotomized-llm-on-hugging-face-to-spread-fake-news/): **Mithril Security**
5. [Inject My PDF: Prompt Injection for your Resume](https://kai-greshake.de/posts/inject-my-pdf/): **Kai Greshake**
6. [Backdoor Attacks on Language Models](https://towardsdatascience.com/backdoor-attacks-on-language-models-can-we-trust-our-models-weights-73108f9dcb1f): **Towards Data Science**
7. [Poisoning Language Models During Instruction](https://arxiv.org/abs/2305.00944): **Arxiv White Paper**
8. [FedMLSecurity:arXiv:2306.04959](https://arxiv.org/abs/2306.04959): **Arxiv White Paper**
9. [The poisoning of ChatGPT](https://softwarecrisis.dev/letters/the-poisoning-of-chatgpt/): **Software Crisis Blog**
10. [Poisoning Web-Scale Training Datasets - Nicholas Carlini | Stanford MLSys #75](https://www.youtube.com/watch?v=h9jf1ikcGyk): **YouTube Video**
11. [OWASP CycloneDX v1.5](https://cyclonedx.org/capabilities/mlbom/): **OWASP CycloneDX**
