### LLM07: Progettazione Insicura dei Plugin

### Descrizione

I plugin LLM sono estensioni che, quando attivate, vengono chiamate automaticamente dal modello durante le interazioni con l'utente. La piattaforma di integrazione del modello li gestisce, e l'applicazione potrebbe non avere controllo sulla loro esecuzione, specialmente quando il modello è ospitato da una terza parte. Inoltre, i plugin tendono ad accettare input di testo libero dal modello senza alcuna validazione o controllo tipologico che gestisca le limitazioni sulla dimensione del contesto. Ciò consente a un potenziale attaccante di assemblare una richiesta malevola al plugin, che potrebbe risultare in una più ampia di comportamenti indesiderati, fino a raggiungere l'esecuzione di codice remoto.

Il danno causato da input malevoli dipende spesso dai controlli di accesso insufficienti e dal fallimento nel tracciare le autorizzazioni tra i diversi plugin. Un controllo di accesso inadeguato permette a un plugin di fidarsi ciecamente di altri plugin e di presumere che tali input siano stati forniti dall'utente finale. Tale controllo di accesso inadeguato può consentire agli input malevoli di avere conseguenze dannose che vanno dall'esfiltrazione di dati, all'esecuzione di codice remoto, e all'escalation di privilegi.

Questa sezione si concentra sulla creazione di plugin LLM piuttosto che sui plugin di terze parti, coperti dalle Vulnerabilità della Catena di Fornitura dell'LLM (Supply-Chain-Vulnerabilities).

### Esempi Comuni di Vulnerabilità

1. Un plugin accetta tutti i parametri in un unico campo di testo anziché in parametri di input distinti.
2. Un plugin accetta stringhe di configurazione invece di parametri, che possono sovrascrivere intere impostazioni di configurazione.
3. Un plugin accetta comandi SQL o istruzioni di programmazione invece di parametri ristretti.
4. L'autenticazione è eseguita senza un'autorizzazione esplicita per un particolare plugin.
5. Un plugin tratta tutti i contenuti LLM come se fossero creati interamente dall'utente eseguendo qualsiasi azione richiesta senza chiedere ulteriori autorizzazioni.

### Strategie di Prevenzione e Mitigazione

1. I Plugin dovrebbero accettare input che siano limitati e parametrizzati ove possibile e includere controlli sul tipo e la struttura dell'input. Dove non sia consentito, è opportuno inserire un secondo livello di chiamate fortemente tipizzate (controllo rigoroso sui tipi di parametro), analizzando le richieste e applicando validazione e sanificazione. Quando sia necessario accettare input libero per la semantica dell'applicazione, questo dovrebbe essere accuratamente ispezionato per assicurare che nessun metodo dannoso sia invocato.
2. Gli sviluppatori di plugin dovrebbero applicare le raccomandazioni OWASP per gli standard di verifica della sicurezza applicativa (ASVS - Application Security Verification Standard) per assicurare adeguate validazione e sanitizzazione dell'input.
3. I Plugin dovrebbero essere ispezionati e testati ampiamente per assicurare adeguata validazione. Utilizzare sistemi di Scansione Statica del Codice (SAST) e Test Dinamici ed Interattivi (DAST, IAST) all'interno delle catene (pipelines) di sviluppo.
4. I Plugin dovrebbero essere disegnati con l'intento di minimizzare l'impatto dello sfruttamento di qualunque parametro di input insicuro come da linee guida sui Controlli di Accesso nello standard ASVS OWASP. Ciò prevede un controllo accessi che assicuri la minimizzazione dei privilegi, e l'esposizione del minimo di funzionalità pur eseguendo la funzione desiderata. 
5. I Plugin dovrebbero utilizzare identità idonee in fase di autenticazione, come OAuth2, per consentire l'applicazione efficace dei controlli di autorizzazione ed accesso. Inoltre le chiavi API dovrebbero essere utilizzate per fornire un contesto in cui applicare specifiche decisioni autorizzative che riflettano il flusso del plugin come chiaramente distinto da quello interattivo dell'utente.
6. Richiedere un intervento umano per l'autorizzazione e la conferma di ogni azione intrapresa da plugin particolarmente critici.
7. I Plugin sono tipicamente delle REST APIs, per cui si raccomanda agli sviluppatori l'applicazione delle raccomandazioni di cui alla lista OWASP Top 10 API Security Risks - 2023 per ridurre la presenza di vulnerabilità generiche.

### Esempi di Scenari di Attacco

1. Un plugin accetta un URL base e istruisce l'LLM nel combinare l'URL con una query per ottenere previsioni meteorologiche che sono incluse nell'elaborazione della richiesta dell'utente. Un utente malintenzionato può creare una richiesta in modo tale che l'URL punti a un dominio che controlla, permettendogli di iniettare il proprio contenuto nel modello LLM tramite il proprio dominio.
2. Un plugin accetta un input in forma libera in un unico campo che non viene validato. Un attaccante fornisce payload attentamente elaborati per eseguire attività di ricognizione a partire dai messaggi di errore. Poi sfrutta vulnerabilità conosciute relative alle terze parti emerse per eseguire del codice effettuando un'esfiltrazione di dati o escalation di privilegi.
3. Un plugin utilizzato per recuperare delle inclusioni (embedding) da un archivio vettoriale accetta parametri di configurazione come stringa di connessione senza effettuarne la validazione. Ciò permette a un attaccante di sperimentare e accedere ad altri archivi vettoriali cambiando nomi o parametri host ed esfiltrare rappresentazioni vettoriali a cui non dovrebbe avere accesso.
4. Un plugin accetta clausole SQL "WHERE" come filtri avanzati, che vengono poi aggiunti alla query SQL. Ciò permette all'attaccante di eseguire un attacco SQL.
5. Un attaccante utilizza l'iniezione indiretta di prompt per sfruttare un plugin insicuro di gestione del codice privo di validazione dell'input e con controlli di accesso deboli per trasferire la proprietà del repository (archivio) e bloccare l'utente dai propri repository.

### Riferimenti e Link (Inglese)

1. [OpenAI ChatGPT Plugins](https://platform.openai.com/docs/plugins/introduction): **ChatGPT Developer’s Guide**
2. [OpenAI ChatGPT Plugins - Plugin Flow](https://platform.openai.com/docs/plugins/introduction/plugin-flow): **OpenAI Documentation**
3. [OpenAI ChatGPT Plugins - Authentication](https://platform.openai.com/docs/plugins/authentication/service-level): **OpenAI Documentation**
4. [OpenAI Semantic Search Plugin Sample](https://github.com/openai/chatgpt-retrieval-plugin): **OpenAI Github**
5. [Plugin Vulnerabilities: Visit a Website and Have Your Source Code Stolen](https://embracethered.com/blog/posts/2023/chatgpt-plugin-vulns-chat-with-code/): **Embrace The Red**
6. [ChatGPT Plugin Exploit Explained: From Prompt Injection to Accessing Private Data](https://embracethered.com/blog/posts/2023/chatgpt-cross-plugin-request-forgery-and-prompt-injection./): **Embrace The Red**
7. [OWASP ASVS - 5 Validation, Sanitization and Encoding](https://owasp-aasvs4.readthedocs.io/en/latest/V5.html#validation-sanitization-and-encoding): **OWASP AASVS**
8. [OWASP ASVS 4.1 General Access Control Design](https://owasp-aasvs4.readthedocs.io/en/latest/V4.1.html#general-access-control-design): **OWASP AASVS**
9. [OWASP Top 10 API Security Risks – 2023](https://owasp.org/API-Security/editions/2023/en/0x11-t10/): **OWASP**
