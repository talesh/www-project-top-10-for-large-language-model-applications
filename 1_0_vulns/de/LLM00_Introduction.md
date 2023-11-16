OWASP Top 10 für LLM
Version 1.0 
Veröffentlicht: August 1, 2023




Das große Interesse an Large Language Models (LLMs, dt. Große Sprachmodelle), das Ende 2022 auf den Massenmarkt für vorprogrammierte Chatbots folgte, ist bemerkenswert. Unternehmen, die das Potenzial von LLMs nutzen wollen, integrieren sie rasch in ihre Abläufe und kundenorientierten Angebote. Die halsbrecherische Geschwindigkeit, mit der LLMs angenommen werden, hat jedoch die Einrichtung umfassender Sicherheitsprotokolle überholt, so dass viele Anwendungen anfällig für hochriskante Probleme sind.


Das Fehlen einer einheitlichen Ressource, die sich mit diesen Sicherheitsbedenken bei LLMs befasst, war offensichtlich. Entwickler, die mit den spezifischen Risiken im Zusammenhang mit LLMs nicht vertraut waren, fanden nur verstreute Ressourcen vor, und OWASPs Mission schien perfekt geeignet, um die sichere Einführung dieser Technologie voranzutreiben.
Für wen ist diese Liste?
Diese Liste richtet sich hauptsächlich an Entwickler, Datenwissenschaftler und Sicherheitsexperten, die mit Design und Erstellung von LLM-basierten Anwendungen und Plug-Ins beauftragt wurden. Unser Ziel ist es, praktische, umsetzbare und prägnante Empfehlungen zu schaffen, um diesen Berufsgruppen zu helfen, das komplexe und sich entwickelnde Gebiet der LLM-Sicherheit zu navigieren.


Die Erstellung der Liste
Die Erstellung der OWASP Top 10 für LLMs-Liste war eine Mammutaufgabe. Sie baut auf dem kollektiven Wissen eines internationalen Teams von annähernd 500 Experten auf, mit über 125 aktiv Beitragenden. Unsere Beitragenden haben die unterschiedlichsten Hintergründe, inklusive KI-Firmen, Sicherheitsfirmen, ISVs, Cloud Hyperscaler, Hardwarehersteller und der Wissenschaft.


Im Laufe eines Monats haben wir gebrainstormt und verschiedene, möglichiche Sicherheitsrisiken gesammelt, wobei die Teammitglieder 43 verschiedene Bedrohungen aufgeschrieben haben. In mehreren Abstimmrunden haben wir diese Vorschläge auf eine knappe Liste der zehn kritischten Schwachstellen reduziert. Jedes Sicherheitsrisiko wurde dann von speziellen Unterteams weiter untersucht und verfeinert und einer öffentlichen Prüfung unterzogen, um eine möglichst umfassende und umsetzbare endgültige Liste zu erhalten.


Jede dieser Schwachstellen wurde zusammen mit allgemeinen Beispielen, Tipps zur Vorbeugung, Angriffsszenarien und Referenzen von speziellen Unterteams weiter untersucht und verfeinert und einer öffentlichen Überprüfung unterzogen, um eine möglichst umfassende und umsetzbare endgültige Liste zu erhalten. 


Bezug zu anderen OWASP Top 10-Listen


Unsere Liste teilt zwar die DNA mit Schwachstellen die in anderen OWASP Top 10-Listen gefunden werden können, allerdings wiederholen wir nicht einfach Sicherheitslücken. Stattdessen gehen wir auf die einzigartigen Auswirkungen ein, die diese Schwachstellen in Anwendungen die LLMs haben können. 


Unser Ziel ist es, die Kluft zwischen den allgemeinen Grundsätzen der Anwendungssicherheit und den spezifischen Herausforderungen von LLMs zu überbrücken. Dies beinhaltet die Betrachtung, wie herkömmliche Schwachstellen innerhalb von LLMs andere Risiken darstellen oder auf neuartige Weise ausgenutzt werden können, sowie die Frage, wie herkömmliche Abhilfestrategien für Anwendungen, die LLMs nutzen, angepasst werden müssen. 


Die Zukunft


Diese erste Version der Liste wird nicht unsere letzte sein. Wir werden sie in regelmäßigen Abständen aktualisieren, um mit dem Stand der Technik Schritt zu halten. Wir werden mit der breiteren Gemeinschaft zusammenarbeiten, um den Stand der Technik voranzutreiben, und mehr Lehrmaterial für eine Reihe von Anwendungen erstellen. Außerdem streben wir eine Zusammenarbeit mit Normungsgremien und Regierungen zu KI-Sicherheitsthemen an. Wir laden jeden herzlich ein, unserer Gruppe beizutreten und einen Beitrag zu leisten.


Steve Wilson
Projektleiter, OWASP Top 10 für LLM-KI-AnwendungenTwitter/X: @virtualsteve






OWASP Top 10 für LLM


LLM01: Prompt-Injektion
Hierbei wird ein Large Language Model (LLM) durch geschickte Eingaben (Prompts) manipuliert, was zu unbeabsichtigten Aktionen des LLM führt. Direkte Injektionen überschreiben System-Prompts, während indirekte Injektionen Eingaben aus externen Quellen manipulieren.


LLM02: Unsichere Verarbeitung von Ausgaben
Diese Schwachstelle tritt auf, wenn eine LLM-Ausgabe ohne Prüfung akzeptiert wird, wodurch Backend-Systeme offengelegt werden. Ein Missbrauch kann zu schwerwiegenden Folgen wie XSS, CSRF, SSRF, Privilegienerweiterung oder Remotecodeausführung führen.


LLM03: Training Data Poisoning
This occurs when LLM training data is tampered, introducing vulnerabilities or biases that compromise security, effectiveness, or ethical behavior. Sources include Common Crawl, WebText, OpenWebText, & books.


LLM04: Model Denial of Service
Attackers cause resource-heavy operations on LLMs, leading to service degradation or high costs. The vulnerability is magnified due to the resource-intensive nature of LLMs and unpredictability of user inputs.


LLM05: Supply Chain Vulnerabilities
LLM application lifecycle can be compromised by vulnerable components or services, leading to security attacks. Using third-party datasets, pre- trained models, and plugins can add vulnerabilities.


LLM06: Sensitive Information Disclosure
LLMs may inadvertently reveal confidential data in its responses, leading to unauthorized data access, privacy violations, and security breaches. It’s crucial to implement data sanitization and strict user policies to mitigate this.


LLM07: Insecure Plugin Design
LLM plugins can have insecure inputs and insufficient access control. This lack of application control makes them easier to exploit and can result in consequences like remote code execution.


LLM08: Excessive Agency
LLM-based systems may undertake actions leading to unintended consequences. The issue arises from excessive functionality, permissions, or autonomy granted to the LLM-based systems.


LLM09: Overreliance
Systems or people overly dependent on LLMs without oversight may face misinformation, miscommunication, legal issues, and security vulnerabilities due to incorrect or inappropriate content generated by LLMs.


LLM10: Model Theft
This involves unauthorized access, copying, or exfiltration of proprietary LLM models. The impact includes economic losses, compromised competitive advantage, and potential access to sensitive information.




