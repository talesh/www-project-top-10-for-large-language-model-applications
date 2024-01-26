## LLM06: Diffusione di Informazioni Sensibili

### Descrizione

Le applicazioni LLM possono rivelare informazioni sensibili, algoritmi proprietari o altri dettagli confidenziali attraverso i loro output. Ciò può portare ad accessi non autorizzati a dati sensibili, proprietà intellettuale, violazioni della privacy e altre violazioni di sicurezza. È importante che gli utenti delle applicazioni LLM siano consapevoli di come interagire in modo sicuro con gli LLM e identificare i rischi associati all'inserimento involontario di dati sensibili che possono successivamente essere restituiti dall'LLM come output altrove.

Per mitigare questo rischio, le applicazioni LLM dovrebbero eseguire un'adeguata sanificazione dei dati per impedire che i dati degli utenti entrino indiscriminatamente nei dati di addestramento del modello. I proprietari di applicazioni LLM dovrebbero inoltre esporre dei Termini di Utilizzo adeguati, chiaramente esposti per far sapere ai consumatori come vengono trattati i loro dati, ed una chiara opzione per negare il consenso ad includere i loro dati nell'addestramento del modello.

L'interazione tra il consumatore e l'applicazione LLM instaura un contesto di fiducia reciproca, nel quale non possiamo fidarci intrinsecamente né dell'input client->LLM né dell'output LLM->client. È importante notare che questa vulnerabilità presuppone che certi prerequisiti siano assicurati al di fuori del presente ambito di analisi, fra questi gli esercizi di modellazione delle minacce, la protezione delle infrastrutture ed una segregazione adeguata degli ambienti di esecuzioned. Aggiungere restrizioni all'interno del prompt del sistema riguardo ai tipi di dati che l'LLM dovrebbe restituire può fornire una certa mitigazione contro la rivelazione di informazioni sensibili, ma la natura imprevedibile degli LLM significa che tali restrizioni potrebbero non essere sempre rispettate e potrebbero essere eluse tramite iniezione di prompt o altri vettori.

### Esempi Comuni di Vulnerabilità

1. Filtraggio incompleto o improprio delle informazioni sensibili nelle risposte dell'LLM.
2. Sovradattamento o memorizzazione di dati sensibili nel processo di addestramento dell'LLM.
3. Divulgazione involontaria di informazioni confidenziali a causa di errata interpretazione da parte dell'LLM, mancanza di metodi di pulizia dei dati o errori.

### Strategie di Prevenzione e Mitigazione
1. Integrare adeguate tecniche di sanificazione e pulizia dei dati per impedire che i dati degli utenti entrino nei dati del modello di addestramento.
2. Implementare metodi robusti di validazione e sanificazione degli input per identificare ed escludere potenziali input malevoli per prevenire l'avvelenamento (poisoning) del modello.
3. Quando si arricchisce il modello con dati e se si effettua il [fine-tuning](https://github.com/OWASP/www-project-top-10-for-large-language-model-applications/wiki/Definitions) di un modello (ad esempio, dati inseriti nel modello prima o durante il rilascio):
	1. Qualunque informazione sensibile nei dati di fine-tuning ha il potenziale di essere rivelato ad un utente. Pertanto, si raccomanda di applicare la buona pratica di minimizzazione dei privilegi di accesso, e di non addestrare il modello su informazioni a cui un utente con privilegi elevati può accedere poichè potrebbero inavvertitamente essere mostrate a un utente con privilegi inferiori.
	2. L'accesso a fonti di dati esterne (orchestrazione dei dati in tempo reale) dovrebbe essere limitato.
	3. Applicare metodi rigorosi di controllo degli accessi alle fonti di dati esterne e un approccio rigoroso al mantenimento di una catena di fornitura sicura.

### Esempi di Scenari di Attacco

1. L'utente legittimo e ignaro A viene esposto a dati di altri utenti tramite l'LLM quando interagisce con l'applicazione LLM in modo non malevolo.
2. L'utente A indirizza un insieme ben congegnato di prompt per bypassare i filtri di input e la sanificazione dell'LLM per far sì che riveli informazioni sensibili (PII) su altri utenti dell'applicazione.
3. Dati personali come i "PII" vengono inseriti nel modello tramite i dati di addestramento a causa di negligenza da parte dell'utente stesso o dell'applicazione LLM. Questo caso potrebbe aumentare il rischio e la probabilità degli scenari 1 o 2 sopra descritti.

### Riferimenti e Link (Inglese)

1. [AI data leak crisis: New tool prevents company secrets from being fed to ChatGPT](https://www.foxbusiness.com/politics/ai-data-leak-crisis-prevent-company-secrets-chatgpt): **Fox Business**
2. [Lessons learned from ChatGPT’s Samsung leak](https://cybernews.com/security/chatgpt-samsung-leak-explained-lessons/): **Cybernews**
3. [Cohere - Terms Of Use](https://cohere.com/terms-of-use): **Cohere**
4. [A threat modeling example](https://aivillage.org/large%20language%20models/threat-modeling-llm/): **AI Village**
5. [OWASP AI Security and Privacy Guide](https://owasp.org/www-project-ai-security-and-privacy-guide/): **OWASP AI Security & Privacy Guide**
6. [Ensuring the Security of Large Language Models](https://www.experts-exchange.com/articles/38220/Ensuring-the-Security-of-Large-Language-Models-Strategies-and-Best-Practices.html): **Experts Exchange**
