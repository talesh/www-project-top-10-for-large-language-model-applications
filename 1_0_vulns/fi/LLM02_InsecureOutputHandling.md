LLM02: Turvaton vasteen käsittely


Turvaton vasteen käsittely on haavoittuvuus, joka ilmenee kun alemman tason komponentti hyväksyy suuren kielimallin vasteen ilman tarkastelua. Esimerkki tästä on mallin vasteen välittäminen suoraan palvelinpäälle, etuoikeutetuille tai asiakaspään funktioille. Koska suuren kielimallin generoimaa sisältöä voidaan hallita kehotteen syötteestä, käytös on verrannollinen käyttäjien luvattomaan pääsyyn lisätoiminnallisuuteen.


Turvattoman vasteen käsittelyn onnistunut hyväksikäyttö voi johtaa XSS- tai CSRF-tyyppisiin haavoittuvuuksiin selaimissa. Lisäksi se voi johtaa SSRF-haavoittuvuuteen, käyttöoikeuksien laajentamiseen tai koodin etäajohyökkäykseen palvelinpään järjestelmissä. Seuraavat ehdot voivat lisätä haavoittuvuuten vaikuttavuutta:


* Ohjelmisto antaa suurelle kielimallille suuremmat oikeudet kuin mitä loppukäyttäjille on tarkoitettu. Tämä mahdollistaa käyttöoikeuksien laajentamisen tai koodin etäajohyökkäyksen.
* Ohjelmisto on haavoittuvainen ulkoiselle kehoteinjektiohyökkäykselle. Tämä saattaa mahdollistaa hyökkääjän etuoikeutetun pääsyn kohteena olevan käyttäjän ympäristöön.


Yleisiä esimerkkejä haavoittuvuudesta


1. Suuren kielimallin vaste syötetään suoraan systeemitason komentotulkkiin (shell) tai vastaavan funktioon kuten exec tai eval. Tämä johtaa koodin etäajohyökkäykseen. 
2. Suuri kielimalli generoi ja palauttaa käyttäjälle JavaScript- tai Markdown-koodia, joka tulkitaan selaimen toimesta johtaen XSS-haavoittuvuuteen.
Estäminen


1. Kohtele mallia kuten mitä tahansa käyttäjää ja sovella kunnollista syötteen validaatiota mallilta palvelinpään funktioille kulkeviin vastaukseen. Seuraa OWASP ASVS:än (Application Security Verification Standard) mukaisia ohjeita varmistuaksesi tehokkaasta syötteen validoinnista ja sanitoinnista.
2. Koodaa (encode) mallin käyttäjillä menevä vaste vaste mitigoidaksesi ei-toivotun koodin (kuten JavaScript tai Markdown) suorittamisen. OWASP ASVS sisältää yksityiskohtaista tietoa vasteen koodauksesta.
Esimerkkejä hyökkäysskenaarioista


1. Ohjelmisto käyttää LLM-liitännäistä chatbot-vastausten generoimiseksi. Ohjelmisto kuitenkin välittää suuren kielimallin generoiman vastauksen suoraan sisäiselle funktiolle, jonka vastuulla on suorittaa systeemitason komentoja ilman validaatiota. Tämä sallii hyökkääjän manipuloida mallin vastetta mielivaltaisten järjestelmäkomentojen suorittamiseksi. Tämä johtaa valtuuttamattomaan pääsyyn tai ei-haluttuihin järjestelmämuutoksiin.
2. Käyttäjä käyttää suurta kielimallia hyödyntävää sivustontiivistäjätyökalua generoimaan tiivistelmän sivuston artikkelista. Sivustolla on kehoteinjektio, joka ohjeistaa mallia kaappaamaan arkaluontoista sisältöä sivustolta tai käyttäjän keskustelusta. Tämän avulla malli voi koodata (encode) datan ja lähettää sen hyökkääjän hallinnoimalle palvelimelle.
3. Suuri kielimalli sallii käyttäjien luoda SQL-kyselyitä palvelinpään tietokantaan chat-ominaisuuden avulla. Käyttäjä luo kyselyn kaikkien tietokannan taulujen poistamiseksi. Jos malli ei tarkista kyselyä, kaikki taulut poistetaan.
4. Pahantahtoinen käyttäjä ohjeistaa suurta kielimallia palauttamaan tarkistamatonta JavaScript-koodia käyttäjälle. Tämä voi aiheutua kehotteen jakamisesta, sivuston kehoteinjektiosta tai chat-botista joka hyväksyy kehotteen URL-parametrista. Malli palauttaa puhdistamattoman (unsanitized) XSS-payloadin käyttäjälle. Ilman ylimääräistä suodatusta (muu kuin mallin odottama), JavaScript-koodi suoritetaan käyttäjän selaimessa.
Linkkejä
1. Snyk Vulnerability DB- Arbitrary Code Execution: https://security.snyk.io/vuln/SNYK-PYTHON-LANGCHAIN-5411357
2. ChatGPT Plugin Exploit Explained: From Prompt Injection to Accessing Private Data: https://embracethered.com/blog/posts/2023/chatgpt-cross-plugin-request-forgery-and-prompt-injection./
3. New prompt injection attack on ChatGPT web version. Markdown images can steal your chat data: https://systemweakness.com/new-prompt-injection-attack-on-chatgpt-web-version-ef717492c5c2
4. Don't blindly trust LLM responses. Threats to chatbots: https://embracethered.com/blog/posts/2023/ai-injections-threats-context-matters/
5. Threat Modeling LLM Applications: https://aivillage.org/large%20language%20models/threat-modeling-llm/
6. OWASP ASVS - 5 Validation, Sanitization and Encoding: https://owasp-aasvs4.readthedocs.io/en/latest/V5.html#validation-sanitization-and-encoding




