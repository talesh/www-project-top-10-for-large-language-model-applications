OWASP Top 10 per gli LLM
Versione 1.0
Pubblicato: 1 agosto 2023






L’interesse per i modelli di linguaggio a grandi dimensioni (LLM, dall’inglese Large Language Models) a seguito dell’introduzione sul mercato di massa dei chatbot pre-addestrati a fine 2022 è stato notevole. Le aziende, impazienti di sfruttare il potenziale degli LLM, stanno rapidamente integrandoli nei loro sistemi e nelle offerte destinate ai clienti. Ciò nonostante, l’incredibile velocità alla quale gli LLM stanno venendo adottati ha superato il tempo necessario a stabilire dei protocolli di sicurezza completi, lasciando molte applicazioni vulnerabili a problemi di alto rischio.


L’assenza di una risorsa unificata che affrontasse questi problemi di sicurezza per gli LLM era evidente. Gli sviluppatori, non essendo familiari con i rischi associati con gli LLM, sono stati lasciati con risorse sparse e la missione di OWASP sembrava prestarsi perfettamente ad aiutare a guidare un’adozione sicura di questa tecnologia.


A chi si rivolge questo documento?
Il nostro pubblico principale sono sviluppatori, data scientist e esperti di sicurezza incaricati di pianificare e costruire applicazioni e plugin basati su tecnologie LLM. Il nostro obiettivo è fornire una guida pratica e concisa per aiutare questi professionisti a muoversi nel terreno complesso ed in continua evoluzione della sicurezza degli LLM.


La creazione della lista


La creazione dell’OWASP Top 10 per gli LLM è stata un’impresa significativa, basata sull’esperienza collettiva di un gruppo internazionale di quasi 500 esperti, con più di 125 contributori attivi. I nostri collaboratori provengono da contesti diversi, che includono aziende nel dominio dell’intelligenza artificiale, aziende di sicurezza, editori di software indipendenti, piattaforme cloud e hyperscale, e il mondo della ricerca accademica.


Nel corso di un mese, abbiamo discusso e proposto potenziali vulnerabilità e i membri del gruppo hanno considerato fino a 43 minacce distinte. Attraverso molteplici round di selezione, abbiamo ridotto queste proposte fino ad arrivare a una lista concisa delle 10 vulnerabilità più critiche. Ogni vulnerabilità è stata poi analizzata e rifinita da sotto-gruppi specializzati e infine sottoposta a una revisione pubblica per assicurare che la lista finale fosse il più possibile completa e concretamente applicabile.
Il confronto con le altre liste OWASP Top 10


Anche se la nostra lista condivide il DNA con i tipi di vulnerabilità che si possono trovare nelle altre liste OWASP Top 10, non ci limitiamo a reiterare queste vulnerabilità, ma analizziamo le implicazioni uniche che queste vulnerabilità hanno quando appaiono in applicazioni basate sugli LLM.


Il nostro obiettivo è di fare da ponte tra i principi generali di sicurezza delle applicazioni e le sfide specifiche poste dagli LLM. Questo include l’esplorazione di come le vulnerabilità tradizionali possano porre rischi differenti o possano essere sfruttate in nuovi modi con gli LLM, e come i rimedi tradizionali debbano essere adattati alle applicazioni basate sugli LLM.


Il futuro


La prima versione di questa lista non sarà l’ultima. Ci aspettiamo di aggiornare questa lista periodicamente, per stare al passo con l’evoluzione della tecnologia. Lavoreremo con la comunità per far evolvere la tecnologia e per creare altro materiale di studio per una serie di casi d’uso. Miriamo inoltre a collaborare con gli organismi di standardizzazione e i governi a riguardo della sicurezza dell’intelligenza artificiale. Ti invitiamo a unirti al nostro gruppo e contribuire.




Steve Wilson
Responsabile del progetto OWASP Top 10 per gli LLM
Twitter/X: @virtualsteve






OWASP Top 10 per gli LLM


LLM01: Iniezione di prompt
Manipola un modello di linguaggio di grandi dimensioni (LLM) attraverso input ingegnosi, causando azioni indesiderate da parte dell’LLM. Le iniezioni dirette sovrascrivono i prompt di sistema, mentre quelle indirette manipolano gli input da fonti esterne.


LLM02: Gestione non sicura dell’output
Questa vulnerabilità si verifica quando l’output di un LLM è accettato senza un controllo accurato, esponendo i sistemi backend. Lo può condurre a conseguenze rischiose come XSS, CSRF, SSRF, privilege escalation, o esecuzione di codice da remoto (RCE).


LLM03: Avvelenamento dei dati di addestramento
Questo accade quando i dati di addestramento di un LLM vengono manomessi, introducendo vulnerabilità o bias che compromettono la sicurezza, efficacia o comportamento etico. Le fonti di dati includono Common Crawl, WebText, OpenWebText e libri.


LLM04: Denial of service del modello
Un attaccante può causare operazioni dell’LLM che richiedono un importante dispendio di risorse, inducendo una degradazione del servizio o dei costi elevati. La vulnerabilità è accentuata dalla natura esosa di risorse degli LLM e dall’imprevedibilità degli input degli utenti.


LLM05: Vulnerabilità della filiera
Il ciclo di vita di un’applicazione LLM può essere compromesso da componenti o servizi vulnerabili, conducendo a degli attacchi di sicurezza. Usare componenti o servizi di terze parti, modelli pre-addestrati e plugin può accrescere le vulnerabilità.


LLM06: Divulgazione di informazioni sensibili
Gli LLM possono inavvertitamente rivelare dati confidenziali nelle loro risposte, causando accesso non autorizzato, violazioni della privacy e falle di sicurezza. È cruciale implementare sanificazione dei dati e politiche d’uso rigorose per mitigare questo fenomeno.


LLM07: Design insicure di plugin
I plugin LLM possono avere input non sicuri e controlli d’accesso insufficienti. La mancanza di controllo applicativo li rende più facili da sfruttare e può risultare in conseguenze gravi come l’esecuzione di codice da remoto (RCE)..


LLM08: Operatività eccessiva
I sistemi basati sugli LLM possono intraprendere azioni che conducono a conseguenze indesiderate. Il problema nasce dal conferimento di funzionalità, permessi, o autonomia eccessiva al sistema LLM.


LLM09: Dipendenza eccessiva
Sistemi o persone che dipendono troppo dagli LLM senza supervisione possono subire disinformazione, errata comunicazione, problemi legali e vulnerabilità di sicurezza legate all’uso errato o inappropriato del contenuto generato dagli LLM.


LLM10: Furto di modello
Questa vulnerabilità si riferisce all’accesso non autorizzato, la copia o il trafugamento di modelli LLM proprietari. L’impatto include perdite economiche, perdita del vantaggio competitivo e potenziale accesso a informazioni sensibili.




