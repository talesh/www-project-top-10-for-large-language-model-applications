## LLM09: Eccessivo affidamento

### Descrizione

L'eccessivo affidamento si manifesta quando un LLM produce risultati erronei, ma li presenta in maniera autoritativa.
Mentre gli LLM usualmente producono materiale creativo ed informativo, questi possono anche generare contenuti fattualmente scorretti, inappropriati o pericolosi. Questo fenomeno è noto sotto il nome di allucinazione o confabulazione. Quando persone o sistemi si affidano a queste informazioni, senza supervisionarle o confermarle, si può generare un'infrazione di sicurezza, disinformazione, comunicazione errata, problemi legali, e danni reputazionali.

Codice Sorgente generato da LLM, può introdurre silenziosamente delle vulnerabilità di sicurezza. Ciò espone a rischi significativi per la salute operativa, e la sicurezza delle applicazioni. Questi rischi ricordano l'importanza di continui processi di verifica, attraverso:
* Supervisione
* Meccanismi di validazione continua
* Note agli utilizzatori sui rischi connessi all'utilizzo

### Esempi comuni di vulnerabilità

1. Un LLM fornisce informazioni inaccurate come risposta, esprimendola in una maniera che la fa apparire fortemente autoritativa. L'intero sistema è disegnato senza appropriati controlli ed equilibrio per gestire questi casi e le informazioni sviano l'utente in maniera da generare potenziali danni.
2. Un LLM suggerisce codice insicuro o difettoso, insediando vulnerabilità quando incorporato in un sistema software senza controlli preventivi o verifiche puntuali su di esso.

### Strategie di Mitigazione e Prevenzione

1. Monitoraggio costante e revisione degli output dell'LLM. Utilizzo di tecniche rivolte all'auto-consistenza o le tecniche di voto per filtrare testo inconsistente. La comparazione delle diverse risposte del modello per un singolo prompt può portare ad un miglior giudizio della qualità e della consistenza degli output.
2. Controlli incrociati sul modello rispetto a fonti esterne certificate. Questo livello aggiuntivo di validazione può aiutare ad assicurare che le informazioni prodotte dal modello siano accurate e affidabili.
3. Migliorare il modello con metodi di taratura fine (fine-tuning) o incorporazione (embedding) per migliorare la qualità degli output. Modelli generici pre-addestrati possono generare informazioni inaccurate con maggiore probabilità rispetto a modelli addestrati su un dominio specifico. Tecniche come l'ingegnerizzazione dei prompt, ottimizzazione efficiente dei parametri (PET), Ottimizzazione dell'intero modello, e prompting basato su catena di pensiero (chain of thoughts prompting) possono essere impiegati allo scopo.
4. Implementazione di meccanismi di validazione automatica che possono effettuare controlli comparativi sugli output generati, rispetto a fatti o dati ben noti. Questo può fornire un livello di sicurezza aggiuntiva e mitigare i rischi associati alle allucinazioni.
5. Suddivisione di compiti complessi in singole azioni parziali più gestibili, ed assegnazione ad agenti specializzati. Questo non solo aiuta a gestire la complessità, ma anche a ridurre le probabilità di allucinazione essendo ogni agente responsabile di obiettivi più gestibili.
6. Comunicare chiaramente i rischi e le limitazioni associate con l'utilizzo degli LLM. Ciò include potenziale inaccuratezza delle informazioni, ed altri rischi. Una chiara comunicazione dei rischi prepare gli utenti a potenziali problemi e aiutarli a prendere decisioni informate.
7. Costruire API ed interfacce utente che incoraggino un utilizzo responsabile degli LLM. Questo include misure come filtri di contenuti, notifiche all'utente di possibile inaccuratezza e chiara marcatura dei materiali generati dall'AI.
8. Quando si utilizzano LLM in ambienti di sviluppo, vanno stabiliti criteri di codifica sicura e linee guida che prevengano l'inclusione di possibili vulnerabilità. 

### Esempi di Scenari D'Attacco

1. Una testata giornalistica utilizza pesantemente un LLM per generare i propri articoli e notizie. Un malintenzionato può approfitteìare di questa eccessiva dipendenza, iniettando nel LLM informazioni fuorvianti, che favoriscano la diffusione di notizie false o mirate.
2. L'intelligenza artificiale plagia contenuti anche se non intenzionalmente, portando a problemi di proprietà intellettuale che minano la credibilità dell'organizzazione.
3. Un team di sviluppo software utilizza un LLM per accelerare il processo di codifica. Un'eccessiva dipendenza dai suggerimenti dell'AI introduce vulnerabilità nelle applicazioni generate a causa di parametri di default non modificati o raccomandazioni inconsistenti con le pratiche di sviluppo sicuro.
4. Un'azienda che si occupa di sviluppo software utilizza un LLM per fornire assistenza agli sviluppatori. Il modello suggerisce una libreria o un pacchetto inesistenti e uno sviluppatore, affidandosi all'AI, integra senza saperlo un pacchetto malevolo nel software venduto dall'azienda. Questo esempio sottolinea l'importanza dei controlli incrociati sui suggerimenti del modello, in particolare quando questi si riferiscono a codice o librerie di terze parti.

### Link e Riferimenti (Inglese)

1. [Understanding LLM Hallucinations](https://towardsdatascience.com/llm-hallucinations-ec831dcd7786): **Towards Data Science**
2. [How Should Companies Communicate the Risks of Large Language Models to Users?](https://techpolicy.press/how-should-companies-communicate-the-risks-of-large-language-models-to-users/): **Techpolicy**
3. [A news site used AI to write articles. It was a journalistic disaster](https://www.washingtonpost.com/media/2023/01/17/cnet-ai-articles-journalism-corrections/): **Washington Post**
4. [AI Hallucinations: Package Risk](https://vulcan.io/blog/ai-hallucinations-package-risk): **Vulcan.io**
5. [How to Reduce the Hallucinations from Large Language Models](https://thenewstack.io/how-to-reduce-the-hallucinations-from-large-language-models/): **The New Stack**
6. [Practical Steps to Reduce Hallucination](https://newsletter.victordibia.com/p/practical-steps-to-reduce-hallucination): **Victor Debia**
