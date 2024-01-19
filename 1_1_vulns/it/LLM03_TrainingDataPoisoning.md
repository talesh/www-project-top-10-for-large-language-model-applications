## LLM03: Avvelenamento dei dati di apprendimento

### Descrizione

Il punto di partenza di qualsiasi approccio di machine learning (apprendimento automatico) è costituito dai dati di addestramento, semplicemente del "testo grezzo". Per essere sviluppare un modello con capacità elevate (ad esempio, che abbia conoscenze linguistiche e del mondo), questo testo deve coprire un'ampia gamma di domini, generi e lingue. Un grande modello di linguaggio utilizza reti neurali profonde per generare output basati su pattern appresi dai dati di apprendimento.

L'avvelenamento dei dati di apprendimento si riferisce alla manipolazione dei dati usati nel processi di pre-apprendimento (pre-training), di fine-tuning o di embedding, al fine di introdurre delle vulnerabilità (che hanno tutte vettori di attacco unici e a volte condivisi), backdoor o bias che potrebbero compromettere la sicurezza, l'efficacia o il comportamento etico del modello. Le informazioni avvelenate possono essere presentate agli utenti o creare altri rischi come la degradazione delle prestazioni, l'exploit del software downstream e danni alla reputazione. Anche se gli utenti non si fidano dell'output problematico dell'IA, i rischi rimangono, comprese le capacità compromesse del modello e potenziali danni alla reputazione del marchio.

- Il pre-apprendimento si riferisce al processo di addestramento di un modello basato su un compito o un set di dati.
- Il fine-tuning consiste nel prendere un modello esistente che è già stato addestrato e riadattarlo a un dominio più ristretto o a un obiettivo più focalizzato, addestrandolo utilizzando uno specifico set di dati. Questo set di dati include tipicamente esempi di input e i corrispondenti output desiderati.
- Il processo di embedding è il processo di conversione di dati categorici (spesso testo) in una rappresentazione numerica che può essere utilizzata per addestrare un modello di linguaggio. L'embedding comporta la rappresentazione di parole o frasi dai dati di testo come vettori in uno spazio vettoriale continuo. I vettori sono solitamente generati passando dati di testo attraverso una rete neurale che è stata addestrata su un ampio corpus di testo.

L'avvelenamento dei dati è considerato un attacco di integrità perché la manipolazione dei dati di addestramento influisce sulla capacità del modello di produrre previsioni corrette. Naturalmente, le fonti di dati esterne presentano un rischio maggiore poiché i creatori del modello non hanno controllo sui dati né un alto livello di fiducia che il contenuto non contenga bias, informazioni falsificate o contenuti inappropriati.

### Esempi comuni di vulnerabilità

1. Un attore malintenzionato o un concorrente crea intenzionalmente dei documenti inaccurati o malevoli, che sono indirizzati al pre-addestramento, fine-tuning o al processo di embedding. Considerate entrambi i vettori di attacco di [Split-View Data Poisoning](https://github.com/GangGreenTemperTatum/speaking/blob/main/dc604/hacker-summer-camp-23/Ads%20_%20Poisoning%20Web%20Training%20Datasets%20_%20Flow%20Diagram%20-%20Exploit%201%20Split-View%20Data%20Poisoning.jpeg) (avvelenamento da vista separata) e [Frontrunning Poisoning](https://github.com/GangGreenTemperTatum/speaking/blob/main/dc604/hacker-summer-camp-23/Ads%20_%20Poisoning%20Web%20Training%20Datasets%20_%20Flow%20Diagram%20-%20Exploit%202%20Frontrunning%20Data%20Poisoning.jpeg) (avvelenamento per anticipazione) come esempi.
   1. Il modello vittima si allena utilizzando informazioni falsificate che si riflettono negli output che il modello di IA generativa fornisce ai suoi fruitori.
2. Un attore malintenzionato è in grado di iniettare direttamente dei contenuti falsificati, tendenziosi o pericolosi nei processi di addestramento di un modello, facendo così in modo che questi contenuti vengano poi restituiti negli output del modello.
3. Un utente ignaro inietta indirettamente dati sensibili o proprietari nei processi di addestramento di un modello, che vengono poi restituiti negli output successivi.
4. Un modello è addestrato usando dati la cui fonte, origine o contenuto non sono stati sottoposti a verifica in nessuna delle fasi addestramento, il che può portare a risultati errati se i dati sono contaminati o non corretti.
5. L'accesso senza restrizioni all'infrastruttura o un sandboxing inadeguato possono consentire a un modello di acquisire dati di addestramento non sicuri, con conseguenti output tendenziosi o dannosi. Questo esempio può verificarsi in una qualsiasi delle fasi di addestramento.
   1. In questo scenario, l'input che un utente fornisce al modello può essere riflesso nell'output di un altro utente (portando a una violazione), oppure l'utente di un LLM può ricevere dal modello output inesatti, irrilevanti o dannosi a seconda del tipo di dati ingeriti, secondo il caso d'uso del modello (di solito riportati nella model card).

*Che siate sviluppatori, clienti o consumatori generici di un LLM, è importante comprendere come questa vulnerabilità potrebbe riflettersi sui rischi all'interno della vostra applicazione LLM quando questa interagisce con un LLM non proprietario, per comprendere la legittimità degli output del modello in base alle sue procedure di addestramento. Allo stesso modo, gli sviluppatori dell'LLM potrebbero essere a rischio di attacchi diretti e indiretti ai dati interni o di terze parti utilizzati per il fine-tuning e l'embedding (il più comune), comportando un rischio per tutti i suoi consumatori.*

### Strategie di prevenzione e mitigazione

1. Verificare la filiera di approvvigionamento dei dati di addestramento, soprattutto quando sono ottenuti da fonti esterne, nonché mantenere attestazioni tramite la metodologia "ML-BOM" (Machine Learning Bill of Materials) e verificare le model card.
2. Verificare la corretta legittimità delle fonti di dati e dei dati ottenuti durante le fasi di pre-apprendimento, fine-tuning e embedding.
3. Verificare il caso d'uso dell'LLM e l'applicazione a cui questo viene integrato. Creare modelli diversi tramite dati di addestramento separati o fine-tuning per casi d'uso diversi per creare un output di IA generativa più granulare e accurato in base al caso d'uso definito.
4. Garantire un sandboxing sufficiente tramite i controlli di rete, per impedire al modello di estrarre dati da fonti non previste, che potrebbero compromettere l'output dell'apprendimento automatico.
5. Adottare un controllo rigoroso o filtri di input per dati di addestramento specifici o categorie di fonti di dati, per mantenere sotto controllo il volume di dati falsificati. Sanificare i dati con tecniche come la rilevazione statistica degli outlier o il rilevamento delle anomalie, per identificare e rimuovere i dati avversari che potrebbero essere inseriti nel processo di fine-tuning.
6. Elaborare domande di controllo attorno alla fonte e alla proprietà dei set di dati per garantire che il modello non sia stato avvelenato, e adottare questa cultura nel ciclo di vita "MLSecOps". Fare riferimento a risorse disponibili come [The Foundation Model Transparency Index](https://crfm.stanford.edu/fmti/) o [Open LLM Leaderboard](https://huggingface.co/spaces/HuggingFaceH4/open_llm_leaderboard) per esempio.
7. Usare DVC ([Data Version Control](https://dvc.org/doc/user-guide/analytics)) per identificare e tenere traccia in modo rigoroso di una parte di un set di dati che potrebbe essere stata manipolata, eliminata o aggiunta, portando all'avvelenamento.
8. Usare database vettoriali per aggiungere informazioni fornite dall'utente, che permettono di proteggere gli utenti dall'avvelenamento e persino correggere in produzione senza dover riaddestrare un nuovo modello.
9. Tecniche di robustezza avversaria come l'apprendimento federato (federated learning) e vincoli per minimizzare gli effetti di outlier o addestramento avversariale per essere resistenti alle peggiori perturbazioni dei dati di addestramento.
   1. Un approccio "MLSecOps" potrebbe essere quello di includere la robustezza avversaria nel ciclo di vita dell'addestramento con la tecnica di auto-avvelenamento.
   2. Un esempio di questo approccio è [Autopoison](https://github.com/azshue/AutoPoison), che include test per attacchi come l'iniezione diretta di contenuto ("tentativo di promuovere un marchio nelle risposte del modello") e l'attacco di rifiuto ("fare in modo che il modello rifiuti sempre di rispondere").
10. Testare e rilevare, misurando la perdita durante la fase di addestramento e analizzando i modelli addestrati per rilevare segni di un attacco di avvelenamento, controllando il comportamento del modello su input di test specifici.
   1. Monitorare e segnalare il numero di risposte distorte che superano una soglia.
   2. Usare una validazione umana per fare un audit delle risposte.
   3. Implementare LLM dedicati per mettere alla prova i modelli rispetto a conseguenze indesiderate e addestrare altri LLM usando [tecniche di apprendimento per rinforzo](https://wandb.ai/ayush-thakur/Intro-RLAIF/reports/An-Introduction-to-Training-LLMs-Using-Reinforcement-Learning-From-Human-Feedback-RLHF---VmlldzozMzYyNjcy).
   4. Eseguire esercitazioni di tipo [red team](https://www.anthropic.com/index/red-teaming-language-models-to-reduce-harms-methods-scaling-behaviors-and-lessons-learned) basate su LLM o [scansioni di vulnerabilità LLM](https://github.com/leondz/garak) nelle fasi di test del ciclo di vita dell'LLM.


### Esempi di scenari d'attacco

1. L'output di un'IA generativa può indurre in errore gli utenti dell'applicazione, portando a opinioni tendenziose o, peggio ancora, crimini d'odio, ecc. tendenziosi.
2. Se i dati di apprendimento non sono correttamente filtrati e/o sanificati, un utente malintenzionato potrebbe cercare di influenzare e iniettare dati tossici nel modello per farlo adattare ai dati falsificati e tendenziosi.
3. Un attore malintenzionato o un concorrente crea intenzionalmente dei documenti inaccurati o malevoli che sono indirizzati ai dati di addestramento di un modello, che viene addestrato allo stesso tempo in base agli input. Il modello vittima si addestra utilizzando informazioni falsificate che si riflettono negli output che il modello di IA generativa fornisce ai suoi fruitori.
4. L'iniezione di prompt (LLM01) potrebbe essere un vettore di attacco per questa vulnerabilità se non viene eseguita una sanitizzazione e un filtraggio sufficienti quando gli input degli utenti sono usati per addestrare il modello. Ad esempio, se i dati dannosi o falsificati vengono inseriti nel modello da un utilizzatore come parte di una tecnica di iniezione di prompt, questo potrebbe essere intrinsecamente rappresentato nei dati del modello.

### Riferimenti e link (inglese)

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
