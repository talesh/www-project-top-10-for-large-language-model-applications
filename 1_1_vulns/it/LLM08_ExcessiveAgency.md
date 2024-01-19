## LLM08: Eccessiva Autonomia
### Descrizione

Un sistema basato su LLM è spesso dotato di una certa autonomia dallo sviluppatore - la capacità di interfacciarsi con altri sistemi e intraprendere azioni in risposta a un prompt. La decisione su quali funzioni invocare può anche essere delegata a un 'agente' per determinarla dinamicamente in base al prompt di input o all'output dell'LLM.

L'Eccessiva Autonomia è la vulnerabilità che permette di eseguire azioni dannose in risposta a output inaspettati o ambigui da un LLM (indipendentemente dalla causa del malfunzionamento dell'LLM; sia essa allucinazione/confabulazione, iniezione di prompt diretta/indiretta, plugin maligno, prompt benigni mal progettati, o semplicemente un modello con scarse prestazioni). La causa radice dell'Eccessiva Autonomia è tipicamente una o più delle seguenti: funzionalità eccessive, permessi eccessivi o autonomia eccessiva. Questo si differenzia dalla Gestione Insicura dell'Output, che riguarda invece la mancanza di scrutinio sugli output generati dall'LLM.

L'Eccessiva Autonomia può portare a un'ampia gamma di impatti sull'intero spettro della riservatezza, integrità e disponibilità, e dipende dai sistemi con cui un'app basata su LLM può interagire.

### Esempi Comuni di Vulnerabilità

1. Funzionalità Eccessiva: Un agente LLM ha accesso a plugin che includono funzioni non necessarie per il funzionamento previsto del sistema. Ad esempio, uno sviluppatore deve concedere a un agente LLM la capacità di leggere documenti da un repository, ma il plugin di terze parti che sceglie di utilizzare include anche la capacità di modificare ed eliminare documenti.
2. Funzionalità Eccessiva: Un plugin potrebbe essere stato testato durante una fase di sviluppo e poi scartato in favore di un'alternativa migliore, ma il plugin originale rimane disponibile all'agente LLM.
3. Funzionalità Eccessiva: Un plugin LLM con funzionalità aperte non riesce a filtrare adeguatamente le istruzioni di input per comandi che vanno oltre quanto necessario per il funzionamento previsto dell'applicazione. Ad esempio, un plugin per eseguire un specifico comando shell non impedisce adeguatamente l'esecuzione di altri comandi shell.
4. Permessi Eccessivi: Un plugin LLM ha permessi su altri sistemi che non sono necessari per il funzionamento previsto dell'applicazione. Ad esempio, un plugin progettato per leggere dati si connette a un server di database utilizzando un'identità che non ha solo permessi SELECT, ma anche UPDATE, INSERT e DELETE.
5. Permessi Eccessivi: Un plugin LLM progettato per eseguire operazioni per conto di un utente accede a sistemi aggiuntivi rispetto a quelli previsti con un'identità generica che ha privilegi elevati. Ad esempio, un plugin per leggere l'archivio documenti dell'utente corrente si connette al repository dei documenti con un account privilegiato che ha accesso ai file di tutti gli utenti.
6. Autonomia Eccessiva: Un'applicazione o plugin basato su LLM non verifica e approva in modo indipendente azioni ad alto impatto. Ad esempio, un plugin che consente di eliminare i documenti di un utente esegue cancellazioni senza esplicita conferma da parte dell'utente.

### Strategie di Prevenzione e Mitigazione

Le seguenti azioni possono prevenire l'Eccessiva Autonomia:
1. Limitare i plugin/strumenti che gli agenti LLM possono utilizzare solo alle funzioni minime necessarie. Ad esempio, se un sistema basato su LLM non richiede la capacità di recuperare i contenuti di un URL, tale plugin non dovrebbe essere offerto all'agente LLM.
2. Limitare le funzioni implementate nei plugin/strumenti LLM al minimo necessario. Ad esempio, un plugin che accede alla casella di posta elettronica di un utente per riassumere le email potrebbe richiedere solo la capacità di leggere le email, quindi il plugin non dovrebbe contenere altre funzionalità come l'eliminazione o l'invio di messaggi.
3. Evitare, dove possibile, funzioni aperte (ad esempio, eseguire un comando shell, recuperare un URL, ecc.) e usare plugin/strumenti con funzionalità più granulari. Ad esempio, un'app basata su LLM potrebbe aver bisogno di scrivere alcuni output su un file. Se ciò venisse implementato utilizzando un plugin per eseguire una funzione shell, l'ambito per azioni indesiderate sarebbe molto ampio (potrebbe essere eseguito qualsiasi altro comando shell). Un'alternativa più sicura sarebbe costruire un plugin per la scrittura di file che potesse supportare solo quella specifica funzionalità.
4. Limitare i permessi concessi ai plugin/strumenti LLM verso altri sistemi al minimo necessario per limitare l'ambito di azioni indesiderate. Ad esempio, un agente LLM che utilizza un database di prodotti per fare raccomandazioni di acquisto a un cliente necessita solo dell'accesso in lettura alla tabella 'prodotti'; non dovrebbe avere accesso ad altre tabelle, né la capacità di inserire, aggiornare o eliminare record. Ciò dovrebbe essere assicurato applicando i permessi appropriati all'identità che il plugin LLM utilizza per connettersi al database.
5. Monitorare le autorizzazioni dell'utente ed il perimetro di sicurezza per garantire che le azioni intraprese per conto di un utilizzatore vengano eseguite sui sistemi a valle nel contesto previsto per quell'utente specifico e con i privilegi minimi necessari. Ad esempio, un plugin LLM che legge il repository di codice di un utente dovrebbe richiedere all'utente di autenticarsi tramite OAuth e con l'ambito minimo richiesto per lo scopo.
6. Utilizzare il controllo umano nel ciclo (human-in-the-loop) per richiedere l'approvazione da parte di un essere umano di tutte le azioni prima che queste vengano intraprese. Questo può essere implementato in un sistema "terzo" (al di fuori dell'ambito dell'applicazione LLM) o all'interno del plugin/strumento LLM stesso. Ad esempio, un'app basata su LLM che crea e pubblica contenuti sui social media per conto di un utente dovrebbe includere una routine che preveda l'esplicita approvazione di quest'ultimo all'interno nel plugin/strumento/API che effettua l'operazione di 'post'.
7. Implementare l'autorizzazione nei sistemi esterni piuttosto che lasciar decidere al modello LLM se un'azione sia consentita o meno. Quando si implementano strumenti/plugin, applicare il principio di mediazione assoluta dei flussi per assicurare che tutte le richieste fatte ai sistemi a valle tramite i plugin/strumenti vengano validate rispetto alle politiche di sicurezza.

Le seguenti opzioni non prevengono l'Eccessiva Autonomia, ma possono limitare il livello di danno causato:
1. Registrare e monitorare l'attività dei plugin/strumenti LLM e dei sistemi da essi contattati per identificare eventuali azioni indesiderate, e rispondere di conseguenza.
2. Implementare un limite di frequenza (rate-limiting) per ridurre il numero di azioni indesiderate che possono verificarsi in un dato periodo di tempo, aumentando l'opportunità di scoprire azioni indesiderate tramite il monitoraggio prima che possano verificarsi danni significativi.

### Example Attack Scenarios

An LLM-based personal assistant app is granted access to an individual’s mailbox via a plugin in order to summarise the content of incoming emails. To achieve this functionality, the email plugin requires the ability to read messages, however the plugin that the system developer has chosen to use also contains functions for sending messages. The LLM is vulnerable to an indirect prompt injection attack, whereby a maliciously-crafted incoming email tricks the LLM into commanding the email plugin to call the 'send message' function to send spam from the user's mailbox. This could be avoided by:<br><br>
  (a) eliminating excessive functionality by using a plugin that only offered mail-reading capabilities, <br>
  (b) eliminating excessive permissions by authenticating to the user's email service via an OAuth session with a read-only scope, and/or <br>
  (c) eliminating excessive autonomy by requiring the user to manually review and hit 'send' on every mail drafted by the LLM plugin.
Alternatively, the damage caused could be reduced by implementing rate limiting on the mail-sending interface.

### Esempi di Scenari di Attacco

Un'app di assistenza personale basata su LLM ottiene l'accesso alla casella di posta elettronica di un individuo tramite un plugin per riassumere il contenuto delle email in arrivo. Per ottenere questa funzionalità, il plugin di posta elettronica richiede la capacità di leggere i messaggi, tuttavia il plugin scelto dallo sviluppatore del sistema contiene anche funzioni per inviare messaggi. L'LLM è vulnerabile a un attacco di iniezione indiretta di prompt, in cui un'email malevolamente elaborata inganna l'LLM nel comandare il plugin di posta elettronica a chiamare la funzione 'invia messaggio' per inviare spam dalla casella di posta dell'utente. Questo potrebbe essere evitato:<br><br>
(a) eliminando la funzionalità eccessiva utilizzando un plugin che offre solo capacità di lettura della posta, <br>
(b) eliminando i permessi eccessivi autenticandosi al servizio email dell'utente tramite una sessione OAuth con uno ruolo di sola lettura, e/o <br>
(c) eliminando l'autonomia eccessiva chiedendo all'utente di rivedere manualmente e premere 'invia' su ogni email redatta dal plugin LLM.
In aggiunta, il danno causato potrebbe essere ridotto implementando un limite alla frequenza di invio sull'interfaccia che spedisce la posta elettronica.

### Riferimenti e Link (Inglese)

1. [Embrace the Red: Confused Deputy Problem](https://embracethered.com/blog/posts/2023/chatgpt-cross-plugin-request-forgery-and-prompt-injection./): **Embrace The Red**
2. [NeMo-Guardrails: Interface guidelines](https://github.com/NVIDIA/NeMo-Guardrails/blob/main/docs/security/guidelines.md): **NVIDIA Github**
3. [LangChain: Human-approval for tools](https://python.langchain.com/docs/modules/agents/tools/how_to/human_approval): **Langchain Documentation**
4. [Simon Willison: Dual LLM Pattern](https://simonwillison.net/2023/Apr/25/dual-llm-pattern/): **Simon Willison**
