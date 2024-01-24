### LLM04: Denial of Service del Modello

## Descrizione

Un attaccante interagisce con un LLM in un modo che porta al consumo di una quantità eccezionalmente alta di risorse, risultando in un declino della qualità del servizio sia per sè che per altri utenti, oltre a generare potenziali incrementi dei costi per risorse computazionali. Un altro elemento emergente critico per la sicurezza è la possibilità che un attaccante interferisca o manipoli la "finestra di contesto" di un LLM. Questo problema sta diventando sempre più critico a causa dell'uso crescente degli LLM in varie applicazioni, del loro intensivo utilizzo di risorse, dell'imprevedibilità dell'input degli utenti e di una generale mancanza di consapevolezza tra gli sviluppatori riguardo a questa vulnerabilità. Negli LLM, la finestra di contesto rappresenta la lunghezza massima di testo che il modello può gestire, includendo sia l'input che l'output. È una caratteristica fondamentale degli LLM poiché determina la complessità dei costrutti linguistici che il modello può comprendere e la dimensione del testo che può elaborare in un dato momento. La dimensione della finestra di contesto è definita dall'architettura del modello e può variare in base al modello in uso.

### Esempi Comuni di Vulnerabilità

1. Porre domande (prompts) che portano a un uso ricorrente delle risorse attraverso la generazione di un alto volume di compiti in una coda, ad esempio usando LangChain o AutoGPT.
2. Inviare interrogazioni insolitamente onerose in termini di risorse, usando un'ortografia o delle sequenze di testo insolite.
3. Sovraccarico continuo dell'input: un attaccante invia ripetutamente un flusso di input all'LLM che supera la sua finestra di contesto, causando al modello un consumo eccessivo di risorse computazionali.
4. Input lunghi ripetuti: l'attaccante invia ripetutamente input lunghi all'LLM, ognuno dei quali supera la finestra di contesto.
5. Espansione ricorsiva del contesto: l'attaccante costruisce un input che attiva l'espansione ricorsiva del contesto, forzando l'LLM a espandere e processare ripetutamente la finestra di contesto.
6. Inondazione di input di lunghezza variabile: l'attaccante inonda l'LLM con un grande volume di input di lunghezza variabile, dove ogni input è attentamente costruito per raggiungere appena il limite della finestra di contesto. Questa tecnica mira a sfruttare qualsiasi inefficienza nel trattamento di input di lunghezza variabile, mettendo sotto sforzo l'LLM e potenzialmente causandone il blocco.


### Strategie di Prevenzione e Mitigazione

1. Implementare la validazione e la sanificazione dell'input per garantire che l'input dell'utente rispetti i limiti definiti e sia filtrato qualsiasi contenuto malevolo.
2. Limitare l'uso delle risorse per singola richiesta o singolo passaggio, in modo che le richieste che coinvolgono parti complesse vengano eseguite più lentamente.
3. Applicare limiti di frequenza all'API per contenere il numero di richieste che un singolo utente o indirizzo IP può fare entro un determinato lasso di tempo.
4. Limitare il numero di azioni in coda e il numero totale di azioni in un sistema terzo che risponde alle risposte dell'LLM.
5. Monitorare continuamente l'utilizzo delle risorse dell'LLM per identificare picchi o schemi anomali che potrebbero indicare un attacco DoS.
6. Impostare limiti di input rigorosi basati sulla finestra di contesto dell'LLM per prevenire sovraccarichi ed esaurimento delle risorse.
7. Promuovere la consapevolezza tra gli sviluppatori riguardo alle potenziali vulnerabilità DoS negli LLM e fornire linee guida per l'implementazione sicura dell'LLM.

### Example Attack Scenarios

1. An attacker repeatedly sends multiple difficult and costly requests to a hosted model leading to worse service for other users and increased resource bills for the host.
2. A piece of text on a webpage is encountered while an LLM-driven tool is collecting information to respond to a benign query. This leads to the tool making many more web page requests, resulting in large amounts of resource consumption.
3. An attacker continuously bombards the LLM with input that exceeds its context window. The attacker may use automated scripts or tools to send a high volume of input, overwhelming the LLM's processing capabilities. As a result, the LLM consumes excessive computational resources, leading to a significant slowdown or complete unresponsiveness of the system.
4. An attacker sends a series of sequential inputs to the LLM, with each input designed to be just below the context window's limit. By repeatedly submitting these inputs, the attacker aims to exhaust the available context window capacity. As the LLM struggles to process each input within its context window, system resources become strained, potentially resulting in degraded performance or a complete denial of service.
5. An attacker leverages the LLM's recursive mechanisms to trigger context expansion repeatedly. By crafting input that exploits the recursive behavior of the LLM, the attacker forces the model to repeatedly expand and process the context window, consuming significant computational resources. This attack strains the system and may lead to a DoS condition, making the LLM unresponsive or causing it to crash.
6. An attacker floods the LLM with a large volume of variable-length inputs, carefully crafted to approach or reach the context window's limit. By overwhelming the LLM with inputs of varying lengths, the attacker aims to exploit any inefficiencies in processing variable-length inputs. This flood of inputs puts an excessive load on the LLM's resources, potentially causing performance degradation and hindering the system's ability to respond to legitimate requests.
7. While DoS attacks commonly aim to overwhelm system resources, they can also exploit other aspects of system behavior, such as API limitations. For example, in a recent Sourcegraph security incident, the malicious actor employed a leaked admin access token to alter API rate limits, thereby potentially causing service disruptions by enabling abnormal levels of request volumes.

### Esempi di Scenari di Attacco

1. Un attaccante invia ripetutamente molteplici richieste complesse e costose a un modello in hosting, portando a un peggioramento del servizio per gli altri utenti e ad un aumento delle bollette relative ai consumi delle risorse, nel servizio di hosting.
2. Una sezione di testo su una pagina web viene processata mentre uno strumento guidato da un LLM sta raccogliendo informazioni per rispondere a una query benigna. Questo porta lo strumento a fare molte più richieste di pagine web, risultando in un grande consumo di risorse.
3. Un attaccante bombarda continuamente l'LLM con input che superano la sua finestra di contesto. L'attaccante può utilizzare script automatizzati o strumenti per inviare un alto volume di input, sopraffacendo così le capacità di elaborazione dell'LLM. Di conseguenza, l'LLM consuma risorse computazionali eccessive, portando a un notevole rallentamento o a una completa mancanza di risposta da parte del sistema che lo ospita.
4. Un attaccante invia una serie di input sequenziali all'LLM, in cui ciascun input è progettato per essere appena sotto il limite della finestra di contesto. Inviando ripetutamente questi input, l'attaccante mira a esaurire la capacità disponibile della finestra. Mentre l'LLM fatica a elaborare ciascun input all'interno della sua finestra di contesto, le risorse del sistema si riducono drasticamente, risultando nel degradamento delle prestazioni o in un completo diniego del servizio (DoS).
5. Un attaccante sfrutta i meccanismi ricorsivi dell'LLM per causare ripetutamente l'espansione del contesto. Creando un input che stimola il comportamento ricorsivo dell'LLM, l'attaccante costringe il modello a espandere e processare ripetutamente la finestra di contesto, consumando una significativa quantità di risorse computazionali. Questo attacco mette sotto sforzo il sistema e può portare a una condizione di DoS, rendendo l'LLM non reattivo o causandone il fermo totale.
6. Un attaccante inonda l'LLM con un grande volume di input di lunghezza variabile, attentamente costruiti per avvicinarsi o raggiungere il limite della finestra di contesto. Sopraffacendo l'LLM con input di lunghezze variabili, l'attaccante mira a sfruttare qualsiasi inefficienza nell'elaborazione di questo tipo di input. Questo sovraccarico pesa eccessivamente sulle risorse dell'LLM, causando un potenziale degradamento delle prestazioni e ostacolando la capacità del sistema di rispondere a richieste legittime.
7. Mentre gli attacchi DoS mirano comunemente a sopraffare le risorse del sistema, possono anche sfruttare altri aspetti del comportamento del sistema, come le limitazioni dell'API. Ad esempio, in un recente incidente di sicurezza subìto da Sourcegraph, l'attore malevolo ha utilizzato un token di accesso amministrativo trapelato per alterare i limiti di frequenza dell'API, causando potenzialmente interruzioni del servizio, avendo abilitato livelli anomali di volumi di richieste.

### Referenze e Link (Inglese)

1. [LangChain max_iterations](https://twitter.com/hwchase17/status/1608467493877579777): **hwchase17 on Twitter**
2. [Sponge Examples: Energy-Latency Attacks on Neural Networks](https://arxiv.org/abs/2006.03463): **Arxiv White Paper**
3. [OWASP DOS Attack](https://owasp.org/www-community/attacks/Denial_of_Service): **OWASP**
4. [Learning From Machines: Know Thy Context](https://lukebechtel.com/blog/lfm-know-thy-context): **Luke Bechtel**
5. [Sourcegraph Security Incident on API Limits Manipulation and DoS Attack ](https://about.sourcegraph.com/blog/security-update-august-2023): **Sourcegraph**
