## LLM05: Vulnerabilità della Supply-Chain

### Descrizione

La supply chain nei modelli di linguaggio di grandi dimensioni (LLM) può essere vulnerabile, influenzando l'integrità dei dati di addestramento, dei modelli di machine learning (ML) e delle piattaforme di erogazione. Queste vulnerabilità possono portare a risultati deviati, violazioni della sicurezza o addirittura a fallimenti completi del sistema. Tradizionalmente, le vulnerabilità si concentrano sui componenti software, ma il Machine Learning le estende anche ai modelli pre-addestrati e ai dati di addestramento forniti da terze parti, suscettibili di attacchi per manomissione ed avvelenamento.

Infine, le estensioni dei plugin LLM possono portare le loro vulnerabilità. Queste sono descritte in [LLM07 - Insecure Plugin Design](InsecurePluginDesign.md), che tratta della scrittura di plugin LLM e fornisce informazioni utili per valutare i plugin di terze parti.

### Esempi Comuni di Vulnerabilità

1. Vulnerabilità tradizionali derivanti dai pacchetti di terze parti, che includono componenti obsoleti o deprecati.
2. Utilizzo di un modello pre-addestrato vulnerabile per il fine-tuning.
3. Uso di dati di addestramento deviati provenienti da fonti aperte non verificate.
4. L'utilizzo di modelli obsoleti o fuori supporto che non sono più mantenuti porta a problemi di sicurezza.
5. Termini e Condizioni di Servizio (T&C) e politiche sulla privacy dei dati poco chiari da parte degli operatori dei modelli portano all'utilizzo di dati sensibili da un'applicazione per l'addestramento del modello, e alla successiva esposizione di informazioni sensibili. Questa situazione può anche generare rischi derivanti dall'uso di materiale protetto da proprietà intellettuale, da parte del fornitore del modello.

### Strategie di Prevenzione e Mitigazione

1. Valutare attentamente le fonti dei dati e i fornitori, inclusi i T&C e le loro politiche sulla privacy, ed impiegare solo fornitori affidabili. Assicurarsi della presenza di una pratica di sicurezza adeguata e verificata da terze parti e che le politiche degli operatori dei modelli siano allineate con le proprie politiche di protezione dei dati, ovvero che i propri dati non siano utilizzati per l'addestramento dei modelli senza consenso; non meno importante, predisporre le necessarie garanzie e mitigazioni legali contro l'eventuale uso di materiale protetto da copyright da parte dei manutentori dei modelli.
2. Utilizzare solo plugin affidabili, con una reputazione elevata e assicurarsi che siano stati testati per i requisiti della propria applicazione. Il paragrafo [LLM07 - Insecure Plugin Design](InsecurePluginDesign.md) fornisce informazioni sugli aspetti del design di plugin insicuri, che dovrebbero essere testati dal punto di vista del LLM, per mitigare i rischi derivanti dall'uso di plugin di terze parti.
3. Esaminare ed applicare le mitigazioni trovate nei Top Ten dell'OWASP [A06:2021 – Vulnerable and Outdated Components](https://owasp.org/Top10/A06_2021-Vulnerable_and_Outdated_Components/). Fra questi la scansione delle vulnerabilità e la gestione e l'aggiornamento dei componenti. Applicare questi controlli anche agli ambienti di sviluppo, che abbiano accesso a dati sensibili.
4. Mantenere un inventario aggiornato dei componenti definendo una Software Bill of Materials (SBoM o lista artefatti) per assicurarsi di avere un inventario aggiornato, accurato e certificato, prevenendo così la manomissione dei pacchetti in produzione. Le  liste artefatti software (SBoM) possono essere attivamente impiegate per rilevare e segnalare rapidamente nuove vulnerabilità gravi (Zero-Day).
5. Al momento della scrittura, le liste SBoM non coprono i modelli, i loro artefatti e i set di dati. Se la propria applicazione LLM utilizza un modello privato, è bene utilizzare le buone pratiche di "MLOps" e riferirsi a piattaforme che offrono repository di modelli sicuri con dati, modelli ed esperimenti identificabili e tracciabili.
6. Utilizzare modelli e codice certificati o firmati, quando si impiegano modelli e fornitori esterni.
7. L'esecuzione di test avversariali di robustezza e per la rilevazione di anomalie sui modelli e sui dati forniti possono aiutare a rilevare manomissioni e deviazioni (poisoning) come discusso in  [Training Data Poisoning](https://github.com/OWASP/www-project-top-10-for-large-language-model-applications/blob/main/1_0_vulns/Training_Data_Poisoning.md); idealmente, i test dovrebbero essere parte integrante della pipeline di MLOps; tuttavia, trattandosi di tecniche emergenti, potrebbero risultare più semplici da implementare come parte degli esercizi di red teaming.
8. Implementare un adeguato monitoraggio per assicurare la scansione delle vulnerabilità dei componenti e dell'ambiente che li ospita, l'uso di plugin non autorizzati e componenti obsoleti, inclusi il modello e i suoi artefatti.
9. Implementare una politica di aggiornamento (patching) per mitigare l'insorgenza di componenti vulnerabili o obsoleti. Assicurarsi che l'applicazione si basi su una versione costantemente manutenuta delle API e del modello sottostante.
10. Rivedere e controllare regolarmente la sicurezza ed i criteri di accesso dei fornitori, assicurandosi che non ci siano cambiamenti nella loro postura di sicurezza o nelle loro condizioni di servizio o T&C.

### Esempi di Scenari di Attacco

1. Un attaccante sfrutta una libreria Python vulnerabile per compromettere un sistema. Questo è effettivamente accaduto nel primo data breach di Open AI.
2. Un attaccante fornisce un plugin LLM per la ricerca di voli, generando link falsi che portano a truffare gli utenti.
3. Un attaccante sfrutta il registro dei pacchetti PyPi per ingannare gli sviluppatori di modelli a scaricare un pacchetto compromesso ed esfiltrare dati o scalare privilegi in un ambiente di sviluppo di modelli. Questo è stato un caso di attacco reale.
4. Un attaccante avvelena un modello pre-addestrato disponibile pubblicamente specializzato in analisi economica e ricerca sociale per creare una backdoor che genera disinformazione e fake news. Lo distribuisce su un marketplace di modelli (ad esempio, Hugging Face) per farlo utilizzare da vittime ignare.
5. Un attaccante avvelena set di dati pubblicamente disponibili per aiutare a creare una backdoor che acquisisce rilevanza quando si effettua il fine-tuning dei modelli. La backdoor favorisce in modo impercettibile alcune aziende in diversi mercati.
6. Un dipendente vittima di compromissione presso un fornitore (sviluppatore in outsourcing, azienda di hosting, ecc.) esfiltra dati, modelli o codice di fatto trafugando proprietà intellettuale.
7. Un operatore LLM cambia le sue condizioni d'uso (T&C) e la Politica sulla Privacy (DPA) richiedendo un opt-out esplicito relativamente all'uso dei dati dell'applicazione per l'addestramento del modello, portando alla memorizzazione inavvertita di dati sensibili.

### Riferimenti e Link (Inglese)

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
