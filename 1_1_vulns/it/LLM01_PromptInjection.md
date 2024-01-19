## LLM01: Iniezione di prompt

### Descrizione

La vulnerabilità di tipo iniezione di prompt (inglese: prompt injection) si verifica quando un attaccante manipola un modello linguistico di grandi dimensioni (LLM) attraverso input artificiosi, facendo in modo che l’LLM risponda inconsapevolmente alle intenzioni dell’attaccante. Questo può essere fatto direttamente attraverso il “jailbreaking” del prompt di sistema, oppure indirettamente, attraverso degli input esterni manipolati, portando potenzialmente all’esfiltrazione di dati, all’ingegneria sociale e altri problemi.

* **L'iniezione di prompt diretta**, conosciuta anche come "jailbreaking", si verifica quando un utente malintenzionato sovrascrive o rivela il prompt di sistema sottostante. Ciò può consentire agli attaccanti di sfruttare i sistemi backend interagendo con funzioni insicure e archivi di dati accessibili tramite l'LLM.

* **L'iniezione di prompt indiretta** si verifica quando un LLM accetta input da fonti esterne che possono essere controllate da un attaccante, come siti web o file. L'attaccante può incorporare un'iniezione di prompt nel contenuto esterno, dirottando il contesto della conversazione. Ciò causerebbe una minore stabilità dell'output dell'LLM, consentendo all'attaccante di manipolare l'utente o i sistemi aggiuntivi a cui l'LLM può accedere. Inoltre, le iniezioni di prompt indirette non hanno bisogno di essere visibili o leggibili da un umano, purché il testo venga analizzato dall'LLM.

I risultati di un attacco di iniezione di prompt di successo possono variare notevolmente — dalla richiesta di informazioni sensibili all'influenza su processi decisionali critici sotto mentite spoglie di normale funzionamento.

In attacchi avanzati, l'LLM può essere manipolato per impersonare un personaggio nocivo o interagire con plugin nell'ambiente dell'utente. Ciò può portare alla divulgazione di dati sensibili, all'uso non autorizzato di plugin o all'ingegneria sociale. In tali casi, l'LLM compromesso aiuta l'attaccante, aggirando i meccanismi di protezione standard e mantenendo l'utente all'oscuro dell'intrusione. In questi casi, l'LLM compromesso agisce in sostanza come un agente per l'attaccante, perseguendo i suoi obiettivi senza innescare i normali meccanismi di protezione o senza segnalare l'intrusione all'utente finale.

### Esempi comuni di vulnerabilità

1. Un utente malintenzionato crea un'iniezione di prompt diretta per l'LLM, ordinandogli di ignorare i prompt di sistema del creatore dell'applicazione e invece eseguire un prompt che restituisce informazioni private, pericolose o in generale indesiderabili.
2. Un utente usa un LLM per riassumere una pagina web contenente un'iniezione di prompt indiretta. Ciò fa sì che l'LLM richieda informazioni sensibili all'utente e le esfiltri tramite JavaScript o Markdown.
3. Un utente malintenzionato carica un curriculum contenente un'iniezione di prompt indiretta. Il documento contiene un'iniezione di prompt con istruzioni per far sì che l'LLM informi gli utenti che questo documento è eccellente, ad esempio un candidato eccellente per un ruolo lavorativo. Un utente interno analizza il documento tramite l'LLM per riassumerne il contenuto. In conseguenza all'iniezione di prompt, l'output dell'LLM indica che il documento è eccellente.
4. Un utente abilita un plugin collegato a un sito di e-commerce. Un'istruzione nociva incorporata in un sito web visitato sfrutta questo plugin, portando a acquisti non autorizzati.
5. Un'istruzione e del contenuto nocivi, incorporati in un sito web visitato, sfruttano altri plugin per truffare gli utenti.

### Strategie di prevenzione e mitigazione

Le iniezioni di prompt sono possibili a causa della natura degli LLM, che non separano le istruzioni dai dati esterni. Poiché gli LLM utilizzano il linguaggio naturale, considerano entrambe le forme di input come fornite dall'utente. Di conseguenza, non esiste una prevenzione infallibile all'interno dell'LLM, ma le seguenti misure possono mitigare l'impatto delle iniezioni di prompt:

1. Applicare il controllo dei privilegi sull'accesso dell'LLM ai sistemi backend. Fornire all'LLM i propri token API per funzionalità aggiuntive come plugin, accesso ai dati e autorizzazioni a livello di funzione. Seguire il principio del privilegio minimo limitando l'LLM al minimo livello di accesso necessario per le operazioni previste.
2. Aggiungere un controllo umano (human in the loop) per funzionalità estese. Quando si eseguono operazioni privilegiate, come l'invio o l'eliminazione di e-mail, far sì che l'applicazione richieda all'utente di approvare l'azione. Ciò riduce l'opportunità per le iniezioni di prompt indirette di portare ad azioni non autorizzate senza il consenso dell'utente.
3. Separare il contenuto esterno dai prompt dell'utente. Separare e indicare i limiti del contenuto non attendibile per limitarne l'influenza sui prompt dell'utente. Ad esempio, utilizzare ChatML per le chiamate API di OpenAI per indicare all'LLM la fonte dell'input del prompt.
4. Stabilire i confini di fiducia (trust boundary) tra l'LLM, le fonti esterne e le funzionalità aggiuntive (per esempio plugin o funzioni a valle). Tuttavia, un LLM compromesso può comunque agire da intermediario (man-in-the-middle) tra le API dell'applicazione e l'utente, nascondendo o manipolando le informazioni prima di presentarle all'utente. Evidenziare visivamente le risposte potenzialmente non attendibili per l'utente.
5. Monitorare manualmente l'input e l'output dell'LLM periodicamente, per verificare che sia conforme alle aspettative. Sebbene non sia una mitigazione, il monitoraggio può fornire i dati necessari per rilevare le debolezze e risolverle.

### Esempi di Scenario di Attacco

1. Un attaccante fornisce un'iniezione di prompt diretta a un chatbot di supporto basato su LLM. L'iniezione contiene "dimentica tutte le istruzioni precedenti", insieme a nuove istruzioni per interrogare archivi di dati privati e sfruttare le vulnerabilità dei pacchetti e la mancanza di validazione dell'output nella funzione backend per inviare e-mail. Ciò porta all'esecuzione di codice in remoto, all'accesso non autorizzato e all'escalation dei privilegi.

2. Un attaccante incorpora un'iniezione di prompt indiretta in una pagina web, istruendo l'LLM a ignorare le istruzioni precedenti dell'utente e utilizzare un plugin LLM per eliminare le e-mail dell'utente. Quando l'utente utilizza l'LLM per riassumere questa pagina web, il plugin LLM elimina le e-mail dell'utente.

3. Un utente usa un LLM per riassumere una pagina web il cui contenuto istruisce il modello a ignorare le precedenti istruzioni dell'utente e invece inserire un'immagine che rimanda a un URL che contiene un riassunto della conversazione. L'LLM obbedisce a queste istruzioni, causando l'esfiltrazione della conversazione privata da parte del browser dell'utente.
4. Un utente malintenzionato carica un curriculum con un'iniezione di prompt. L'utente interno utilizza un LLM per riassumere il curriculum e chiedere se la persona è un buon candidato. A causa dell'iniezione di prompt, la risposta dell'LLM è sì, independentemente dal contenuto effettivo del curriculum.
5. Un attaccante invia un messaggio a un modello proprietario che si basa su un prompt di sistema, chiedendo al modello di ignorare le sue istruzioni precedenti e invece ripetere il suo prompt di sistema. Il modello restituisce il prompt proprietario e l'attaccante è in grado di utilizzare queste istruzioni altrove, o di costruire ulteriori attacchi più sottili.

### Link e riferimenti (in inglese)

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